import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:justlearn/business_logic/models/auth/params_model.dart';
import 'package:http/http.dart' as http;
import 'package:justlearn/business_logic/models/utils/networking.dart';
import 'package:timetable/timetable.dart';

import '../shared_preference.dart';

class ActionButtonsProvider with ChangeNotifier {
  bool isCancelSuccess = false;
  bool isNewLessonSuccess = false;
  bool isEditLessonSuccess = false;
  bool isRequestRefundSuccess = false;
  bool isSendRefundSuccess = false;
  bool isMarkasCompleted = false;
  bool isSendReview = false;
  bool isReviewValid = false;
  bool isMoreLessonLoads = false;
  bool isMoreLesson = false;
  bool isMoreLessonTrial = false;
  bool _isLoading = false;
  ParamsResponse loadParams;

  bool get isLoading => _isLoading;

  get loadParamsAsync => _loadParams();

  _loadParams() async {
    print('action_button_loaded');
    try {
      ParamsResponse params =
          ParamsResponse.fromJson(await SharedPref().read("params"));
      loadParams = params;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> bookLessonApi(int teacherId, BasicEvent event) async {
    final response = await http.post(NetworkHelper.baseUrl + 'api/book-session',
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          "RegistrationId": "${loadParams.id}",
          "TeacherId": teacherId,
          "StartTime": "${event.start.toDateTimeLocal().toUtc()}"
        }));
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['success'] == true) {
        isNewLessonSuccess = true;
        notifyListeners();
      }
    }
    return isNewLessonSuccess;
  }

  Future<bool> editBookTimeApi(int sessionId, BasicEvent event) async {
    final response =
        await http.post(NetworkHelper.baseUrl + 'api/booked-session',
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({
              "SessionId": sessionId,
              "RegistrationId": "${loadParams.id}",
              "UserType": "${loadParams.type}",
              "StartDate": "${event.start.toDateTimeLocal().toUtc()}",
              "EndDate":
                  "${event.start.addMinutes(30).toDateTimeLocal().toUtc()}",
              "TimezoneInfo": "${loadParams.timezoneinfo}",
              "TimezoneInfoGmt": "${loadParams.timezone}"
            }));
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['success'] == true) {
        isEditLessonSuccess = true;
        notifyListeners();
      }
    }
    return isEditLessonSuccess;
  }

  Future<bool> cancelLessonApi(int sessionId) async {
    var url = NetworkHelper.baseUrl + "api/cancel-lesson";
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          "SessionId": sessionId,
          "RegistrationId": "${loadParams.id}",
          "UserType": "${loadParams.type}",
          "TimezoneInfo": "${loadParams.timezoneinfo}",
          "TimezoneInfoGmt": "${loadParams.timezone}",
          "Email": "${loadParams.email}"
        }));
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['success'] == true) {
        isCancelSuccess = true;
        notifyListeners();
      }
    }

    return isCancelSuccess;
  }

  Future<bool> requestRefundApi(
      int sessionId, int problemId, String message) async {
    var url = NetworkHelper.baseUrl + "api/request-refund";
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          "StudentId": "${loadParams.id}",
          "SessionId": sessionId,
          "ProblemId": problemId,
          "MessageText": "$message",
          "UserType": "${loadParams.type}",
          "TimezoneInfo": "${loadParams.timezoneinfo}",
          "TimezoneInfoGmt": "${loadParams.timezone}"
        }));
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['success'] == true) {
        isRequestRefundSuccess = true;
        notifyListeners();
      }
    }
    return isRequestRefundSuccess;
  }

  Future<bool> sendRefundApi(
      int sessionId, int solutionId, String message) async {
    var url = NetworkHelper.baseUrl + "api/send-refund";
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          "TeacherId": "${loadParams.id}",
          "SessionId": sessionId,
          "SolutionId": solutionId,
          "SolutionMessageText": "$message"
        }));
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['success'] == true) {
        isSendRefundSuccess = true;
        notifyListeners();
      }
    }
    return isSendRefundSuccess;
  }

  Future<bool> markasCompletedApi(
      int sessionId, int solutionId, String message) async {
    var url = NetworkHelper.baseUrl + "api/mark-completed";
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          "TeacherId": "${loadParams.id}",
          "SessionId": sessionId,
          "SolutionId": solutionId,
          "SolutionMessageText": "$message"
        }));
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['success'] == true) {
        isMarkasCompleted = true;
        notifyListeners();
      }
    }
    return isMarkasCompleted;
  }

  Future<bool> sendReview(int sessionId, String message) async {
    print(loadParams.id);
    print(sessionId);
    print(message);
    print(loadParams.timezoneinfo);
    print(loadParams.timezone);
    var url = NetworkHelper.baseUrl + "api/review-lesson";
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(
          {
            "RegistrationId": int.parse("${loadParams.id}"),
            "SessionId": sessionId,
            "Comment": "$message",
            "TimezoneInfo": "${loadParams.timezoneinfo}",
            "TimezoneInfoGmt": "${loadParams.timezone}"
          },
        ));
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['success'] == true) {
        isSendReview = true;
        notifyListeners();
      }
    } else {
      print(response.statusCode);
    }
    return isSendReview;
  }

  Future<bool> getMoreLesson(int planLesson) async {
    print(planLesson);
    print(loadParams.id);
    isMoreLessonLoads = true;
    notifyListeners();
    var url = NetworkHelper.baseUrl + "api/more-lessons-stripe";
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        "RegistrationId": int.parse("${loadParams.id}"),
        "Planlessons": planLesson
      }),
    );
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['success'] == true) {
        isMoreLesson = true;
        isMoreLessonLoads = false;
        notifyListeners();
      }
    } else {
      print(response.statusCode);
    }
    return isMoreLesson;
  }

  Future<bool> getMoreLessonTrial(int regId) async {
    print(regId);
    isMoreLessonLoads = true;
    notifyListeners();
    var url = NetworkHelper.baseUrl + "api/more-lessons-stripe-endtrial";
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({"RegistrationId": regId}),
    );
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['success'] == true) {
        isMoreLessonLoads = false;
        isMoreLessonTrial = true;
        notifyListeners();
      }
    } else {
      print("more-lesson-trial: " + response.statusCode.toString());
    }
    return isMoreLessonTrial;
  }

  void setIsLoading(value) async {
    _isLoading = value;
    notifyListeners();
  }

  void setReviewValid(bool value) async {
    isReviewValid = value;
    notifyListeners();
  }
}
