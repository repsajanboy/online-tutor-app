import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:justlearn/business_logic/models/auth/login_response_model.dart';
import 'package:justlearn/business_logic/models/auth/params_model.dart';
import 'package:justlearn/business_logic/models/facebook_model.dart';
import 'package:http/http.dart' as http;
import 'package:justlearn/business_logic/models/utils/networking.dart';
import 'package:justlearn/services/shared_preference.dart';

class SocialLoginProvider with ChangeNotifier {
  ParamsResponse params = ParamsResponse();
  LoginResponse loginRes = LoginResponse();
  bool _isGLogging = false;
  bool get isGLogging => _isGLogging;

  bool _isFLogging = false;
  bool get isFLogging => _isFLogging;

  bool _isALogging = false;
  bool get isALogging => _isALogging;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ]);

  Facebook userProfile;
  final facebookLogin = FacebookLogin();

  Future<LoginResponse> loginWithFB() async {
    final result = await facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=id,first_name,last_name,name,birthday,picture,email&access_token=${token}');
        final profile = Facebook.fromJson(json.decode(graphResponse.body));

        final loginResponse =
            await http.post(NetworkHelper.baseUrl + 'api/login-facebook',
                headers: {
                  'Content-Type': 'application/json; charset=UTF-8',
                },
                body: json.encode({
                  "Name": "${profile.name}",
                  "FirstName": "${profile.firstName}",
                  "LastName": "${profile.lastName}",
                  "Id": "${profile.id}",
                  "Picture": "${profile.picture.data.url}",
                  "Email": "${profile.email}",
                  "ProfileLink": "",
                  "Gender": "",
                  "RedirectUrl": "",
                  "SocialAccountId": "",
                  "ReferralCode": ""
                }));
        if (loginResponse.statusCode == 200) {
          final loginResult =
              LoginResponse.fromJson(json.decode(loginResponse.body));
          params.id = loginResult.id;
          params.email = loginResult.email;
          params.type = loginResult.type;
          params.timezone = loginResult.timezone;
          params.timezoneinfo = loginResult.timezoneinfo;
          params.timezoneinfoforce = loginResult.timezoneinfoforce;
          SharedPref().save("params", params);
          SharedPref().setIsLogin("isLogin", true);
          SharedPref().setIsLogin("isFbLogin", true);
          loginRes = loginResult;
          notifyListeners();
        } else {
          print("login error");
        }
        break;

      case FacebookLoginStatus.cancelledByUser:
        print("Cancelled by user");
        break;
      case FacebookLoginStatus.error:
        print(result.errorMessage);
        break;
    }
    return loginRes;
  }

  Future<LoginResponse> loginWithGoogle() async {
    try {
      await _googleSignIn.signIn();
      String firstName = "";
      String lastName = "";
      final names = _googleSignIn.currentUser.displayName.split(' ');
      if (names.length > 2) {
        firstName = names[0] + " " + names[1];
        lastName = names[2];
        notifyListeners();
      } else {
        firstName = names[0];
        lastName = names.length > 1 ? names[1] : '';
        notifyListeners();
      }
      final loginResponse =
          await http.post(NetworkHelper.baseUrl + 'api/login-google',
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: json.encode({
                "Name": "${_googleSignIn.currentUser.displayName}",
                "FirstName": "$firstName",
                "LastName": "$lastName",
                "Id": "${_googleSignIn.currentUser.id}",
                "Picture": "${_googleSignIn.currentUser.photoUrl}",
                "Email": "${_googleSignIn.currentUser.email}",
                "ProfileLink": "",
                "Gender": "",
                "RedirectUrl": "",
                "SocialAccountId": "",
                "ReferralCode": ""
              }));
      if (loginResponse.statusCode == 200) {
        final loginResult =
            LoginResponse.fromJson(json.decode(loginResponse.body));
        params.id = loginResult.id;
        params.email = loginResult.email;
        params.type = loginResult.type;
        params.timezone = loginResult.timezone;
        params.timezoneinfo = loginResult.timezoneinfo;
        params.timezoneinfoforce = loginResult.timezoneinfoforce;
        SharedPref().save("params", params);
        SharedPref().setIsLogin("isLogin", true);
        SharedPref().setIsLogin("isGoogleLogin", true);
        loginRes = loginResult;
        notifyListeners();
      } else {
        print("login error");
      }

      return loginRes;
    } catch (err) {
      print(err);

      return loginRes;
    }
  }

  Future<LoginResponse> loginWithApple(String appleId, String fullName,
      String firstName, String lastName, String email) async {
    final response = await http.post(
      NetworkHelper.baseUrl + 'api/login-facebook',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        "Name": "$fullName",
        "FirstName": "$firstName",
        "LastName": "$lastName",
        "Id": "$appleId",
        "Email": "$email",
        "ProfileLink": "",
        "Gender": "",
        "RedirectUrl": "",
        "SocialAccountId": "",
        "ReferralCode": ""
      }),
    );
    if (response.statusCode == 200) {
      final loginResult = LoginResponse.fromJson(json.decode(response.body));
      params.id = loginResult.id;
      params.email = loginResult.email;
      params.type = loginResult.type;
      params.timezone = loginResult.timezone;
      params.timezoneinfo = loginResult.timezoneinfo;
      params.timezoneinfoforce = loginResult.timezoneinfoforce;
      SharedPref().save("params", params);
      SharedPref().setIsLogin("isLogin", true);
      SharedPref().setIsLogin("isAppleLogin", true);
      loginRes = loginResult;
      notifyListeners();
    } else {
      print(response);
      print(response.statusCode);
      print("login error");
    }
    return loginRes;
  }

  void setIsGLoading(value) async {
    _isGLogging = value;
    notifyListeners();
  }

  void setIsFLoading(value) async {
    _isFLogging = value;
    notifyListeners();
  }

  void setIsALoading(value) async {
    _isALogging = value;
    notifyListeners();
  }
}
