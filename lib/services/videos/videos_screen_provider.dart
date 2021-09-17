import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:justlearn/business_logic/models/utils/networking.dart';
import 'package:justlearn/business_logic/models/videoslist/videos_list_model.dart';

import 'package:http/http.dart' as http;

class VideosProvider with ChangeNotifier {
  VideosList videosList = VideosList();
  List<VideoCourse> approvedVideos = [];
  List<VideoCourse> filteredVideos = [];
  List<String> approvedCategories = [];
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  Future<void> getAllVideos() async {
    var url = NetworkHelper.baseUrl + "api/list-videocourse-v2";

    final response = await http.get(url);
    if (response.statusCode == 200) {
      filteredVideos = [];
      notifyListeners();
      final result = VideosList.fromJson(json.decode(response.body));
      videosList = result;
      approvedCategories.addAll(result.result.categoriesApproved);
      List<VideoCourse> vidApproved = List<VideoCourse>();
      for (int i = 0; i < videosList.result.videoCourses.length; i++) {
        if (videosList.result.videoCourses[i].courseIsApproved == 1) {
          vidApproved.add((videosList.result.videoCourses[i]));
        }
      }
      filteredVideos.addAll(vidApproved);
      approvedVideos.addAll(vidApproved);
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> filterVideo(String category) async {
    filteredVideos = [];
    notifyListeners();
    var url = NetworkHelper.baseUrl + "api/list-videocourse-v2";

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final result = VideosList.fromJson(json.decode(response.body));
      videosList = result;
      approvedCategories.addAll(result.result.categoriesApproved);
      List<VideoCourse> vidApproved = List<VideoCourse>();
      for (int i = 0; i < videosList.result.videoCourses.length; i++) {
        if (videosList.result.videoCourses[i].category == category) {
          vidApproved.add((videosList.result.videoCourses[i]));
        }
      }
      print(vidApproved.length);
      filteredVideos.addAll(vidApproved);
      _isLoading = false;
      notifyListeners();
    }
  }
}
