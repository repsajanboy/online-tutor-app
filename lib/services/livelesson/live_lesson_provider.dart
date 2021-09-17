import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:justlearn/business_logic/models/liveLesson/live_lesson_model.dart';
import 'package:justlearn/business_logic/models/utils/networking.dart';

class LiveLessonProvider with ChangeNotifier {
  LiveLesson liveLesson = LiveLesson();
  bool isLoading = false;

  Future<LiveLesson> getLiveLesson(String regId, String studentName) async {
    print(regId + ' ' + studentName);
    var url = NetworkHelper.baseUrl +
        'api/live-english-lesson?userregistrationid=$regId&studentname=$studentName';
    final response = await http.get(url);
    if(response.statusCode == 200){
      final result = LiveLesson.fromJson(json.decode(response.body));
      liveLesson = result;
      isLoading = true;
      notifyListeners();
    } else {
      print(response.statusCode);
    }
    return liveLesson;
  }
}
