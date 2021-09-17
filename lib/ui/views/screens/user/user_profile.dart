import 'package:flutter/material.dart';
import 'package:justlearn/services/auth/auth_provider.dart';
import 'package:justlearn/services/dashboardDetails.dart/dash_details_provider.dart';
import 'package:justlearn/services/timezone_provider.dart';
import 'package:justlearn/services/user_profile/user_edit_profile_provider.dart';
import 'package:justlearn/services/user_profile/user_profile_provider.dart';
import 'package:justlearn/ui/views/screens/user/user_student_profile.dart';
import 'package:justlearn/ui/views/screens/user/user_teacher_profile.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  static const String id = 'user_profile';
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _afterLayout(context));
    super.initState();
  }

  _afterLayout(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.isAlreadyLogin) {
      final userState = Provider.of<UserProvider>(context, listen: false);
      // await userState.loadParamsAsync;
       userState.checkUser();
       userState.checkLogin();
      final editState =
          Provider.of<EditProfileProvider>(context, listen: false);
      await editState.loadParamsAsync;
      await editState.checkUser();
      final dashState =
          Provider.of<DashDetailsProvider>(context, listen: false);
      await dashState.checkIfStripe;
      await Provider.of<TimezoneProvider>(context, listen: false).loadTimezones();
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    // bool isLoggedIn = Provider.of<AuthProvider>(context).isAlreadyLogin;
    // print(isLoggedIn);

    // Widget _child;

    // if (!isLoggedIn) {
    //   _child = UserProfileNotLogin();
    // } else {
    //   _child =
    return Scaffold(
      body: SafeArea(
        child: userProvider.isFetching
            ? Center(child: CircularProgressIndicator())
            : Consumer<UserProvider>(
                builder: (context, userState, child) {
                  if (userState.loadParams.type == "T") {
                    return UserTeacherProfile(params: userState.loadParams);
                  }
                  return UserStudentProfile(params: userState.loadParams);
                },
              ),
      ),
    );
    // }
    // return _child;
  }
}
