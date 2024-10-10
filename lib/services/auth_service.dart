// auth_service page

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecosphere/pages/welcome_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:ecosphere/pages/home.dart';
import 'package:ecosphere/pages/login.dart';

class AuthService {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signup({
    required String email,
    required String password,
    required String name,      // Parameter for name
    required String city,       // Parameter for city
    required String phone,      // Parameter for phone number
    required BuildContext context,
  }) async {
    // Validate that none of the fields are empty
    if (email.isEmpty || password.isEmpty || name.isEmpty || city.isEmpty || phone.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please fill in all fields.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return; // Stop the signup process if any field is empty
    }

    // Phone number validation regex (exactly 10 digits)
    String phonePattern = r'^[0-9]{10}$';
    RegExp regExp = RegExp(phonePattern);

    // Check if the phone number is valid (10 digits)
    if (!regExp.hasMatch(phone)) {
      Fluttertoast.showToast(
        msg: "Invalid phone number. Please enter a 10-digit phone number.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return; // Stop the signup process if the phone number is invalid
    }

    try {
      // Try signing up the user with Firebase
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the signed-up user
      User? user = userCredential.user;

      // Store additional user info in Firestore under a 'users' collection
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
        'name': name,
        'email': email,
        'city': city,
        'phone': phone,
      });

      // Navigate to the WelcomeScreen after successful sign-up
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (BuildContext context) => const WelcomeScreen()),
      );

    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email.';
      } else {
        message = "Something went wrong. Please try again.";
      }

      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      log(e.toString());
    }
  }


  Future<void> signin({
    required String email,
    required String password,
    required BuildContext context
  }) async {
    
    try {

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
      );

      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const WelcomeScreen()
        )
      );
      
    } on FirebaseAuthException catch(e) {
      String message = '';
      if (e.code == 'invalid-email') {
        message = 'No user found for that email.';
      } else if (e.code == 'invalid-credential') {
        message = 'Wrong password provided for that user.';
      }
      Fluttertoast.showToast(
        msg: message.isNotEmpty ? message : "Something went wrong. Please try again.", // Ensure message is not empty
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,   // Display toast at the bottom of the screen (adjust as needed)
        backgroundColor: Colors.black54, // Toast background color
        textColor: Colors.white,         // Text color
        fontSize: 16.0,                  // Text size to be more readable
      );

    }
    catch(e){
      log(e.toString());
    }

  }

  Future<void> signout({
    required BuildContext context
  }) async {
    
    await FirebaseAuth.instance.signOut();
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (BuildContext context) =>Login()
        )
      );
  }

  // user name
  Future<String?> getUserName() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

      if (userDoc.exists) {
        return userDoc.get('name');
      }
    }
    return null; // Return null if user doesn't exist or isn't logged in
  }
}