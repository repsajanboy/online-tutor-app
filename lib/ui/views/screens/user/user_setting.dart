import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:justlearn/ui/views/screens/welcome_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

class UserSetting extends StatefulWidget {
  static const String id = 'user_setting';

  @override
  _UserSettingState createState() => _UserSettingState();
}

class _UserSettingState extends State<UserSetting> {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  final facebookLogin = FacebookLogin();

  bool isLoginFB = false;
  bool isLoginGoogle = false;
  bool isLoginEmail = false;

  _removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //Remove bool
    prefs.remove("isLogin");
    prefs.remove("isFbLogin");
    prefs.remove("isGoogleLogin");
    prefs.remove("isEmailLogin");
    prefs.remove("params");
  }

  _getBoolValuesUserSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    bool checkFb = prefs.containsKey('isFbLogin');
    bool checkGoogle = prefs.containsKey('isGoogleLogin');
    bool checkEmail = prefs.containsKey('isEmailLogin');
    if (checkFb == true) {
      bool fbLogin = prefs.getBool('isFbLogin');
      setState(() {
        isLoginFB = fbLogin;
      });
    } else if (checkGoogle == true) {
      bool googleLogin = prefs.getBool('isGoogleLogin');
      setState(() {
        isLoginGoogle = googleLogin;
      });
    } else if (checkEmail == true) {
      bool emailLogin = prefs.getBool('isEmailLogin');
      setState(() {
        isLoginEmail = emailLogin;
      });
    }
  }

  _logout() {
    if (isLoginFB == true) {
      facebookLogin.logOut();
      _removeValues();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
    } else if (isLoginGoogle == true) {
      _googleSignIn.signOut();
      _removeValues();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
    } else if (isLoginEmail == true) {
      _removeValues();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
    } else {
      print("No login");
    }
  }

  @override
  void initState() {
    _getBoolValuesUserSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back),
                ),
                Container(
                    margin: EdgeInsets.all(15),
                    height: 150,
                    width: 150,
                    alignment: Alignment.bottomRight,
                    decoration: BoxDecoration(
                        color: Color(0xFF3061cc),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(
                        child: Icon(
                      Icons.photo_camera,
                      size: 60,
                      color: Colors.grey,
                    ))),
              ],
            ),
            Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                margin: EdgeInsets.all(15),
                color: Colors.white,
                shadowColor: Colors.grey[300],
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: TextField(
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.bold),
                        obscureText: false,
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
                          hintText: 'John Doe',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.bold),
                        obscureText: false,
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
                          hintText: 'JohnDoe@email.com',
                        ),
                      ),
                    )
                  ],
                )),
            Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                margin: EdgeInsets.all(15),
                color: Colors.white,
                shadowColor: Colors.grey[300],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
                      child: Text(
                        'Subcription',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                      child: Text(
                        '4 lessons',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ),
                  ],
                )),
            Align(
              alignment: Alignment.center,
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  print('Got Click!');
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text(
                    'Payment Details',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'WorkSans',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  print('Got Click!');
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30, top: 30),
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'WorkSans',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 30),
              child: Align(
                alignment: Alignment.center,
                child: RaisedButton(
                    color: Color(0xFF3061cc),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                      child: Text(
                        "Sign Out",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    onPressed: () {
                      print("Sign Out got click");
                      _logout();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0))),
              ),
            )
          ],
        ),
      )),
    );
  }
}
