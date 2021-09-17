import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:justlearn/business_logic/models/auth/login_response_model.dart';
import 'package:justlearn/business_logic/models/auth/params_model.dart';
import 'package:justlearn/business_logic/models/utils/networking.dart';

import '../shared_preference.dart';

class LoginProvider extends ChangeNotifier {
  bool _isLogging = false;
  bool _emailValid = false;
  bool _passValid = false;
  bool _isValid = true;
  bool showPassword = false;

  ParamsResponse params = ParamsResponse();
  LoginResponse loginRes = LoginResponse();
  String errorMessage = "";

  bool get isLogging => _isLogging;
  bool get emailValid => _emailValid;
  bool get passValid => _passValid;
  bool get isValid => _isValid;

  seePassword() async {
    showPassword = !showPassword;
    notifyListeners();
  }

  Future<LoginResponse> login(String email, String password) async {
    final loginResponse = await http.post(
      NetworkHelper.baseUrl + 'api/login-email',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(
        {"email": "$email", "password": "$password"},
      ),
    );
    if (loginResponse.statusCode == 200) {
      final loginResult =
          LoginResponse.fromJson(json.decode(loginResponse.body));
      if (loginResult.success == true) {
        params.id = loginResult.id;
        params.email = loginResult.email;
        params.type = loginResult.type;
        params.timezone = loginResult.timezone;
        params.timezoneinfo = loginResult.timezoneinfo;
        params.timezoneinfoforce = loginResult.timezoneinfoforce;
        SharedPref().save("params", params);
        SharedPref().setIsLogin("isLogin", true);
        SharedPref().setIsLogin("isEmailLogin", true);
        loginRes = loginResult;
        notifyListeners();
        print(params.id);
      } else {
        errorMessage = loginResult.message;
        loginRes = loginResult;
        notifyListeners();
      }
    }
    else {
      loginRes.success = false;
      errorMessage = "err400";
      notifyListeners();
      return loginRes;
    }

    return loginRes;
  }

  void setIsLoading(value) async {
    _isLogging = value;
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

  checkValidEmail(value) async {
    _isValid = EmailValidator.validate(value);
    notifyListeners();
  }
}
