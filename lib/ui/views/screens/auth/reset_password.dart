import 'package:flutter/material.dart';
import 'package:justlearn/services/auth/forgot_password_provider.dart';
import 'package:justlearn/ui/views/screens/auth/login_screen.dart';
import 'package:provider/provider.dart';

class ResetPassword extends StatefulWidget {
  static const String id = "reset_password";
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final nPassword = TextEditingController();
  final cPassword = TextEditingController();

  showAlertDialog(BuildContext context) {
    Widget continueButton = FlatButton(
      child: Text("Ok"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Password not match"),
      content: Text("Please enter same password"),
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

  showAlertSuccess(BuildContext context) {
    final resetProvider = Provider.of<ForgotProvider>(context, listen: false);
    String message = resetProvider.retMessage;
    Widget continueButton = FlatButton(
      child: Text("Ok"),
      onPressed: () async {
        Navigator.pushNamed(context, LoginScreen.id);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Password changed"),
      content: Text(message),
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

    showAlertErr400(BuildContext context) {
    Widget continueButton = FlatButton(
      child: Text("Ok"),
      onPressed: () async {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Update Failed"),
      content: Text("Password update failed. Please try again"),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          'New Password',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontFamily: 'WorkSans',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextField(
                        controller: nPassword,
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.bold),
                        obscureText: true,
                        decoration: InputDecoration(
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
                          hintText: 'New password',
                          errorText: forgotPassword.isEmptyE
                              ? "Please enter new password"
                              : forgotPassword.isSamePassword
                                  ? null
                                  : "Please enter same password",
                          
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      TextField(
                        controller: cPassword,
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.bold),
                        obscureText: true,
                        decoration: InputDecoration(
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
                          hintText: 'Confirm password',
                            errorText: forgotPassword.isEmptyE
                              ? "Please confirm your password"
                              : forgotPassword.isSamePassword
                                  ? null
                                  : "Please enter same password",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: forgotPassword.isLoading ?
                          Center(
                            child: CircularProgressIndicator()
                          ) :
                           Material(
                          color: Color(0xFF3061cc),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          elevation: 5.0,
                          child: MaterialButton(
                            onPressed: () async {
                              // forgotPassword.setIsLoading(true);
                                if (nPassword.text.isEmpty) {
                                  forgotPassword.checkIfEmpty(true);
                                } else {
                                  forgotPassword.checkIfEmpty(false);
                                }
                                if (cPassword.text.isEmpty) {
                                  forgotPassword.checkIfEmpty(true);
                                } else {
                                  forgotPassword.checkIfEmpty(false);
                                }
                                if (cPassword.text.isNotEmpty && 
                                  nPassword.text.isNotEmpty && 
                                  cPassword.text == nPassword.text) {
                                  forgotPassword.setIsLoading(false);
                                  forgotPassword.setIsChecking(true);
                                  print("Go!");
                                } else {
                                  forgotPassword.setSamePassword(false);
                                }


                                if (forgotPassword.isChecking == true) {
                                  forgotPassword.setIsLoading(true);
                                  bool response = await forgotPassword.newPassword(
                                    nPassword.text, cPassword.text);
                                  if(response){
                                    showAlertSuccess(context);
                                    forgotPassword.setIsLoading(false);
                                  } else {
                                    if(forgotPassword.retMessage == "err400"){
                                      forgotPassword.setIsLoading(false);
                                    } else {
                                      showAlertSuccess(context);
                                      forgotPassword.setIsLoading(false);
                                    }
                                }
                                }

                              // if (nPassword.text == cPassword.text) {
                              //   bool response = await forgotPassword.newPassword(
                              //       nPassword.text, cPassword.text);
                              //   if(response){
                              //     showAlertSuccess(context);
                              //     forgotPassword.setIsLoading(false);
                              //   } else {
                              //     if(forgotPassword.retMessage == "err400"){
                              //       showAlertErr400(context);
                              //       forgotPassword.setIsLoading(false);
                              //     } else {
                              //       showAlertSuccess(context);
                              //       forgotPassword.setIsLoading(false);
                              //     }
                              //   }
                              // } else {
                              //   print("not match");
                              //   showAlertDialog(context);
                              //   forgotPassword.setIsLoading(false);
                              // }
                            },
                            child: Text(
                              'Save',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'WorkSans',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
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
