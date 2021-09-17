import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:justlearn/business_logic/models/auth/params_model.dart';
import 'package:justlearn/business_logic/models/auth/signup_response_model.dart';
import 'package:justlearn/business_logic/models/utils/networking.dart';

import '../shared_preference.dart';

class SignupProvider with ChangeNotifier {
  ParamsResponse params = ParamsResponse();
  SignupResponse signupRes = SignupResponse();
  String errorMessage = "";
  bool showPassword = false;
  bool _isSignup = false;
  bool _fname = false;
  bool _emailValid = false;
  bool _passValid = false;
  bool _isValid = true;

  bool get isSignup => _isSignup;
  bool get fname => _fname;
  bool get emailValid => _emailValid;
  bool get passValid => _passValid;
  bool get isValid => _isValid;

  seePassword() async {
    showPassword = !showPassword;
    notifyListeners();
  }

  Future<SignupResponse> signup(String fname, String email, String pass, String timezone, String timezoneInfo) async {
    final signUpResponse =
        await http.post(NetworkHelper.baseUrl + 'api/signup-email',
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({
              "firstname": "$fname",
              "email": "$email",
              "password": "$pass",
              "TimezoneInfo": "$timezoneInfo",
              "TimezoneInfoGmt": "$timezone"
            }));
    if (signUpResponse.statusCode == 200) {
      final signUpResult =
          SignupResponse.fromJson(json.decode(signUpResponse.body));
      if (signUpResult.success == true) {
        params.id = signUpResult.id;
        params.email = signUpResult.email;
        params.type = signUpResult.type;
        params.timezone = signUpResult.timezone;
        params.timezoneinfo = signUpResult.timezoneinfo;
        params.timezoneinfoforce = signUpResult.timezoneinfoforce;
        SharedPref().save("params", params);
        SharedPref().setIsLogin("isLogin", true);
        SharedPref().setIsLogin("isEmailLogin", true);
        signupRes = signUpResult;
        notifyListeners();
      } else {
        errorMessage = signUpResult.message;
        notifyListeners();
      }
    } else {
      print(signUpResponse.statusCode);
    }
    return signupRes;
  }

  void setIsLoading(value) async {
    _isSignup = value;
    notifyListeners();
  }

  void setEmailValid(value) async {
    _emailValid = value;
    notifyListeners();
  }

  void setPassValid(value) async {
    _passValid = value;
    notifyListeners();
  }

  void setFnameValid(value) async {
    _fname = value;
    notifyListeners();
  }

  checkValidEmail(value) async {
    _isValid = EmailValidator.validate(value);
    notifyListeners();
  }
}
