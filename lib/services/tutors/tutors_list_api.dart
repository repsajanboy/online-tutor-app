import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:justlearn/business_logic/models/tutors/tutors_model.dart';
import 'package:justlearn/business_logic/models/utils/networking.dart';

import 'package:http/http.dart' as http;

class TutorsListApi with ChangeNotifier {
  List<Tutors> tutors = [];
  List<Tutors> _nativeTutors = [];
  bool _isFetching = false;
  int page = 1;
  // String _iso;
  bool _isDone = false;

  // String get iso => _iso;
  bool get isFetching => _isFetching;
  bool get isDone => _isDone;
  List<Tutors> get nativeTutors => _nativeTutors;

  Future<void> getNativeTutorsList(String iso) async {
    _isFetching = true;
    notifyListeners();
    var url = NetworkHelper.baseUrl +
        "api/list-tutors?page=" +
        page.toString() +
        "&filter=$iso";
    print(url);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // print(response.body);
      List<Tutors> tutslist = List<Tutors>();
      final listt = json.decode(response.body);
      if (listt.length == 0) {
        _isDone = true;
        notifyListeners();
      }

      for (int i = 0; i < listt.length; i++) {
        final listtt = Tutors.fromJson(listt[i]);
        tutslist.add(listtt);
      }
      // tutors.addAll(tutslist);
      _nativeTutors.addAll(tutslist);
      page++;
      notifyListeners();
    }
    _isFetching = false;
    notifyListeners();
  }

  // setIso(String iso) {
  //   _iso = iso;
  //   notifyListeners();
  // }

  void setFetching(value) {
    _isFetching = value;
    notifyListeners();
  }

  clearData() {
    tutors = [];
    _nativeTutors = [];
    page = 1;
    _isDone = false;
    notifyListeners();
  }

  Future<void> getTutorsList() async {
    var url = NetworkHelper.baseUrl + "api/list-tutors?page=" + page.toString();
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<Tutors> tutslist = List<Tutors>();
      final listt = json.decode(response.body);
      if (listt.length == 0) {
        _isDone = true;
        notifyListeners();
      }
      for (int i = 0; i < listt.length - 1; i++) {
        final listtt = Tutors.fromJson(listt[i]);
        tutslist.add(listtt);
      }
      // tutors.addAll(tutslist);
      _nativeTutors.addAll(tutslist);
      page++;
      notifyListeners();
    }
    setFetching(false);
  }

  // setListNull() async {
  //   tutors = [];
  //   notifyListeners();
  // }

  // setPageToOne() {
  //   page = 1;
  //   notifyListeners();
  // }

  // get setListNull => _setListNull();
  // get setPageToOne => _setPageToOne();
}
