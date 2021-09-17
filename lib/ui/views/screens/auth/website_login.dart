import 'dart:io';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:justlearn/services/auth/social_login_provider.dart';
import 'package:justlearn/services/dashboardDetails.dart/dash_details_provider.dart';
import 'package:justlearn/services/push_notification_provider.dart';
import 'package:justlearn/ui/views/screens/auth/login_screen.dart';
import 'package:justlearn/ui/views/screens/auth/signup_screen.dart';
import 'package:justlearn/ui/views/screens/auth/terms_of_use.dart';
import 'package:justlearn/ui/views/screens/tutor/stripe_subscription_not_login.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginWebsite extends StatefulWidget {
  static const String id = "website_login";
  @override
  _LoginWebsiteState createState() => _LoginWebsiteState();
}

class _LoginWebsiteState extends State<LoginWebsite> {
  void showInfoFlushbar(BuildContext context, String message, String title) {
    Flushbar(
      // title: title,
      message: message,
      icon: Icon(
        Icons.info_outline,
        size: 28,
        color: Color(0xFF3061cc),
      ),
      leftBarIndicatorColor: Color(0xFF3061cc),
      duration: Duration(seconds: 5),
    )..show(context);
  }

  @override
  Widget build(BuildContext context) {
    final socialLoginState =
        Provider.of<SocialLoginProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Step 1 of 2',
          style: TextStyle(color: Colors.black, fontSize: 15.0),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        brightness: Brightness.light,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Consumer<SocialLoginProvider>(
                      builder: (context, socialLoginProvider, child) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: socialLoginProvider.isFLogging
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Material(
                                color: Color(0xFF3061cc),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                elevation: 5.0,
                                child: MaterialButton(
                                  onPressed: () {
                                    //Implement login functionality.
                                    print("Face login");
                                    socialLoginProvider.setIsFLoading(true);
                                    if (socialLoginProvider.isFLogging ==
                                        true) {
                                      final response =
                                          socialLoginState.loginWithFB();
                                      response.then((result) {
                                        if (result.success == true) {
                                          socialLoginProvider
                                              .setIsFLoading(false);
                                          Provider.of<PushNotificationProvider>(
                                                  context,
                                                  listen: false)
                                              .saveToken(
                                                  result.email, result.id);
                                          Provider.of<DashDetailsProvider>(
                                                  context,
                                                  listen: false)
                                              .loadDashDetails();
                                          Navigator.pushNamed(context,
                                              StripeSubscriptionNotLogin.id);
                                        } else {
                                          socialLoginProvider
                                              .setIsFLoading(false);
                                          showInfoFlushbar(
                                              context,
                                              "Facebook login cancelled",
                                              "Login with Facebook");
                                        }
                                      });
                                    }
                                  },
                                  minWidth: 200.0,
                                  height: 42.0,
                                  child: Row(
                                    children: <Widget>[
                                      Icon(FontAwesomeIcons.facebook,
                                          color: Colors.white),
                                      SizedBox(
                                        width: 20.0,
                                      ),
                                      Center(
                                        child: Text(
                                          'Continue with Facebook',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'WorkSans',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ),
                    ),
                    Consumer<SocialLoginProvider>(
                      builder: (context, socialLoginProvider, child) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: socialLoginProvider.isGLogging
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Material(
                                color: Colors.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                elevation: 5.0,
                                child: MaterialButton(
                                  onPressed: () {
                                    //Implement login functionality.
                                    print("Google login");
                                    socialLoginProvider.setIsGLoading(true);
                                    if (socialLoginProvider.isGLogging ==
                                        true) {
                                      final response =
                                          socialLoginState.loginWithGoogle();
                                      response.then((result) {
                                        if (result.success == true) {
                                          socialLoginProvider
                                              .setIsGLoading(false);
                                          Provider.of<PushNotificationProvider>(
                                                  context,
                                                  listen: false)
                                              .saveToken(
                                                  result.email, result.id);
                                          Provider.of<DashDetailsProvider>(
                                                  context,
                                                  listen: false)
                                              .loadDashDetails();
                                          Navigator.pushNamed(context,
                                              StripeSubscriptionNotLogin.id);
                                        } else {
                                          socialLoginProvider
                                              .setIsGLoading(false);
                                          showInfoFlushbar(
                                              context,
                                              "Google login cancelled",
                                              " Login with Google");
                                        }
                                      });
                                    }
                                  },
                                  minWidth: 200.0,
                                  height: 42.0,
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        FontAwesomeIcons.google,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 20.0,
                                      ),
                                      Text(
                                        'Continue with Google',
                                        style: TextStyle(
                                          fontFamily: 'WorkSans',
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ),
                    ),
                    Platform.isIOS
                        ? Consumer<SocialLoginProvider>(
                            builder: (context, socialLoginProvider, child) =>
                                Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: socialLoginProvider.isALogging
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Material(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      elevation: 5.0,
                                      child: MaterialButton(
                                        onPressed: () async {
                                          //Implement login functionality.
                                          socialLoginProvider
                                              .setIsALoading(true);
                                          var credential;
                                          try {
                                            credential = await SignInWithApple
                                                .getAppleIDCredential(
                                              scopes: [
                                                AppleIDAuthorizationScopes
                                                    .email,
                                                AppleIDAuthorizationScopes
                                                    .fullName,
                                              ],
                                            );

                                            var fullName = "";
                                            if (credential.givenName != null &&
                                                credential.familyName != null) {
                                              fullName = credential.givenName +
                                                  credential.familyName;
                                            }

                                            if (socialLoginProvider
                                                    .isALogging ==
                                                true) {
                                              if (credential.email != null) {
                                                final response =
                                                    socialLoginState
                                                        .loginWithApple(
                                                  credential.userIdentifier,
                                                  fullName,
                                                  credential.givenName,
                                                  credential.familyName,
                                                  credential.email,
                                                );

                                                response.then(
                                                  (result) {
                                                    if (result.success ==
                                                        true) {
                                                      socialLoginProvider
                                                          .setIsALoading(false);
                                                      Provider.of<PushNotificationProvider>(
                                                              context,
                                                              listen: false)
                                                          .saveToken(
                                                              result.email,
                                                              result.id);
                                                      Provider.of<DashDetailsProvider>(
                                                              context,
                                                              listen: false)
                                                          .loadDashDetails();
                                                      Navigator.pushNamed(
                                                          context,
                                                          StripeSubscriptionNotLogin
                                                              .id);
                                                    } else {
                                                      // print(result);
                                                      socialLoginProvider
                                                          .setIsALoading(false);
                                                      showInfoFlushbar(
                                                          context,
                                                          "Apple login cancelled",
                                                          "Login with Apple");
                                                    }
                                                  },
                                                );
                                              } else {
                                                print("dito pumasok");

                                                String token =
                                                    credential.identityToken;
                                                Map<String, dynamic>
                                                    decodedToken =
                                                    JwtDecoder.decode(token);

                                                print(decodedToken['email']);
                                                var tokenEmail =
                                                    decodedToken['email'];
                                                final response =
                                                    socialLoginState
                                                        .loginWithApple(
                                                            credential
                                                                .userIdentifier,
                                                            fullName,
                                                            credential
                                                                .givenName,
                                                            credential
                                                                .familyName,
                                                            tokenEmail);
                                                response.then(
                                                  (result) {
                                                    print("reached here");
                                                    if (result.success ==
                                                        true) {
                                                      socialLoginProvider
                                                          .setIsALoading(false);
                                                      Provider.of<PushNotificationProvider>(
                                                              context,
                                                              listen: false)
                                                          .saveToken(
                                                              result.email,
                                                              result.id);
                                                      Provider.of<DashDetailsProvider>(
                                                              context,
                                                              listen: false)
                                                          .loadDashDetails();
                                                      Navigator.pushNamed(
                                                          context,
                                                          StripeSubscriptionNotLogin
                                                              .id);
                                                    } else {
                                                      // print(result);
                                                      socialLoginProvider
                                                          .setIsALoading(false);
                                                      showInfoFlushbar(
                                                          context,
                                                          "Apple login cancelled",
                                                          "Login with Apple");
                                                    }
                                                  },
                                                );
                                              }
                                            }
                                          } on PlatformException catch (err) {
                                            print(err);
                                            socialLoginProvider
                                                .setIsALoading(false);
                                          } catch (err) {
                                            socialLoginProvider
                                                .setIsALoading(false);
                                          }
                                        },
                                        minWidth: 200.0,
                                        height: 42.0,
                                        child: Row(
                                          children: <Widget>[
                                            Icon(FontAwesomeIcons.apple,
                                                color: Colors.white),
                                            SizedBox(
                                              width: 20.0,
                                            ),
                                            Center(
                                              child: Text(
                                                'Continue with Apple',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: 'WorkSans',
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                            ),
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text('or'),
                    SizedBox(
                      height: 10.0,
                    ),
                    Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      elevation: 5.0,
                      child: MaterialButton(
                        onPressed: () async {
                          Navigator.pushNamed(context, SignupScreen.id);
                        },
                        minWidth: 200.0,
                        height: 42.0,
                        child: Row(
                          children: <Widget>[
                            Icon(FontAwesomeIcons.envelope,
                                color: Colors.black),
                            SizedBox(
                              width: 20.0,
                            ),
                            Center(
                              child: Text(
                                'Sign up with email',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'WorkSans',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TermOfUse(),
                    SizedBox(height: 20.0),
                    Divider(
                      height: 5.0,
                      thickness: 1.0,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                          onPressed: () {
                            Navigator.pushNamed(context, LoginScreen.id);
                          },
                          child: Text(
                            'Log In',
                            style: TextStyle(color: Color(0xFF3061cc)),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
