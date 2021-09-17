import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PushNotificationProvider extends ChangeNotifier {
  String _token;

  String get token => _token;

  setToken(String token) {
    _token = token;
    notifyListeners();
  }

  Future<void> saveToken(String email, String regID) async {
    int id = int.parse(regID);
    final http.Response response = await http.post(
      'https://www.justlearn.com/api/firebase-details',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'registrationId': id,
        'email': email,
        'token': token,
      }),
    );
    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print('created');
      print(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      print(response.statusCode);
      print(jsonDecode(response.body));
      // throw Exception();
    }
  }

  Future<void> deleteToken() async {
    final http.Response response = await http.delete(
      'https://www.justlearn.com/api/firebase-details?token=' + _token,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print('deleted');
      print(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      print('not deleted');
      print(response.statusCode);
      print(jsonDecode(response.body));
      // throw Exception();
    }
  }
}
