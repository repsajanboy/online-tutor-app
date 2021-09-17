import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:justlearn/business_logic/models/auth/params_model.dart';
import 'package:justlearn/business_logic/models/users/users_model.dart';
import 'package:justlearn/business_logic/models/users/users_student_model.dart';
import 'package:justlearn/business_logic/models/utils/networking.dart';
import 'package:justlearn/services/shared_preference.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  ParamsResponse loadParams = ParamsResponse();
  Student student = Student();
  Profile teacher = Profile();
  Info infos = Info();
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final facebookLogin = FacebookLogin();
  bool _isFetching = true;
  bool _isFbLogin = false;
  bool _isGoogleLogin = false;
  bool _isEmailLogin = false;
  bool _isAppleLogin = false;
  bool isLogout = false;
  get isFetching => _isFetching;
  get loadParamsAsync => _loadParams();

  _loadParams() async {
    _isFetching = true;
    notifyListeners();
    try {
      ParamsResponse params =
          ParamsResponse.fromJson(await SharedPref().read("params"));
      loadParams = params;
      _isFetching = false;
      notifyListeners();
    } catch (e) {
      print('Params error: $e');
    }
  }

  checkUser() async {
      await _loadParams();
      if (loadParams.type == "T" ) {
        if(teacher.email == null){
          _getTeacherUserData();
        }
      } else {
        if(student.email == null){
          _getStudentUserData();
        }
      }
  }

  _getStudentUserData() async {
    _isFetching = true;
    notifyListeners();
    var url = NetworkHelper.baseUrl +
        "api/user-profile?userregistrationid=${loadParams.id}&usertype=${loadParams.type}";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final result = UsersStudentProfile.fromJson(json.decode(response.body));
      student = result.student;
      _isFetching = false;
      notifyListeners();
    }
  }

  _getTeacherUserData() async {
    _isFetching = true;
    notifyListeners();
    var url = NetworkHelper.baseUrl +
        "api/user-profile?userregistrationid=${loadParams.id}&usertype=${loadParams.type}";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final result = UsersTeacherProfile.fromJson(json.decode(response.body));
      teacher = result.info.profile;
      infos = result.info;
      _isFetching = false;
      notifyListeners();
      print(loadParams.id);
    } else {
      teacher = null;
      infos = null;
      _isFetching = false;
      notifyListeners();
    }
  }

  checkLogin() async {
    //Return bool
    bool checkFb = await SharedPref().isExisting('isFbLogin');
    bool checkGoogle = await SharedPref().isExisting('isGoogleLogin');
    bool checkEmail = await SharedPref().isExisting('isEmailLogin');
    bool checkApple = await SharedPref().isExisting('isAppleLogin');
    if (checkFb == true) {
      bool fbLogin = await SharedPref().getIsLogin('isFbLogin');
      _isFbLogin = fbLogin;
      notifyListeners();
    } else if (checkGoogle == true) {
      bool googleLogin = await SharedPref().getIsLogin('isGoogleLogin');
      _isGoogleLogin = googleLogin;
      notifyListeners();
    } else if (checkEmail == true) {
      bool emailLogin = await SharedPref().getIsLogin('isEmailLogin');
      _isEmailLogin = emailLogin;
      notifyListeners();
    } else if (checkApple == true) {
      bool appleLogin = await SharedPref().getIsLogin('isAppleLogin');
      _isAppleLogin = appleLogin;
      notifyListeners();
    }
  }

  _removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //Remove bool
    prefs.remove("isLogin");
    prefs.remove("isFbLogin");
    prefs.remove("isGoogleLogin");
    prefs.remove("isEmailLogin");
    prefs.remove("isAppleLogin");
    prefs.remove("params");

    //student teacher values
    student.email = null;
    teacher.email = null;
    notifyListeners();
  }

  // getTimezone() async {
  //   final response = await http.get('http://worldtimeapi.org/api/timezone');

  //   print(response.body.length);
  //   print(response.body.codeUnits);
  //   print(response.body);

  // }

  Future<bool> logout() async {
    if (_isFbLogin == true) {
      facebookLogin.logOut();
      _removeValues();
      isLogout = true;
      notifyListeners();
    } else if (_isGoogleLogin == true) {
      _googleSignIn.signOut();
      _removeValues();
      isLogout = true;
      notifyListeners();
    } else if (_isEmailLogin == true) {
      _removeValues();
      isLogout = true;
      notifyListeners();
    } else if (_isAppleLogin == true) {
      _removeValues();
      isLogout = true;
      notifyListeners();
    }
    return isLogout;
  }
}
