import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:justlearn/business_logic/models/auth/params_model.dart';
import 'package:justlearn/business_logic/models/lessons/lessons_model.dart';
import 'package:justlearn/business_logic/models/utils/networking.dart';

import '../shared_preference.dart';

class LessonListApi with ChangeNotifier {
  List<Sessionlist> sessionList = [];
  ParamsResponse loadParams = ParamsResponse();
  bool _isFetchingLessons = false;
  int page = 1;

  bool get isFetchingLessons => _isFetchingLessons;

  get loadParamsAsync => _loadParams();

  _loadParams() async {
    try {
      ParamsResponse params =
          ParamsResponse.fromJson(await SharedPref().read("params"));
      loadParams = params;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> getLessonsList(int index) async {
    _isFetchingLessons = true;
    notifyListeners();
    await _loadParams();
    var url = NetworkHelper.baseUrl +
        'api/list-lessons?userregistrationid=${loadParams.id}&usertype=T&zone=${loadParams.timezone}&timezoneinfo=${loadParams.timezoneinfo}&page=' +
        index.toString();

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final lessonList = json.decode(response.body);
      final lessonss = Lessons.fromJson(lessonList);
      List<Sessionlist> allSessions = List<Sessionlist>();
      for (int i = 0; i < lessonss.sessionlist.length; i++) {
        final ses = lessonss.sessionlist[i];
        allSessions.add(ses);
      }
      sessionList.addAll(allSessions);
      page++;
      notifyListeners();
    }

    _isFetchingLessons = false;
    notifyListeners();
  }

  setListNull() async {
    sessionList = [];
    page = 1;
    notifyListeners();
  }

  // get setListNull => _setListNull();
}
