import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:justlearn/services/auth/auth_provider.dart';

import 'package:justlearn/services/auth/login_provider.dart';
import 'package:justlearn/services/bottomnav_provider.dart';
import 'package:justlearn/services/dashboardDetails.dart/dash_details_provider.dart';
import 'package:justlearn/services/lessons/lessons_list_api.dart';
import 'package:justlearn/services/push_notification_provider.dart';
import 'package:justlearn/ui/views/screens/auth/forgot_password.dart';
import 'package:justlearn/ui/views/screens/auth/social_login_screen.dart';

import 'package:provider/provider.dart';

import '../menu_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "login_screen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final email = TextEditingController();
  final password = TextEditingController();
  final emailInDialog = TextEditingController();

  Future<void> _showErrorDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('Please try again..')),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    "Sorry we coudn\'t logged you, Please check your email and try again."),
              ],
            ),
          ),
          actions: <Widget>[
            Center(
              child: FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  final loginState =
                      Provider.of<LoginProvider>(context, listen: false);
                  loginState.setIsLoading(false);
                  Navigator.of(context).pop();
                },
              ),
            ),
            Center(
              child: FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  final loginState =
                      Provider.of<LoginProvider>(context, listen: false);
                  loginState.setIsLoading(false);
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMyDialog(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('Oops')),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            Center(
              child: FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  final loginState =
                      Provider.of<LoginProvider>(context, listen: false);
                  loginState.setIsLoading(false);
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '',
          style: TextStyle(color: Colors.black),
        ),
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        brightness: Brightness.light,
        //automaticallyImplyLeading: false,
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(top: 50.0, bottom: 20.0),
                    child: Image(
                      width: MediaQuery.of(context).size.width * .5,
                      image: AssetImage('assets/img/logo/justlearn.png'),
                    )),
                Consumer<LoginProvider>(
                  builder: (context, loginProvider, child) => TextField(
                    controller: email,
                    onChanged: (value) {
                      loginProvider.checkValidEmail(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      prefixIcon: Icon(Icons.email),
                      errorText: loginProvider.emailValid
                          ? "Please enter your email"
                          : loginProvider.isValid
                              ? null
                              : "Please enter valid email",
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 30.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF3061cc), width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF3061cc), width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 6.0,
                ),
                Consumer<LoginProvider>(
                  builder: (context, loginProvider, child) => TextField(
                    controller: password,
                    obscureText: !loginProvider.showPassword,
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      errorText: loginProvider.passValid
                          ? "Please enter your password"
                          : null,
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          loginProvider.showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          final loginState = Provider.of<LoginProvider>(context,
                              listen: false);
                          loginState.seePassword();
                        },
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 30.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF3061cc), width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF3061cc), width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      print('Got Click!');
                      Navigator.pushNamed(context, ForgotPassword.id);
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.blue),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Consumer<LoginProvider>(
                  builder: (context, loginProvider, child) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: loginProvider.isLogging
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Material(
                            color: Color(0xFF3061cc),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            elevation: 5.0,
                            child: MaterialButton(
                              onPressed: () {
                                if (email.text.isEmpty) {
                                  loginProvider.setEmailValid(true);
                                } else {
                                  loginProvider.setEmailValid(false);
                                }
                                if (password.text.isEmpty) {
                                  loginProvider.setPassValid(true);
                                } else {
                                  loginProvider.setPassValid(false);
                                }
                                if (email.text.isNotEmpty &&
                                    password.text.isNotEmpty &&
                                    loginProvider.isValid) {
                                  loginProvider.setIsLoading(true);
                                }
                                if (loginProvider.isLogging == true) {
                                  final response = loginProvider.login(
                                      email.text, password.text);
                                  response.then((result) {
                                    if (result.success == true) {
                                      loginProvider.setIsLoading(false);
                                      Provider.of<AuthProvider>(context,
                                              listen: false)
                                          .isLoginAlready();
                                      Provider.of<PushNotificationProvider>(
                                              context,
                                              listen: false)
                                          .saveToken(result.email, result.id);
                                      final botnavState = Provider.of<
                                              BottomNavigationBarProvider>(
                                          context,
                                          listen: false);
                                      botnavState.currentIndex = 0;
                                      Provider.of<DashDetailsProvider>(context,
                                              listen: false)
                                          .loadDashDetails();
                                      Provider.of<LessonListApi>(context,
                                              listen: false)
                                          .getLessonsList(1);
                                      Navigator.pushNamed(
                                          context, MenuScreen.id);
                                    } else {
                                      if (loginProvider.errorMessage ==
                                          "err400") {
                                        _showErrorDialog();
                                      } else {
                                        _showMyDialog(
                                            loginProvider.errorMessage);
                                      }
                                    }
                                  });
                                }
                              },
                              minWidth: 200.0,
                              height: 42.0,
                              child: Text(
                                'Log In',
                                style: TextStyle(
                                  fontFamily: 'WorkSans',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
                SocialLoginScreen()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
