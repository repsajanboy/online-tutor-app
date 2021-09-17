import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:justlearn/services/auth/auth_provider.dart';
import 'package:justlearn/services/calendar/calendar_provider.dart';
import 'package:justlearn/services/push_notification_provider.dart';
import 'package:justlearn/ui/views/screens/auth/signup_screen.dart';
import 'package:provider/provider.dart';
import 'auth/login_screen.dart';
import 'menu_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = "welcome_screen";
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _afterLayout(context));
    _initFirebaseMessaging();
  }

  _initFirebaseMessaging() async {
    if (Platform.isIOS) {
      _firebaseMessaging
          .requestNotificationPermissions(IosNotificationSettings());
    }
    String token = await _firebaseMessaging.getToken();
    Provider.of<PushNotificationProvider>(context, listen: false)
        .setToken(token);
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        // print("onLaunch: $message");
        if (message['screen']) {
          Navigator.pushNamed(context, 'lesson_screen');
        }
      },
      onResume: (Map<String, dynamic> message) async {
        // print("onResume: $message");

        if (message['screen']) {
          Navigator.pushNamed(context, 'lesson_screen');
        }
      },
    );
  }

  _afterLayout(BuildContext context) async {
    final authState = Provider.of<AuthProvider>(context, listen: false);
    authState.isLoginAlready();
    final calendarState = Provider.of<CalendarProvider>(context, listen: false);
    await calendarState.loadParamsAsync;
    // final timezoneState = Provider.of<TimezoneProvider>(context, listen: false);
    // await timezoneState.loadTimezoneAsync;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, child) => authProvider.isAlreadyLogin
            ? MenuScreen()
            : Scaffold(
                backgroundColor: Color(0xFF3061cc),
                body: SafeArea(
                  child: Container(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 70.0,
                          ),
                          Image(
                            width: MediaQuery.of(context).size.width * .5,
                            image: AssetImage(
                                'assets/img/logo/justlearn-white.png'),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .5,
                            child: Center(
                              child: Text(
                                'Learn languages',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(bottom: 20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 20.0),
                                    child: Material(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0)),
                                      elevation: 5.0,
                                      child: MaterialButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SignupScreen(),
                                            ),
                                          );
                                        },
                                        minWidth:
                                            MediaQuery.of(context).size.width *
                                                .85,
                                        height: 75.0,
                                        child: Text(
                                          'START LEARNING',
                                          style: TextStyle(
                                            fontFamily: 'WorkSans',
                                            fontSize: 22.0,
                                            color: Color(0xFF3061cc),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  FlatButton(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onPressed: () => Navigator.pushNamed(
                                        context, LoginScreen.id),
                                    child: Text(
                                      'I ALREADY HAVE AN ACCOUNT',
                                      style: TextStyle(
                                          fontFamily: 'WorkSans',
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white60),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
