import 'package:flutter/material.dart';
import 'package:justlearn/services/auth/forgot_password_provider.dart';
import 'package:justlearn/ui/views/screens/auth/verification_code.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  static const String id = "forgot_password";
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final email = TextEditingController();

  showAlertDialog(BuildContext context) {
    Widget continueButton = FlatButton(
      child: Text("Ok"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Email doesn't exist"),
      content: Text("Please enter valid email"),
      actions: [
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<ForgotProvider>(
          builder: (context, forgotPassword, child) => Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          'Reset Password',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontFamily: 'WorkSans',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          'Enter your email address to recieve instructions for resetting your password.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'WorkSans',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          'Your password is not immediately reset by this action',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'WorkSans',
                          ),
                        ),
                      ),
                      TextField(
                        controller: email,
                        onChanged: (value) {
                          forgotPassword.checkValidEmail(value);
                        },
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.bold),
                        obscureText: false,
                        decoration: InputDecoration(
                          errorText: forgotPassword.isEmptyE
                              ? "Please enter your email"
                              : forgotPassword.isValid
                                  ? null
                                  : "Please enter valid email",
                          contentPadding: EdgeInsets.all(20),
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          hintText: 'Email',
                          
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Material(
                              color: Colors.red,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              elevation: 5.0,
                              child: MaterialButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.cancel,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            forgotPassword.isLoading ? 
                            Center(
                              child: CircularProgressIndicator()
                            ) :
                            Material(
                              color: Colors.green,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              elevation: 5.0,
                              child: MaterialButton(
                                onPressed: () {
                                  if (email.text.isEmpty) {
                                  forgotPassword.checkIfEmpty(true);
                                } else {
                                  forgotPassword.checkIfEmpty(false);
                                  forgotPassword.setIsChecking(true);
                                }
                                  if (email.text.isNotEmpty) {
                                    forgotPassword.setIsLoading(true);
                                  }

                                  
                                  if (forgotPassword.isChecking == true) {
                                    
                                  
                                    final response =
                                        forgotPassword.checkEmail(email.text);
                                    response.then((result) {
                                      if (result.success == true) {
                                        forgotPassword.setIsLoading(false);
                                        print('Email exist');
                                        Navigator.pushNamed(
                                            context, VerificationCode.id);
                                        // Navigator.pushNamed(context, ResetPassword.id);

                                      } else {
                                        showAlertDialog(context);
                                        forgotPassword.setIsLoading(false);
                                      }
                                    });
                                  }
                                },
                                child: Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}