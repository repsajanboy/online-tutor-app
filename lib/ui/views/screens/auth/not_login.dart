import 'package:flutter/material.dart';
import 'package:justlearn/services/auth/auth_provider.dart';
import 'package:justlearn/ui/views/screens/user/user_profile_not_login.dart';
import 'package:provider/provider.dart';

class NotLoginScreen extends StatelessWidget {
  static const String id = "not_login";
  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = Provider.of<AuthProvider>(context).isAlreadyLogin;
    Widget _child;
    if (!isLoggedIn) {
      _child = UserProfileNotLogin();
    } else {
      _child = Container();
    }
    return _child;
  }
}
