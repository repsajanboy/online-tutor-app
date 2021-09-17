import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:justlearn/business_logic/models/auth/forgot_password_model.dart';
import 'package:justlearn/business_logic/models/auth/reset_password_moder.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:justlearn/business_logic/models/utils/networking.dart';

class ForgotProvider extends ChangeNotifier {
  String oldPass = "oldpass123";
  String retMessage = "";
  bool _isChecking = false;
  bool _isEmailExist = false;
  bool _emailValid = false;
  bool _isValid = true;
  bool isChangePasswordSuccess = false;
  bool _isLoading = false;
  bool _isEmptyE = false;
  bool _isSamePassword = true;
  
  ForgetResponse forgotRes = ForgetResponse();
  ResetResponse resetResponse = ResetResponse();

  bool get isChecking => _isChecking;
  bool get isEmailExist => _isEmailExist;
  bool get emailValid => _emailValid;
  bool get isValid => _isValid;
  bool get isLoading => _isLoading;
  bool get isEmptyE => _isEmptyE;
  bool get isSamePassword => _isSamePassword;

  // seePassword() async {
  //   showPassword = !showPassword;
  //   notifyListeners();
  // }

  checkEmail(String email) async {
    final response = await http.post(
        NetworkHelper.baseUrl + 'api/forgot-password',
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode("$email"));
    if (response.statusCode == 200) {
      final checkEmailResult =
          ForgetResponse.fromJson(json.decode(response.body));
      forgotRes = checkEmailResult;
      resetResponse.email = "$email";
      resetResponse.id = checkEmailResult.id;
      resetResponse.verificationCode = checkEmailResult.verificationCode;
      notifyListeners();
      print(checkEmailResult.verificationCode);
    } else {
      print(response.statusCode);
    }
    return forgotRes;
  }

  Future<bool> newPassword(String nPassword, String cPassword) async {
    final response =
        await http.post(NetworkHelper.baseUrl + 'api/reset-password',
            headers: {'Content-Type': 'application/json; charset=UTF-8'},
            body: json.encode({
              "UserName": "${resetResponse.email}",
              "RegistrationId": "${resetResponse.id}",
              "ConfirmPassword": "$cPassword",
              "NewPassword": "$nPassword",
              "VerificationCode": "${resetResponse.verificationCode}",
              "OldPassword": oldPass
            }));
    if (response.statusCode == 200) {
      final responseString = json.decode(response.body);
      if(responseString['success'] == true){
        retMessage = responseString['message'];
        isChangePasswordSuccess = true;
        notifyListeners();
      }
      else {
        retMessage = responseString['message'];
        isChangePasswordSuccess = false;
        notifyListeners();
      }
    } else {
      print(response.statusCode);
       retMessage = "err400";
        isChangePasswordSuccess = false;
        notifyListeners();
    }
    return isChangePasswordSuccess;
  }

  void setEmailValid(value) async {
    _isEmailExist = value;
    notifyListeners();
  }

  void setIsChecking(value) async {
    _isChecking = value;
    notifyListeners();
  }

  checkValidEmail(value) async {
    _isValid = EmailValidator.validate(value);
    notifyListeners();
  }

  void setIsLoading(value) async {
    _isLoading = value;
    notifyListeners();
  }

  void checkIfEmpty(value) async {
    _isEmptyE = value;
    notifyListeners();
  }

  void setSamePassword(value) async {
    _isSamePassword = value;
    notifyListeners();
  }
}
