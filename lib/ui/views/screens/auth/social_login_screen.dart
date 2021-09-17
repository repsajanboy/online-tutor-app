import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:justlearn/services/auth/social_login_provider.dart';
import 'package:justlearn/services/bottomnav_provider.dart';
import 'package:justlearn/services/dashboardDetails.dart/dash_details_provider.dart';
import 'package:justlearn/services/lessons/lessons_list_api.dart';
import 'package:justlearn/services/push_notification_provider.dart';
import 'package:justlearn/ui/views/screens/menu_screen.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'terms_of_use.dart';
import 'package:flushbar/flushbar.dart';

class SocialLoginScreen extends StatefulWidget {
  @override
  _SocialLoginScreenState createState() => _SocialLoginScreenState();
}

class _SocialLoginScreenState extends State<SocialLoginScreen> {
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
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'or',
              style: TextStyle(fontSize: 18.0),
            ),
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
                                BorderRadius.all(Radius.circular(30.0)),
                            elevation: 5.0,
                            child: MaterialButton(
                              onPressed: () {
                                //Implement login functionality.
                                print("Face login");
                                socialLoginProvider.setIsFLoading(true);
                                if (socialLoginProvider.isFLogging == true) {
                                  final response =
                                      socialLoginState.loginWithFB();
                                  response.then((result) {
                                    if (result.success == true) {
                                      socialLoginProvider.setIsFLoading(false);
                                      Provider.of<PushNotificationProvider>(
                                              context,
                                              listen: false)
                                          .saveToken(result.email, result.id);
                                      Provider.of<DashDetailsProvider>(context,
                                              listen: false)
                                          .loadDashDetails();
                                      Provider.of<LessonListApi>(context,
                                              listen: false)
                                          .getLessonsList(1);
                                      final botnavState = Provider.of<
                                              BottomNavigationBarProvider>(
                                          context,
                                          listen: false);
                                      botnavState.currentIndex = 0;
                                      Navigator.pushNamed(
                                          context, MenuScreen.id);
                                    } else {
                                      socialLoginProvider.setIsFLoading(false);
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
                                      'Log in with Facebook',
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
                                BorderRadius.all(Radius.circular(30.0)),
                            elevation: 5.0,
                            child: MaterialButton(
                              onPressed: () {
                                //Implement login functionality.
                                print("Google login");
                                socialLoginProvider.setIsGLoading(true);
                                if (socialLoginProvider.isGLogging == true) {
                                  final response =
                                      socialLoginState.loginWithGoogle();
                                  response.then((result) {
                                    if (result.success == true) {
                                      socialLoginProvider.setIsGLoading(false);
                                      Provider.of<PushNotificationProvider>(
                                              context,
                                              listen: false)
                                          .saveToken(result.email, result.id);
                                      Provider.of<DashDetailsProvider>(context,
                                              listen: false)
                                          .loadDashDetails();
                                      Provider.of<LessonListApi>(context,
                                              listen: false)
                                          .getLessonsList(1);
                                      final botnavState = Provider.of<
                                              BottomNavigationBarProvider>(
                                          context,
                                          listen: false);
                                      botnavState.currentIndex = 0;
                                      Navigator.pushNamed(
                                          context, MenuScreen.id);
                                    } else {
                                      socialLoginProvider.setIsGLoading(false);
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
                                    'Log in with Google',
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
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                  elevation: 5.0,
                                  child: MaterialButton(
                                    onPressed: () async {
                                      //Implement login functionality.
                                      socialLoginProvider.setIsALoading(true);
                                      var credential;
                                      try {
                                        credential = await SignInWithApple
                                            .getAppleIDCredential(
                                          scopes: [
                                            AppleIDAuthorizationScopes.email,
                                            AppleIDAuthorizationScopes.fullName,
                                          ],
                                        );

                                        var fullName = "";
                                        if (credential.givenName != null &&
                                            credential.familyName != null) {
                                          fullName = credential.givenName +
                                              credential.familyName;
                                        }

                                        if (socialLoginProvider.isALogging ==
                                            true) {
                                          if (credential.email != null) {
                                            final response =
                                                socialLoginState.loginWithApple(
                                              credential.userIdentifier,
                                              fullName,
                                              credential.givenName,
                                              credential.familyName,
                                              credential.email,
                                            );

                                            response.then(
                                              (result) {
                                                if (result.success == true) {
                                                  socialLoginProvider
                                                      .setIsALoading(false);
                                                  final botnavState = Provider
                                                      .of<BottomNavigationBarProvider>(
                                                          context,
                                                          listen: false);
                                                  botnavState.currentIndex = 0;
                                                  Navigator.pushNamed(
                                                      context, MenuScreen.id);
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
                                            Map<String, dynamic> decodedToken =
                                                JwtDecoder.decode(token);

                                            print(decodedToken['email']);
                                            var tokenEmail =
                                                decodedToken['email'];
                                            final response =
                                                socialLoginState.loginWithApple(
                                                    credential.userIdentifier,
                                                    fullName,
                                                    credential.givenName,
                                                    credential.familyName,
                                                    tokenEmail);

                                            response.then(
                                              (result) {
                                                print("reached here");
                                                if (result.success == true) {
                                                  socialLoginProvider
                                                      .setIsALoading(false);
                                                  Provider.of<PushNotificationProvider>(
                                                          context,
                                                          listen: false)
                                                      .saveToken(result.email,
                                                          result.id);
                                                  Provider.of<DashDetailsProvider>(
                                                          context,
                                                          listen: false)
                                                      .loadDashDetails();
                                                  Provider.of<LessonListApi>(
                                                          context,
                                                          listen: false)
                                                      .getLessonsList(1);
                                                  final botnavState = Provider
                                                      .of<BottomNavigationBarProvider>(
                                                          context,
                                                          listen: false);
                                                  botnavState.currentIndex = 0;
                                                  Navigator.pushNamed(
                                                      context, MenuScreen.id);
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
                                            color: Colors.black),
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
                                              color: Colors.black,
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
                TermOfUse(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
