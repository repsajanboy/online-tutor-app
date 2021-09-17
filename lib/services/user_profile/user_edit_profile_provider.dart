import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:justlearn/business_logic/models/auth/params_model.dart';
import 'package:justlearn/business_logic/models/users/users_model.dart';
import 'package:justlearn/business_logic/models/users/users_student_model.dart';
import 'package:justlearn/business_logic/models/utils/networking.dart';
import 'package:justlearn/services/shared_preference.dart';

class EditProfileProvider with ChangeNotifier {
  ParamsResponse loadParams = ParamsResponse();
  Student student = Student();
  Profile teacher = Profile();
  String errorMessage = "";
  Info infos = Info();

  bool _isFetching = true;
  bool isUpdated = false;
  bool _isUpdating = false;
  bool isUploaded = false;

  bool get isUpdating => _isUpdating;
  bool get isFetching => _isFetching;
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
      print(e);
    }
  }

  checkUser() async {
    if (loadParams.type == "T") {
      _getTeacherData();
    } else {
      _getStudentUserData();
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

  Future<bool> updateStudent(
      String registrationId,
      String firstname,
      String lastname,
      String email,
      String studentTimezone,
      String studentGMT) async {
    final updateResponse =
        await http.post(NetworkHelper.baseUrl + 'api/update-profile',
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({
              "RegistrationId": "$registrationId",
              "UserType": "${loadParams.type}",
              "FirstName": "$firstname",
              "LastName": "$lastname",
              "Email": "$email",
              "TimezoneInfo": "$studentTimezone",
              "TimezoneInfoGmt": "$studentGMT"
            }));
    if (updateResponse.statusCode == 200) {
      final result = json.decode(updateResponse.body);
      if (result['success'] == true) {
        isUpdated = true;
        notifyListeners();
      } else {
        isUpdated = false;
        errorMessage = result['message'];
        notifyListeners();
      }
    } else {
      isUpdated = false;
      notifyListeners();
    }
    return isUpdated;
  }

  Future<bool> upload(String base64Image) async {
    final uploadResponse = await http.post(
      NetworkHelper.baseUrl + 'api/upload-image',
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: json.encode(
        {
          "RegistrationId": "${loadParams.id}",
          "UserType": "${loadParams.type}",
          "File": ',' + base64Image
        },
      ),
    );
    if (uploadResponse.statusCode == 200) {
      final responseString = json.decode(uploadResponse.body);
      if (responseString['success'] == true) {
        isUploaded = true;
        notifyListeners();
      }
    } else {
      print(uploadResponse.statusCode);
    }
    print(base64Image);
    return isUploaded;
  }

  //Teacher
  _getTeacherData() async {
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
    } else {
      teacher = null;
      infos = null;
      _isFetching = false;
      notifyListeners();
    }
  }

  Future<bool> updateTeacher(
      String registrationId,
      String firstname,
      String lastname,
      String email,
      String phonenumber,
      String age,
      String gender,
      String address,
      String city,
      String teacherLivesIncountry,
      String teacherFromCountry,
      String teacherTimezone,
      String teacherGMT) async {
    final updateResponse =
        await http.post(NetworkHelper.baseUrl + 'api/update-profile',
            headers: {'Content-Type': 'application/json; charset=UTF-8'},
            body: json.encode({
              "RegistrationId": "$registrationId",
              "UserType": "${loadParams.type}",
              "FirstName": "$firstname",
              "LastName": "$lastname",
              "Email": "$email",
              "Phone": "$phonenumber",
              "Age": int.parse(age),
              "Gender": "$gender",
              "Address": "$address",
              "City": "$city",
              "CountryCode": "$teacherLivesIncountry",
              "CountryCodeFrom": "$teacherFromCountry",
              "TimezoneInfo": "$teacherTimezone",
              "TimezoneInfoGmt": "$teacherGMT"
            }));
    if (updateResponse.statusCode == 200) {
      final result = json.decode(updateResponse.body);
      if (result['success'] == true) {
        isUpdated = true;
        notifyListeners();
      } else {
        isUpdated = false;
        errorMessage = result['message'];
        notifyListeners();
      }
    } else {
      isUpdated = false;
      notifyListeners();
    }
    return isUpdated;
  }

  void setIsLoading(value) async {
    _isUpdating = value;
    notifyListeners();
  }
}
