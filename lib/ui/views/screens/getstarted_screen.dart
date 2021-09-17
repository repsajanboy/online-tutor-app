import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:justlearn/services/auth/auth_provider.dart';
import 'package:justlearn/services/languageList/language_list_provider.dart';
import 'package:justlearn/services/push_notification_provider.dart';
import 'package:justlearn/ui/views/screens/auth/login_screen.dart';
import 'package:justlearn/ui/views/screens/auth/website_login.dart';
import 'package:justlearn/ui/views/screens/get_started_login.dart';
import 'package:provider/provider.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:in_app_review/in_app_review.dart';

class GetStarted extends StatefulWidget {
  static const String id = "get_started";
  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  RateMyApp _rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 3,
    minLaunches: 7,
    remindDays: 2,
    remindLaunches: 5,
    // appStoreIdentifier: '',
    googlePlayIdentifier: 'com.justlearn',
  );

  @override
  void initState() {
    super.initState();
    Provider.of<AuthProvider>(context, listen: false).isLoginAlready();
    final languageState =
        Provider.of<LanguageListProvider>(context, listen: false);
    languageState.getLanguageList();
    languageState.getLanguageListWithTutors();
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

    _rateMyApp.init().then((_) async {
      if (_rateMyApp.shouldOpenDialog) {
        // this if statement
        _rateMyApp.showRateDialog(
          context,
          title: 'Rate this app',
          message:
              'If you like this app, please take a little bit of your time to review it !\nIt really helps us and it shouldn\'t take you more than one minute.',
          rateButton: 'RATE',
          noButton: 'NO THANKS',
          laterButton: 'MAYBE LATER',
          listener: (button) {
            // The button click listener (useful if you want to cancel the click event).
            switch (button) {
              case RateMyAppDialogButton.rate:
                final InAppReview inAppReview = InAppReview.instance;
                if (inAppReview.isAvailable() != null) {
                  inAppReview.requestReview();
                  DoNotOpenAgainCondition().doNotOpenAgain = true;
                  _rateMyApp.save();
                } else {
                  inAppReview.openStoreListing(appStoreId: '1443829206');
                  DoNotOpenAgainCondition().doNotOpenAgain = true;
                  _rateMyApp.save();
                }
                print('Clicked on "Rate');
                break;
              case RateMyAppDialogButton.later:
                print('Clicked on "Later".');
                break;
              case RateMyAppDialogButton.no:
                print('Clicked on "No".');
                break;
            }

            return true; // Return false if you want to cancel the click event.
          },

          dialogStyle: DialogStyle(
            titleAlign: TextAlign.center,
            messageAlign: TextAlign.center,
            messagePadding: EdgeInsets.only(bottom: 20.0),
          ), // Custom dialog styles.
          onDismissed: () =>
              _rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('get started build');
    return WillPopScope(
      onWillPop: () async => false,
      child: Consumer<AuthProvider>(
        builder: (context, auth, child) => auth.isAlreadyLogin
            ? GetStartedLogin()
            : Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/img/App_Background_Launch_Screen1.jpg"),
                      fit: BoxFit.cover),
                ),
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: SafeArea(
                    child: Container(
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 70.0,
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(bottom: 20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image(
                                      width: MediaQuery.of(context).size.width *
                                          .5,
                                      image: AssetImage(
                                          'assets/img/logo/justlearn-white.png'),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .75,
                                      child: Center(
                                        child: Text(
                                          'The Best Lessons to Just Learn Anything.',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          top: 20.0, left: 10.0, right: 10.0),
                                      width: MediaQuery.of(context).size.width *
                                          .95,
                                      child: Center(
                                        child: Text(
                                          'English - Spanish - Yoga - Guitar -',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, left: 10.0, right: 10.0),
                                      width: MediaQuery.of(context).size.width *
                                          .95,
                                      child: Center(
                                        child: Text(
                                          'Football - Chess - Psychology -',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, left: 10.0, right: 10.0),
                                      width: MediaQuery.of(context).size.width *
                                          .95,
                                      child: Center(
                                        child: Text(
                                          'and more ',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20.0),
                                      child: Material(
                                        color: Color(0xFF3061cc),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        elevation: 5.0,
                                        child: MaterialButton(
                                          onPressed: () async {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginWebsite(),
                                              ),
                                            );
                                          },
                                          minWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .85,
                                          height: 75.0,
                                          child: Text(
                                            'Sign Up Now',
                                            style: TextStyle(
                                              fontSize: 22.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1.0,
                                      height: 5.0,
                                      color: Colors.grey,
                                    ),
                                    FlatButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, LoginScreen.id);
                                      },
                                      child: Text(
                                        'Log In',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0,
                                            color: Colors.white),
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
      ),
    );
  }
}
