import 'dart:developer';
import 'package:flutter/material.dart';

class GreenTheHomeDonate extends StatefulWidget {
  const GreenTheHomeDonate({super.key});

  @override
  State<GreenTheHomeDonate> createState() => _GreenTheHomeDonateState();
}

class _GreenTheHomeDonateState extends State<GreenTheHomeDonate> {
  var _selectedOption = "";
  var _selectedValue = "";
  var _flag = false;
  var _selectedPMethod = "";

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
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
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
                          value: 'one_time',
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
                const SizedBox(height: 20),
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
                      child: const Text('100LKR'),
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
                      child: const Text('200LKR'),
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
                      child: const Text('500LKR'),
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
                      child: const Text('1000LKR'),
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
                          ? Text('${_selectedValue}LKR')
                          : const Text('Custom Amount'),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
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
                const SizedBox(height: 20),
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
                      label: const Text('Credit/Debit Card'),
                      icon: const Icon(Icons.credit_card),
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
                      label: const Text('PayPal'),
                      icon: const Icon(Icons.paypal),
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
                      label: const Text('Mobile Pay'),
                      icon: const Icon(Icons.mobile_friendly),
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
                      label: const Text('Bank Transfer'),
                      icon: const Icon(Icons.account_balance),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20.0),
                    fixedSize: const Size(300, 80),
                    textStyle: const TextStyle(
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
                    log(
                        'selected: $_selectedOption, $_selectedValue, $_selectedPMethod');
                    _showPayNowDialog(context);
                  },
                  // child: Text('Donate'),
                  icon: const Icon(
                    Icons.volunteer_activism,
                    size: 40,
                  ),
                  label: const Text('Donate'),
                ),
              ],
            ),
          ),
        ),
      ),
      
    );
  }

  void _showCustomAmountDialog(BuildContext context) {
    TextEditingController customAmountController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Custom Amount'),
          content: TextField(
            controller: customAmountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Enter amount in LKR',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Submit'),
              onPressed: () {
                setState(() {
                  _selectedValue = customAmountController.text;
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
            title: const Text('ERROR!'),
            content: const Text('Fill out all the areas.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the popup
                },
                child: const Text('OK'),
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
            title: const Text('You will donate:'),
            content: _selectedOption == "one_time"
                ? Text('${_selectedValue}LKR Only Once.')
                : Text('${_selectedValue}LKR Monthly.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the popup
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                child: const Text('Confirm'),
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
    TextEditingController cardNumController = TextEditingController();
    TextEditingController cvcController = TextEditingController();
    TextEditingController exDateController = TextEditingController();

    if (_selectedPMethod == "card") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Enter Card Details'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: cardNumController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Enter card number here',
                  ),
                ),
                TextField(
                  controller: exDateController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Enter expire date here',
                  ),
                ),
                TextField(
                  controller: cvcController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Enter CVC here',
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: const Text('Submit'),
                onPressed: () {
                  setState(() {
                    //send card num, cvc, expire date and amount to the payment gateway
                    Navigator.of(context).pop();
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
            title: const Text('You will donate:'),
            content: _selectedOption == "one_time"
                ? Text('${_selectedValue}LKR Only Once.')
                : Text('${_selectedValue}LKR Monthly.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the popup
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                child: const Text('Confirm'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
    }
  }
}
