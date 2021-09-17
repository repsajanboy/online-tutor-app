import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'videos_list_model.g.dart';

VideosList videosListFromJson(String str) =>
    VideosList.fromJson(json.decode(str));

String videosListToJson(VideosList data) => json.encode(data.toJson());

@JsonSerializable()
class VideosList {
  VideosList({
    this.success,
    this.message,
    this.result,
  });
  @JsonKey(nullable: true)
  bool success;
  @JsonKey(nullable: true)
  String message;
  @JsonKey(nullable: true)
  VideoResult result;

  factory VideosList.fromJson(Map<String, dynamic> json) =>
      _$VideosListFromJson(json);

  Map<String, dynamic> toJson() => _$VideosListToJson(this);
}

@JsonSerializable()
class VideoResult {
  VideoResult({
    this.videoCourses,
    this.categories,
    this.categoriesApproved,
  });
  @JsonKey(nullable: true)
  List<VideoCourse> videoCourses;
  @JsonKey(nullable: true)
  List<String> categories;
  @JsonKey(nullable: true)
  List<String> categoriesApproved;

  factory VideoResult.fromJson(Map<String, dynamic> json) =>
      _$VideoResultFromJson(json);

  Map<String, dynamic> toJson() => _$VideoResultToJson(this);
}

@JsonSerializable()
class VideoCourse {
  VideoCourse({
    this.videoCourseId,
    this.registrationId,
    this.title,
    this.description,
    this.trailerVideoLink,
    this.courseVideoLink,
    this.createDate,
    this.modifyDate,
    this.courseTitleUrl,
    this.courseIsApproved,
    this.courseIsDeleted,
    this.videoThumbnail,
    this.subscriptionRequired,
    this.category,
    this.isPicked,
    this.learningScore,
    this.learningScoreDecimal,
    this.learningScoreString,
    this.learningScoreAll,
    this.registrationName,
    this.courseVideoLinkFile,
    this.videoLink,
    this.embedVideoV2,
    this.videoDuration,
    this.videoPlaylistId,
    this.videoCourses,
  });
  @JsonKey(nullable: true)
  int videoCourseId;
  @JsonKey(nullable: true)
  int registrationId;
  @JsonKey(nullable: true)
  String title;
  @JsonKey(nullable: true)
  String description;
  @JsonKey(nullable: true)
  String trailerVideoLink;
  @JsonKey(nullable: true)
  String courseVideoLink;
  @JsonKey(nullable: true)
  DateTime createDate;
  @JsonKey(nullable: true)
  DateTime modifyDate;
  @JsonKey(nullable: true)
  String courseTitleUrl;
  @JsonKey(nullable: true)
  int courseIsApproved;
  @JsonKey(nullable: true)
  int courseIsDeleted;
  @JsonKey(nullable: true)
  String videoThumbnail;
  @JsonKey(nullable: true)
  bool subscriptionRequired;
  @JsonKey(nullable: true)
  String category;
  @JsonKey(nullable: true)
  bool isPicked;
  @JsonKey(nullable: true)
  int learningScore;
  @JsonKey(nullable: true)
  double learningScoreDecimal;
  @JsonKey(nullable: true)
  String learningScoreString;
  @JsonKey(nullable: true)
  String learningScoreAll;
  @JsonKey(nullable: true)
  String registrationName;
  @JsonKey(nullable: true)
  String courseVideoLinkFile;
  @JsonKey(nullable: true)
  dynamic videoLink;
  @JsonKey(nullable: true)
  String embedVideoV2;
  @JsonKey(nullable: true)
  int videoDuration;
  @JsonKey(nullable: true)
  int videoPlaylistId;
  @JsonKey(nullable: true)
  List<VideoCourse> videoCourses;

  factory VideoCourse.fromJson(Map<String, dynamic> json) =>
      _$VideoCourseFromJson(json);

  Map<String, dynamic> toJson() => _$VideoCourseToJson(this);
}
