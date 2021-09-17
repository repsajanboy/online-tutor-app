import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'article_model.g.dart';

Article articleFromJson(String str) => Article.fromJson(json.decode(str));

String articleToJson(Article data) => json.encode(data.toJson());


@JsonSerializable()
class Article {
  Article({
    this.success,
    this.message,
    this.result,
  });
  
  @JsonKey(nullable: true)
  bool success;
  @JsonKey(nullable: true)
  String message;
  @JsonKey(nullable: true)
  List<Result> result;

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);

}

List<Result> resultFromJson(String str) => List<Result>.from(json.decode(str).map((x) => Result.fromJson(x)));

String resultToJson(List<Result> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class Result {
  Result({
    this.authorId,
    this.authorName,
    this.authorProfile,
    this.authorType,
    this.articleUrl,
    this.contentText,
    this.createDate,
    this.readByTime,
    this.headLine,
    this.id,
    this.image,
    this.imagePath,
    this.imageSourceUrl,
    this.imageSourceUrlPreview,
    this.isActive,
    this.recommendedTeachers,
    this.thumbImage,
    this.tileImage,
    this.topicId,
    this.topiclist,
    this.topicName,
    this.uniqueTitle,
    this.category,
    this.articleList,
    this.articlesFaq,
    this.modifyDate,
  });

  @JsonKey(nullable: true)
  int authorId;
  @JsonKey(nullable: true)
  String authorName;
  @JsonKey(nullable: true)
  dynamic authorProfile;
  @JsonKey(nullable: true)
  String authorType; 
  @JsonKey(nullable: true)
  String articleUrl;
  @JsonKey(nullable: true)
  String contentText;
  @JsonKey(nullable: true)
  DateTime createDate;
  @JsonKey(nullable: true)
  String readByTime;
  @JsonKey(nullable: true)
  String headLine;
  @JsonKey(nullable: true)
  int id;
  @JsonKey(nullable: true)
  String image;
  @JsonKey(nullable: true)
  String imagePath; 
  @JsonKey(nullable: true)
  dynamic imageSourceUrl;
  @JsonKey(nullable: true)
  dynamic imageSourceUrlPreview;
  @JsonKey(nullable: true)
  bool isActive;
  @JsonKey(nullable: true)
  List<dynamic> recommendedTeachers; 

  @JsonKey(nullable: true)
  String thumbImage;
  @JsonKey(nullable: true)
  String tileImage;
  @JsonKey(nullable: true)
  int topicId;
  @JsonKey(nullable: true)
  dynamic topiclist; 
  @JsonKey(nullable: true)
  String topicName;
  @JsonKey(nullable: true)
  String uniqueTitle;
  @JsonKey(nullable: true)
  String category;
  @JsonKey(nullable: true)
  dynamic articleList;
  @JsonKey(nullable: true)
  ArtoclesFac articlesFaq;
  @JsonKey(nullable: true)
  DateTime modifyDate; 

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

ArtoclesFac artoclesFacFromJson(String str) => ArtoclesFac.fromJson(json.decode(str));

String artoclesFacToJson(Article data) => json.encode(data.toJson());

@JsonSerializable()
class ArtoclesFac {
  ArtoclesFac({
    this.articleFaqId,
    this.articleId,
    this.faqTitle1,
    this.faqAnswer1,
    this.faqTitle2,
    this.faqAnswer2,
    this.faqTitle3,
    this.faqAnswer3,
    this.faqTitle4,
    this.faqAnswer4,
    this.faqTitle5,
    this.faqAnswer5,
    this.faqTitle6,
    this.faqAnswer6,
    this.faqTitle7,
    this.faqAnswer7,
    this.faqTitle8,
    this.faqAnswer8,
    this.faqTitle9,
    this.faqAnswer9,
    this.faqTitle10,
    this.faqAnswer10,
    this.faqTitle11,
    this.faqAnswer11,
    this.faqTitle12,
    this.faqAnswer12,
    this.faqTitle13,
    this.faqAnswer13,
    this.faqTitle14,
    this.faqAnswer14,
    this.faqTitle15,
    this.faqAnswer15,
    this.faqTitle16,
    this.faqAnswer16,
    this.faqTitle17,
    this.faqAnswer17,
    this.faqTitle18,
    this.faqAnswer18,
    this.faqTitle19,
    this.faqAnswer19,
    this.faqTitle20,
    this.faqAnswer20,
    this.createDate,
    this.modifyDate,
  });

  @JsonKey(nullable: true)
  int articleFaqId;
  @JsonKey(nullable: true)
  int articleId;
  @JsonKey(nullable: true)
  String faqTitle1;
  @JsonKey(nullable: true)
  String faqAnswer1; 
  @JsonKey(nullable: true)
  String faqTitle2;
  @JsonKey(nullable: true)
  String faqAnswer2;
  @JsonKey(nullable: true)
  String faqTitle3;
  @JsonKey(nullable: true)
  String faqAnswer3;
  @JsonKey(nullable: true)
  String faqTitle4;
  @JsonKey(nullable: true)
  String faqAnswer4;
  @JsonKey(nullable: true)
  String faqTitle5;
  @JsonKey(nullable: true)
  String faqAnswer5; 
  @JsonKey(nullable: true)
  String faqTitle6;
  @JsonKey(nullable: true)
  String faqAnswer6;
  @JsonKey(nullable: true)
  String faqTitle7;
  @JsonKey(nullable: true)
  String faqAnswer7; 
  @JsonKey(nullable: true)
  String faqTitle8;
  @JsonKey(nullable: true)
  String faqAnswer8;
  @JsonKey(nullable: true)
  String faqTitle9;
  @JsonKey(nullable: true)
  String faqAnswer9; 
  @JsonKey(nullable: true)
  String faqTitle10;
  @JsonKey(nullable: true)
  String faqAnswer10;
  @JsonKey(nullable: true)
  String faqTitle11;
  @JsonKey(nullable: true)
  String faqAnswer11;
  @JsonKey(nullable: true)
  String faqTitle12;
  @JsonKey(nullable: true)
  String faqAnswer12;
  @JsonKey(nullable: true)
  String faqTitle13;
  @JsonKey(nullable: true)
  String faqAnswer13; 
  @JsonKey(nullable: true)
  String faqTitle14;
  @JsonKey(nullable: true)
  String faqAnswer14;
  @JsonKey(nullable: true)
  String faqTitle15;
  @JsonKey(nullable: true)
  String faqAnswer15; 
    @JsonKey(nullable: true)
  String faqTitle16;
  @JsonKey(nullable: true)
  String faqAnswer16; 
  @JsonKey(nullable: true)
  String faqTitle17;
  @JsonKey(nullable: true)
  String faqAnswer17;
  @JsonKey(nullable: true)
  String faqTitle18;
  @JsonKey(nullable: true)
  String faqAnswer18;
  @JsonKey(nullable: true)
  String faqTitle19;
  @JsonKey(nullable: true)
  String faqAnswer19;
  @JsonKey(nullable: true)
  String faqTitle20;
  @JsonKey(nullable: true)
  String faqAnswer20; 
  @JsonKey(nullable: true)
  DateTime createDate;
  @JsonKey(nullable: true)
  DateTime modifyDate;

  factory ArtoclesFac.fromJson(Map<String, dynamic> json) => _$ArtoclesFacFromJson(json);

  Map<String, dynamic> toJson() => _$ArtoclesFacToJson(this);
}
