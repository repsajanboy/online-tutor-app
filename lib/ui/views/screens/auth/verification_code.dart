import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:justlearn/services/auth/forgot_password_provider.dart';
import 'package:justlearn/ui/views/screens/auth/reset_password.dart';
import 'package:provider/provider.dart';

class VerificationCode extends StatefulWidget {
  static const String id = "verification_code";
  @override
  _VerificationCodeState createState() => _VerificationCodeState();
}

class _VerificationCodeState extends State<VerificationCode> {
  var onTapRecognizer;

  TextEditingController verificationCode = TextEditingController();
  // ..text = "123456";

  StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ForgotProvider>(
      builder: (context, forgotProvider, child) => Scaffold(
        backgroundColor: Color(0xFF3061cc),
        key: scaffoldKey,
        body: Consumer<ForgotProvider>(
          builder: (context, forgotPassword, child) => GestureDetector(
            onTap: () {},
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 30),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Email Verification',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 8),
                    child: RichText(
                      text: TextSpan(
                          text: "Enter the code sent to ",
                          children: [
                            TextSpan(
                                text: forgotProvider.resetResponse.email,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                          ],
                          style:
                              TextStyle(color: Colors.white54, fontSize: 15)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: formKey,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 30),
                        child: PinCodeTextField(
                          appContext: context,
                          pastedTextStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          length: 6,
                          obscureText: false,
                          animationType: AnimationType.fade,
                          validator: (v) {
                            if (v.length < 3) {
                              return "I'm from validator";
                            } else {
                              return null;
                            }
                          },
                          pinTheme: PinTheme(
                            inactiveFillColor: Colors.white,
                            inactiveColor: Colors.white,
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            activeFillColor:
                                hasError ? Colors.red : Colors.white,
                          ),
                          animationDuration: Duration(milliseconds: 300),
                          backgroundColor: Color(0xFF3061cc),
                          enableActiveFill: true,
                          errorAnimationController: errorController,
                          controller: verificationCode,
                          onCompleted: (v) {
                            print("Completed");
                          },
                          // onTap: () {
                          //   print("Pressed");
                          // },
                          onChanged: (value) {
                            print(value);
                            setState(() {
                              currentText = value;
                            });
                          },
                          beforeTextPaste: (text) {
                            print("Allowing to paste $text");
                            //if you retun true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                            //but you can show anything you want here, like your pop up saying wrong paste format or etc
                            return true;
                          },
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      hasError
                          ? "*Please enter the exact verification code"
                          : "",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // RichText(
                  //   textAlign: TextAlign.center,
                  //   text: TextSpan(
                  //       text: "Didn't receive the code? ",
                  //       style: TextStyle(color: Colors.white54, fontSize: 15),
                  //       children: [
                  //         TextSpan(
                  //             text: " RESEND",
                  //             recognizer: onTapRecognizer,
                  //             style: TextStyle(
                  //                 color: Colors.white,
                  //                 fontWeight: FontWeight.bold,
                  //                 fontSize: 16))
                  //       ]),
                  // ),
                  SizedBox(
                    height: 14,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 30),
                    child: forgotPassword.isLoading ? 
                      Center(
                        child: CircularProgressIndicator()
                      ) :
                      ButtonTheme(
                      height: 50,
                      child: FlatButton(
                        onPressed: () {
                          forgotPassword.setIsLoading(true);
                          formKey.currentState.validate();
                          print(forgotPassword.forgotRes.verificationCode);
                          // conditions for validating
                          if (verificationCode.text ==
                              forgotPassword.forgotRes.verificationCode) {
                                forgotPassword.setIsLoading(false);
                            print(verificationCode.text);
                            Navigator.pushNamed(context, ResetPassword.id);
                          } else {
                            errorController.add(ErrorAnimationType
                                .shake); // Triggering error shake animation
                            print(verificationCode.text);
                            forgotPassword.setIsLoading(false);
                            setState(() {
                              hasError = true;
                            });
                          }
                        },
                        child: Center(
                            child: Text(
                          "VERIFY".toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.shade300,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        child: Text(
                          "Clear",
                          style: TextStyle(color: Colors.white54),
                        ),
                        onPressed: () {
                          verificationCode.clear();
                        },
                      ),
                      // FlatButton(
                      //   child: Text("Set Text", style: TextStyle(color: Colors.white54)),
                      //   onPressed: () {
                      //     textEditingController.text = "123456";
                      //   },
                      // ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
