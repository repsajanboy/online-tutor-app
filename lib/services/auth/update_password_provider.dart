import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:justlearn/business_logic/models/utils/networking.dart';
import 'package:http/http.dart' as http;

class UpdatePassProvider with ChangeNotifier {
  bool _npassValid = false;
  bool _cpassValid = false;
  bool _isSamePassword = true;
  bool _isLoading = false;
  bool isSuccess = false;
  String message = "";

  bool get npassValid => _npassValid;
  bool get cpassValid => _cpassValid;
  bool get isLoading => _isLoading;
  bool get isSamePassword => _isSamePassword;

  void setNPassValid(value) async {
    _npassValid = value;
    notifyListeners();
  }

  void setCPassValid(value) async {
    _cpassValid = value;
    notifyListeners();
  }

  void setSamePassword(value) async {
    _isSamePassword = value;
    notifyListeners();
  }

  void setIsLoading(value) async {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> updatePassword(
      String regId, String newPass, String confirmPass) async {
    var url = NetworkHelper.baseUrl + 'api/update-password';
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(
        {
          "RegistrationId": "$regId",
          "ConfirmPassword": "$newPass",
          "NewPassword": "$confirmPass"
        },
      ),
    );
    if (response.statusCode == 200) {
      print('update-pass: 200');
      final result = json.decode(response.body);
      message = result['message'];
      isSuccess = result['success'];
      print(message);
      print(isSuccess);
      notifyListeners();
    } else {
      print('update-pass: ' + response.statusCode.toString());
    }
    return isSuccess;
  }
}
