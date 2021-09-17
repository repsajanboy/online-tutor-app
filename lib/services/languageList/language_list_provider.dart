import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:justlearn/business_logic/models/languageList/language_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:justlearn/business_logic/models/languageList/language_with_tutors_model.dart';
import 'package:justlearn/business_logic/models/tutors/tutors_model.dart';
import 'package:justlearn/business_logic/models/utils/networking.dart';

class LanguageListProvider with ChangeNotifier {
  LanguageList languageList;
  List<LanguageResult> _languageRes = [];
  LanguageResult _selectedLanguage;
  List<LanguageResult> _filteredLanguages;
  List<LanguageWithTutors> languageListWithTutors = [];
  List<String> languages = [];
  List<Tutor> languagesTutors = [];

  List<LanguageResult> get languageRes => _languageRes;
  LanguageResult get selectedLanguage => _selectedLanguage;
  List<LanguageResult> get filteredLanguages => _filteredLanguages;

  Future<void> getLanguageList() async {
    var url = NetworkHelper.baseUrl + 'api/list-languages';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      languageList = LanguageList.fromJson(json.decode(response.body));
      _languageRes = languageList.result;
      notifyListeners();
    } else {
      print(response.statusCode);
    }
  }

  Future<void> getLanguageListWithTutors() async {
    var url = NetworkHelper.baseUrl + "api/list-language-tutors";
    final response = await http.get(url);
    if(response.statusCode == 200) {
      final listLanguageTutors = json.decode(response.body);
      List<LanguageWithTutors> allLanguage = List<LanguageWithTutors>();
      for(int i=0; i < listLanguageTutors.length; i++){
        allLanguage.add(LanguageWithTutors.fromJson(listLanguageTutors[i]));
      }
      languageListWithTutors.addAll(allLanguage);
      notifyListeners();
    }
  }

  selectLanguage(LanguageResult selectedLanguage) {
    _selectedLanguage = selectedLanguage;
    notifyListeners();
  }

  filterLanguage(String filter) {
    _filteredLanguages = _languageRes
        .where((element) => element.isoName.contains(filter))
        .toList();

    notifyListeners();
  }
}
