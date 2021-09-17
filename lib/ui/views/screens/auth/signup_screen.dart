import 'package:flutter/material.dart';

import 'package:justlearn/services/auth/signup_provider.dart';
import 'package:justlearn/services/dashboardDetails.dart/dash_details_provider.dart';
import 'package:justlearn/services/push_notification_provider.dart';
import 'package:justlearn/ui/views/screens/auth/terms_of_use.dart';
import 'package:justlearn/ui/views/screens/tutor/stripe_subscription_not_login.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class SignupScreen extends StatefulWidget {
  static const String id = 'signup_screen';
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isLoading = false;

  final fname = TextEditingController();
  final email = TextEditingController();
  final pass = TextEditingController();

  String _timezoneInfo = "";
  String _timezone = "";

  Future<void> getTimezone() async {
    String localTimezone;
    String localTZ;
    var hours = DateTime.now().timeZoneOffset.inHours;
    var minutes = DateTime.now().timeZoneOffset.inMinutes;
    var dateUtc =
        DateTime.now().timeZoneOffset.inHours.toString().padLeft(2, '0');
    var negative = DateTime.now().timeZoneOffset.inHours.isNegative;
    var min = (minutes % (hours * 60)).toString().padRight(2, '0');
    localTimezone = await FlutterNativeTimezone.getLocalTimezone();
    // print(minutes);
    // print(min);

    if (negative == false) {
      localTZ = "+" + "$dateUtc" + ":" + "$min";
      // print(localTZ);
      setState(() {
        _timezoneInfo = localTimezone;
        _timezone = localTZ;
      });
    } else {
      localTZ = "-" + "$dateUtc" + ":" + "$min";
      setState(() {
        _timezoneInfo = localTimezone;
        _timezone = localTZ;
      });
    }
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
                  final signupState =
                      Provider.of<SignupProvider>(context, listen: false);
                  signupState.setIsLoading(false);
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
  void initState() {
    super.initState();
    getTimezone();
  }

  @override
  Widget build(BuildContext context) {
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 5.0,
                ),
                // Container(
                //   height: 60.0,
                //   child: Text(
                //     'Sign Up'.toUpperCase(),
                //     style: TextStyle(
                //         fontSize: 50.0,
                //         fontWeight: FontWeight.w900,
                //         fontFamily: 'WorkSans',
                //         color: Color(0xFF3061cc),
                //         letterSpacing: 2.0),
                //     textAlign: TextAlign.center,
                //   ),
                // ),
                SizedBox(
                  height: 20.0,
                ),
                Consumer<SignupProvider>(
                  builder: (context, signUpState, child) => TextField(
                    controller: email,
                    onChanged: (value) {
                      signUpState.checkValidEmail(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Email',
                      errorText: signUpState.emailValid
                          ? "Please enter your email"
                          : signUpState.isValid
                              ? null
                              : "Please enter valid email",
                      prefixIcon: Icon(Icons.email),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 30.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF3061cc), width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF3061cc), width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Consumer<SignupProvider>(
                  builder: (context, signUpState, child) => TextField(
                    controller: fname,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      hintText: 'First Name',
                      errorText: signUpState.fname
                          ? "Please enter your first name"
                          : null,
                      prefixIcon: Icon(Icons.person),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 30.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF3061cc), width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF3061cc), width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Consumer<SignupProvider>(
                  builder: (context, signUpState, child) {
                    return TextField(
                      controller: pass,
                      obscureText: !signUpState.showPassword,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        hintText: 'Create a password',
                        errorText: signUpState.passValid
                            ? "Please enter password"
                            : null,
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            signUpState.showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            final signUpState = Provider.of<SignupProvider>(
                                context,
                                listen: false);
                            signUpState.seePassword();
                          },
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 30.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF3061cc), width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF3061cc), width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 8.0,
                ),
                SizedBox(
                  height: 30.0,
                ),
                Consumer<SignupProvider>(
                  builder: (context, signupState, child) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: signupState.isSignup
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
                                //Implement sign up functionality.
                                print("$_timezoneInfo" + " " + "$_timezone");
                                if (fname.text.isEmpty) {
                                  signupState.setFnameValid(true);
                                } else {
                                  signupState.setFnameValid(false);
                                }
                                if (email.text.isEmpty) {
                                  signupState.setEmailValid(true);
                                } else {
                                  signupState.setEmailValid(false);
                                }
                                if (pass.text.isEmpty) {
                                  signupState.setPassValid(true);
                                } else {
                                  signupState.setPassValid(false);
                                }
                                if (email.text.isNotEmpty &&
                                    pass.text.isNotEmpty &&
                                    fname.text.isNotEmpty &&
                                    signupState.isValid) {
                                  signupState.setIsLoading(true);
                                }
                                if (signupState.isSignup == true) {
                                  final response = signupState.signup(
                                      fname.text,
                                      email.text,
                                      pass.text,
                                      _timezone,
                                      _timezoneInfo);
                                  response.then((result) {
                                    if (result.success == true) {
                                      signupState.setIsLoading(false);
                                      Provider.of<PushNotificationProvider>(
                                              context,
                                              listen: false)
                                          .saveToken(result.email, result.id);
                                      Provider.of<DashDetailsProvider>(context,
                                              listen: false)
                                          .loadDashDetails();
                                      Navigator.pushNamed(context,
                                          StripeSubscriptionNotLogin.id);
                                    } else {
                                      _showMyDialog(signupState.errorMessage);
                                    }
                                  });
                                } else {
                                  print("email not valid");
                                }
                              },
                              minWidth: 200.0,
                              height: 42.0,
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
                //SocialLoginScreen()
                TermOfUse(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
