import 'package:flutter/material.dart';

class UserProfileNotLogin extends StatefulWidget {
  UserProfileNotLogin({Key key}) : super(key: key);

  @override
  _UserProfileNotLoginState createState() => _UserProfileNotLoginState();
}

class _UserProfileNotLoginState extends State<UserProfileNotLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        brightness: Brightness.light,
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('You need an account.'),
              SizedBox(height: 20.0),
              Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                  decoration: BoxDecoration(
                      color: Color(0xFF3061cc),
                      borderRadius: BorderRadius.circular(20)),
                  child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'login_screen');
                      },
                      child: Text('Login',
                          style: TextStyle(color: Colors.white)))),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text('or'),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                  decoration: BoxDecoration(
                      color: Color(0xFF3061cc),
                      borderRadius: BorderRadius.circular(20)),
                  child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'signup_screen');
                      },
                      child: Text('Sign Up',
                          style: TextStyle(color: Colors.white)))),
            ],
          )),
    );
  }
}
