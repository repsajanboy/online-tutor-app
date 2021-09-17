import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:justlearn/business_logic/models/articles/article_model.dart';
import 'package:justlearn/business_logic/models/utils/networking.dart';

import 'package:http/http.dart' as http;

class ArticlesProvider with ChangeNotifier {
  List<Result> result = [];
  List<Result> allArticles = [];
  Result singleArti = Result();
  bool _isFetching = false;
  int page = 1;

  Result articleL;
  bool get isFetching => _isFetching;

  Future<void> getArticleList(int index) async {
    _isFetching = true;
    notifyListeners();

    var url = NetworkHelper.baseUrl +
        "api/list-articles?category=blog&page=" +
        index.toString();
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // print(response.body);
      List<Result> articleList = List<Result>();
      final listt = json.decode(response.body)['result'];
      for (int i = 0; i < listt.length - 1; i++) {
        final listtt = Result.fromJson(listt[i]);
        articleList.add(listtt);
      }
      _isFetching = false;
      result.addAll(articleList);
      page++;
      notifyListeners();
    }
    _isFetching = false;
    notifyListeners();
  }

  Future<void> getAllArticles() async {
    var url = NetworkHelper.baseUrl + "api/list-articles-all?category=blog";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // print(response.body);
      List<Result> allArticle = List<Result>();
      final listt = json.decode(response.body)['result'];
      for (int i = 0; i < listt.length - 1; i++) {
        final listtt = Result.fromJson(listt[i]);
        allArticle.add(listtt);
      }
      allArticles.addAll(allArticle);
      notifyListeners();
    }
  }

  // Future<void> getArticle(String urlArticle) async {
  //   var url =
  //       NetworkHelper.baseUrl + "api/read-article?articleurl=" + urlArticle;

  //   final response = await http.get(url);
  //   if (response.statusCode == 200) {}
  // }

  // Future<void> singleArticle(String urlArticle) async {
  //   singleArti = result
  //       .where((element) => element.articleUrl == urlArticle)
  //       .first;
  //   print(singleArti.articleUrl);
  //   notifyListeners();
  // }

  void setFetching(value) {
    _isFetching = value;
    notifyListeners();
  }

  _setListNull() async {
    result = [];
    notifyListeners();
  }

  _setPageToOne() async {
    page = 1;
    notifyListeners();
  }

  get setListNull => _setListNull();
  get setPageToOne => _setPageToOne();
}
