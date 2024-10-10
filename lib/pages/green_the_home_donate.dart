import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'donation_success_page.dart';

class GreenTheHomeDonate extends StatefulWidget {
  @override
  State<GreenTheHomeDonate> createState() => _GreenTheHomeDonateState();
}

class _GreenTheHomeDonateState extends State<GreenTheHomeDonate> {
  var _selectedOption = "";
  var _selectedValue = "";
  var _flag = false;
  var _selectedPMethod = "";

  File? _image; // To hold the selected image

  // Function to pick image
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Store the selected image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    final style1 = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.primary,
    );
    final style2 =
        TextStyle(letterSpacing: 5, color: theme.colorScheme.primary);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Green the Home', style: style1),
                        Text(
                          'Plant distribution program',
                          style: style2,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Donate Now  ',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.secondary),
                    ),
                    Icon(
                      Icons.volunteer_activism,
                      size: 40,
                      color: theme.colorScheme.secondary,
                    )
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Join our indoor plant distribution program to bring more greenery into your home. '
                    'We provide a variety of indoor plants that are easy to care for and perfect for any living space. '
                    'Sign up today and start your journey towards a greener, healthier home!',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: ListTile(
                        title: const Text('One Time'),
                        leading: Radio<String>(
                          value: 'no_repeat',
                          groupValue: _selectedOption,
                          onChanged: (String? value) {
                            setState(() {
                              _selectedOption = value!;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text('Monthly'),
                        leading: Radio<String>(
                          value: 'monthly',
                          groupValue: _selectedOption,
                          onChanged: (String? value) {
                            setState(() {
                              _selectedOption = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedValue = "100";
                          _flag = false;
                        });
                      },
                      style: _selectedValue == "100"
                          ? ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                              foregroundColor: theme.colorScheme.onPrimary,
                            )
                          : ElevatedButton.styleFrom(),
                      child: Text('100LKR'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedValue = "200";
                          _flag = false;
                        });
                      },
                      style: _selectedValue == "200"
                          ? ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                              foregroundColor: theme.colorScheme.onPrimary,
                            )
                          : ElevatedButton.styleFrom(),
                      child: Text('200LKR'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedValue = "500";
                          _flag = false;
                        });
                      },
                      style: _selectedValue == "500"
                          ? ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                              foregroundColor: theme.colorScheme.onPrimary,
                            )
                          : ElevatedButton.styleFrom(),
                      child: Text('500LKR'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedValue = "1000";
                          _flag = false;
                        });
                      },
                      style: _selectedValue == "1000"
                          ? ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                              foregroundColor: theme.colorScheme.onPrimary,
                            )
                          : ElevatedButton.styleFrom(),
                      child: Text('1000LKR'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _showCustomAmountDialog(context);
                      },
                      style: _flag
                          ? ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                              foregroundColor: theme.colorScheme.onPrimary,
                            )
                          : ElevatedButton.styleFrom(),
                      child: _flag
                          ? Text('$_selectedValue\LKR')
                          : Text('Custom Amount'),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Text(
                      'Choose Payment Method  ',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.secondary),
                    ),
                    Icon(
                      Icons.playlist_add_check_circle,
                      size: 40,
                      color: theme.colorScheme.secondary,
                    )
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _selectedPMethod = "card";
                          _flag = false;
                        });
                      },
                      style: _selectedPMethod == "card"
                          ? ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                              foregroundColor: theme.colorScheme.onPrimary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            )
                          : ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                      label: Text('Credit/Debit Card'),
                      icon: Icon(Icons.credit_card),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _selectedPMethod = "paypal";
                          _flag = false;
                        });
                      },
                      style: _selectedPMethod == "paypal"
                          ? ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                              foregroundColor: theme.colorScheme.onPrimary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            )
                          : ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                      label: Text('PayPal'),
                      icon: Icon(Icons.paypal),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _selectedPMethod = "mobile";
                          _flag = false;
                        });
                      },
                      style: _selectedPMethod == "mobile"
                          ? ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                              foregroundColor: theme.colorScheme.onPrimary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            )
                          : ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                      label: Text('Mobile Pay'),
                      icon: Icon(Icons.mobile_friendly),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _selectedPMethod = "bank";
                          _flag = false;
                        });
                      },
                      style: _selectedPMethod == "bank"
                          ? ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                              foregroundColor: theme.colorScheme.onPrimary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            )
                          : ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                      label: Text('Bank Transfer'),
                      icon: Icon(Icons.account_balance),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(20.0),
                    fixedSize: Size(300, 80),
                    textStyle: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    elevation: 15,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  onPressed: () {
                    print(
                        'selected: $_selectedOption, $_selectedValue, $_selectedPMethod');
                    _showPayNowDialog(context);
                  },
                  // child: Text('Donate'),
                  icon: Icon(
                    Icons.volunteer_activism,
                    size: 40,
                  ),
                  label: Text('Donate'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showCustomAmountDialog(BuildContext context) {
    TextEditingController _customAmountController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Custom Amount'),
          content: TextField(
            controller: _customAmountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Enter amount in LKR',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Submit'),
              onPressed: () {
                setState(() {
                  _selectedValue = _customAmountController.text;
                  _flag = true;
                });
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void _showPayNowDialog(BuildContext context) {
    if (_selectedOption == "" ||
        _selectedValue == "" ||
        _selectedPMethod == "") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR!'),
            content: Text('Fill out all the areas.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the popup
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('You will donate:'),
            content: _selectedOption == "no_repeat"
                ? Text('$_selectedValue\LKR Only Once.')
                : Text('$_selectedValue\LKR Monthly.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the popup
                },
                child: Text('Cancel'),
              ),
              ElevatedButton(
                child: Text('Confirm'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _showPayModeDialog(context); // Close the dialog
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _showPayModeDialog(BuildContext context) {
    TextEditingController _cardNumController = TextEditingController();
    TextEditingController _cvcController = TextEditingController();
    TextEditingController _exDateController = TextEditingController();

    if (_selectedPMethod == "card") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Enter Card Details'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _cardNumController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter card number here',
                  ),
                ),
                TextField(
                  controller: _exDateController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Enter expire date here',
                  ),
                ),
                TextField(
                  controller: _cvcController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter CVC here',
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: Text('Submit'),
                onPressed: () {
                  setState(() {
                    //send card num, cvc, expire date and amount to the payment gateway
                    _handlePayment(context);
                  });
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
    } else if (_selectedPMethod == "paypal") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Go to PayPal'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _cardNumController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Paypal ID',
                  ),
                ),
                TextField(
                  controller: _exDateController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: Text('Go to PayPal'),
                onPressed: () {
                  setState(() {
                    //send details to paypal
                  });
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Upload Your Payment Receipt.'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Display the selected image
                _image != null
                    ? Image.file(
                        _image!,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      )
                    : Text('No image selected.'),

                SizedBox(height: 10),

                // Button to pick image
                ElevatedButton.icon(
                  icon: Icon(Icons.upload),
                  label: Text('Choose Image'),
                  onPressed: _pickImage,
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
              ElevatedButton(
                child: Text('Submit'),
                onPressed: () {
                  if (_image != null) {
                    // Logic to send the image details (e.g., to a server or process)
                    setState(() {
                      // Handle image submission here
                    });
                    Navigator.of(context).pop(); // Close the dialog
                  } else {
                    // Handle case where no image is selected (optional)
                  }
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _handlePayment(BuildContext context) async {
    try {
      // Get current user
      User? currentUser = FirebaseAuth.instance.currentUser;

      // if (currentUser != null) {
      await FirebaseFirestore.instance
          .collection('indoor_plant_donations')
          .add({
        'amount': _selectedValue,
        'repaet': _selectedOption,
        'payment': _selectedPMethod,
        'userId': currentUser!.uid,
  
        'timestamp': FieldValue
            .serverTimestamp(), // Optional: To track when it was sponsored
      });

      // Show success dialog
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GreenTheHomeDonateSuccessPage()),
      );
      // } else {
      //   // Handle the case where the user is not logged in
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //         content: Text('You need to be logged in to sponsor trees')),
      //   );
      // }
    } catch (e) {
      // Handle any errors that occur during the saving process
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}
