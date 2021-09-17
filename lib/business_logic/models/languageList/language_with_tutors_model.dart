// To parse this JSON data, do
//
//     final languageWithTutors = languageWithTutorsFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'language_with_tutors_model.g.dart';

List<LanguageWithTutors> languageWithTutorsFromJson(String str) =>
    List<LanguageWithTutors>.from(
        json.decode(str).map((x) => LanguageWithTutors.fromJson(x)));

String languageWithTutorsToJson(List<LanguageWithTutors> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class LanguageWithTutors {
  LanguageWithTutors({
    this.language,
    this.tutors,
  });
  @JsonKey(nullable: true)
  String language;
  @JsonKey(nullable: true)
  List<Tutor> tutors;
  factory LanguageWithTutors.fromJson(Map<String, dynamic> json) =>
      _$LanguageWithTutorsFromJson(json);

  Map<String, dynamic> toJson() => _$LanguageWithTutorsToJson(this);
}

@JsonSerializable()
class Tutor {
  Tutor({
    this.profile,
    this.countryFrom,
  });
  @JsonKey(nullable: true)
  Profile profile;
  @JsonKey(nullable: true)
  String countryFrom;

  factory Tutor.fromJson(Map<String, dynamic> json) => _$TutorFromJson(json);

  Map<String, dynamic> toJson() => _$TutorToJson(this);
}

@JsonSerializable()
class Profile {
  Profile({
    this.age,
    this.cityOptions,
    this.approvalStatus,
    this.availableTrial,
    this.averageGrade,
    this.canTakeClass,
    this.country,
    this.countryCode,
    this.countryCodeFrom,
    this.discountProcent,
    this.emailId,
    this.imageRelativePath,
    this.index,
    this.isActive,
    this.isFavourite,
    this.maxRatePerHour,
    this.maxRatePerHourCurrency,
    this.minRatePerHour,
    this.minRatePerHourCurrency,
    this.name,
    this.modifyDate,
    this.lastOnline,
    this.profileIamgeThumb,
    this.profileImage,
    this.profileImageTile,
    this.rating,
    this.ratingAverage,
    this.ratingAverageLessons,
    this.ratingProcent,
    this.ratingString,
    this.registrationId,
    this.totalCompletedSessions,
    this.totalCompletedSessionsSinceMarch,
    this.shortIntroduction,
    this.subjectIds,
    this.subjectNames,
    this.languageIso,
    this.languageIsoName,
    this.teacherType,
    this.teacherTypeFull,
    this.teacherUniqueName,
    this.totalReviews,
    this.totalSessions,
    this.notFoundLanguage,
    this.notFoundCountry,
    this.trialPrice,
    this.trialPriceCurrency,
    this.commonPrice,
    this.commonPriceCurrency,
    this.price1,
    this.price1Currency,
    this.price5,
    this.price5Currency,
    this.price10,
    this.price10Currency,
    this.userName,
    this.teacherUrl,
    this.videoUrl,
    this.lastActive,
    this.staffReviewed,
    this.isApproved,
    this.firstName,
    this.lastName,
    this.description,
    this.teacherProfileId,
    this.teacherTypeName,
    this.status,
    this.createDate,
    this.createDateRank,
    this.offeringTrial,
    this.phone,
    this.skills,
    this.totalStudents,
    this.teacherCv,
    this.profileLanguageList,
    this.teacherReviewList,
    this.slotWeek,
    this.totalResults,
    this.userId,
    this.subscriptionLessons,
    this.subscriptionStatus,
    this.teachCategory,
    this.teachCategoryArray,
  });
  @JsonKey(nullable: true)
  int age;
  @JsonKey(nullable: true)
  dynamic cityOptions;
  @JsonKey(nullable: true)
  int approvalStatus;
  @JsonKey(nullable: true)
  bool availableTrial;
  @JsonKey(nullable: true)
  int averageGrade;
  @JsonKey(nullable: true)
  bool canTakeClass;
  @JsonKey(nullable: true)
  String country;
  @JsonKey(nullable: true)
  String countryCode;
  @JsonKey(nullable: true)
  String countryCodeFrom;
  @JsonKey(nullable: true)
  double discountProcent;
  @JsonKey(nullable: true)
  dynamic emailId;
  @JsonKey(nullable: true)
  String imageRelativePath;
  @JsonKey(nullable: true)
  int index;
  @JsonKey(nullable: true)
  bool isActive;
  @JsonKey(nullable: true)
  bool isFavourite;
  @JsonKey(nullable: true)
  double maxRatePerHour;
  @JsonKey(nullable: true)
  String maxRatePerHourCurrency;
  @JsonKey(nullable: true)
  double minRatePerHour;
  @JsonKey(nullable: true)
  String minRatePerHourCurrency;
  @JsonKey(nullable: true)
  String name;
  @JsonKey(nullable: true)
  DateTime modifyDate;
  @JsonKey(nullable: true)
  DateTime lastOnline;
  @JsonKey(nullable: true)
  String profileIamgeThumb;
  @JsonKey(nullable: true)
  String profileImage;
  @JsonKey(nullable: true)
  String profileImageTile;
  @JsonKey(nullable: true)
  int rating;
  @JsonKey(nullable: true)
  double ratingAverage;
  @JsonKey(nullable: true)
  int ratingAverageLessons;
  @JsonKey(nullable: true)
  int ratingProcent;
  @JsonKey(nullable: true)
  dynamic ratingString;
  @JsonKey(nullable: true)
  int registrationId;
  @JsonKey(nullable: true)
  int totalCompletedSessions;
  @JsonKey(nullable: true)
  int totalCompletedSessionsSinceMarch;
  @JsonKey(nullable: true)
  String shortIntroduction;
  @JsonKey(nullable: true)
  String subjectIds;
  @JsonKey(nullable: true)
  String subjectNames;
  @JsonKey(nullable: true)
  String languageIso;
  @JsonKey(nullable: true)
  String languageIsoName;
  @JsonKey(nullable: true)
  String teacherType;
  @JsonKey(nullable: true)
  String teacherTypeFull;
  @JsonKey(nullable: true)
  dynamic teacherUniqueName;
  @JsonKey(nullable: true)
  int totalReviews;
  @JsonKey(nullable: true)
  int totalSessions;
  @JsonKey(nullable: true)
  bool notFoundLanguage;
  @JsonKey(nullable: true)
  bool notFoundCountry;
  @JsonKey(nullable: true)
  double trialPrice;
  @JsonKey(nullable: true)
  String trialPriceCurrency;
  @JsonKey(nullable: true)
  double commonPrice;
  @JsonKey(nullable: true)
  String commonPriceCurrency;
  @JsonKey(nullable: true)
  double price1;
  @JsonKey(nullable: true)
  dynamic price1Currency;
  @JsonKey(nullable: true)
  double price5;
  @JsonKey(nullable: true)
  dynamic price5Currency;
  @JsonKey(nullable: true)
  double price10;
  @JsonKey(nullable: true)
  dynamic price10Currency;
  @JsonKey(nullable: true)
  dynamic userName;
  @JsonKey(nullable: true)
  String teacherUrl;
  @JsonKey(nullable: true)
  String videoUrl;
  @JsonKey(nullable: true)
  DateTime lastActive;
  @JsonKey(nullable: true)
  bool staffReviewed;
  @JsonKey(nullable: true)
  bool isApproved;
  @JsonKey(nullable: true)
  String firstName;
  @JsonKey(nullable: true)
  String lastName;
  @JsonKey(nullable: true)
  String description;
  @JsonKey(nullable: true)
  dynamic teacherProfileId;
  @JsonKey(nullable: true)
  dynamic teacherTypeName;
  @JsonKey(nullable: true)
  int status;
  @JsonKey(nullable: true)
  DateTime createDate;
  @JsonKey(nullable: true)
  DateTime createDateRank;
  @JsonKey(nullable: true)
  bool offeringTrial;
  @JsonKey(nullable: true)
  dynamic phone;
  @JsonKey(nullable: true)
  String skills;
  @JsonKey(nullable: true)
  int totalStudents;
  @JsonKey(nullable: true)
  List<TeacherCv> teacherCv;
  @JsonKey(nullable: true)
  List<ProfileLanguageList> profileLanguageList;
  @JsonKey(nullable: true)
  TeacherReviewList teacherReviewList;
  @JsonKey(nullable: true)
  List<SlotWeek> slotWeek;
  @JsonKey(nullable: true)
  int totalResults;
  @JsonKey(nullable: true)
  int userId;
  @JsonKey(nullable: true)
  int subscriptionLessons;
  @JsonKey(nullable: true)
  int subscriptionStatus;
  @JsonKey(nullable: true)
  String teachCategory;
  @JsonKey(nullable: true)
  List<String> teachCategoryArray;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

@JsonSerializable()
class ProfileLanguageList {
  ProfileLanguageList({
    this.profileLanguageId,
    this.languageName,
    this.languageIso,
    this.languageId,
    this.levelName,
    this.levelId,
    this.createDate,
  });
  @JsonKey(nullable: true)
  int profileLanguageId;
  @JsonKey(nullable: true)
  String languageName;
  @JsonKey(nullable: true)
  String languageIso;
  @JsonKey(nullable: true)
  int languageId;
  @JsonKey(nullable: true)
  String levelName;
  @JsonKey(nullable: true)
  int levelId;
  @JsonKey(nullable: true)
  DateTime createDate;

  factory ProfileLanguageList.fromJson(Map<String, dynamic> json) =>
      _$ProfileLanguageListFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileLanguageListToJson(this);
}

@JsonSerializable()
class SlotWeek {
  SlotWeek({
    this.isAvailable,
    this.date,
    this.teacherId,
    this.dayCode,
  });
  @JsonKey(nullable: true)
  int isAvailable;
  @JsonKey(nullable: true)
  DateTime date;
  @JsonKey(nullable: true)
  dynamic teacherId;
  @JsonKey(nullable: true)
  String dayCode;

  factory SlotWeek.fromJson(Map<String, dynamic> json) =>
      _$SlotWeekFromJson(json);

  Map<String, dynamic> toJson() => _$SlotWeekToJson(this);
}

@JsonSerializable()
class TeacherCv {
  TeacherCv({
    this.registrationId,
    this.cvId,
    this.title,
    this.type,
    this.place,
    this.description,
    this.category,
    this.startYear,
    this.endYear,
  });
  @JsonKey(nullable: true)
  int registrationId;
  @JsonKey(nullable: true)
  int cvId;
  @JsonKey(nullable: true)
  String title;
  @JsonKey(nullable: true)
  String type;
  @JsonKey(nullable: true)
  String place;
  @JsonKey(nullable: true)
  String description;
  @JsonKey(nullable: true)
  int category;
  @JsonKey(nullable: true)
  String startYear;
  @JsonKey(nullable: true)
  String endYear;

  factory TeacherCv.fromJson(Map<String, dynamic> json) =>
      _$TeacherCvFromJson(json);

  Map<String, dynamic> toJson() => _$TeacherCvToJson(this);
}

@JsonSerializable()
class TeacherReviewList {
  TeacherReviewList({
    this.reviews,
  });
  @JsonKey(nullable: true)
  List<Review> reviews;

  factory TeacherReviewList.fromJson(Map<String, dynamic> json) =>
      _$TeacherReviewListFromJson(json);

  Map<String, dynamic> toJson() => _$TeacherReviewListToJson(this);
}

@JsonSerializable()
class Review {
  Review({
    this.childName,
    this.endDate,
    this.endDateTime,
    this.feedbackById,
    this.feedbackByType,
    this.feedbackText,
    this.imageRelativePath,
    this.profileIamgeThumb,
    this.profileImage,
    this.profileImageTile,
    this.rating,
    this.ratingSkills,
    this.ratingQuality,
    this.ratingMaterials,
    this.ratingPunctuality,
    this.ratingCommunication,
    this.ratingRecommend,
    this.sessionId,
    this.sessionType,
    this.slotDuration,
    this.startDate,
    this.startDateTime,
    this.status,
    this.studentId,
    this.studentName,
    this.subjectId,
    this.subjectName,
    this.teacherId,
    this.teacherName,
  });
  @JsonKey(nullable: true)
  String childName;
  @JsonKey(nullable: true)
  DateTime endDate;
  @JsonKey(nullable: true)
  String endDateTime;
  @JsonKey(nullable: true)
  int feedbackById;
  @JsonKey(nullable: true)
  String feedbackByType;
  @JsonKey(nullable: true)
  String feedbackText;
  @JsonKey(nullable: true)
  dynamic imageRelativePath;
  @JsonKey(nullable: true)
  dynamic profileIamgeThumb;
  @JsonKey(nullable: true)
  String profileImage;
  @JsonKey(nullable: true)
  dynamic profileImageTile;
  @JsonKey(nullable: true)
  String rating;
  @JsonKey(nullable: true)
  String ratingSkills;
  @JsonKey(nullable: true)
  String ratingQuality;
  @JsonKey(nullable: true)
  String ratingMaterials;
  @JsonKey(nullable: true)
  String ratingPunctuality;
  @JsonKey(nullable: true)
  String ratingCommunication;
  @JsonKey(nullable: true)
  String ratingRecommend;
  @JsonKey(nullable: true)
  int sessionId;
  @JsonKey(nullable: true)
  String sessionType;
  @JsonKey(nullable: true)
  String slotDuration;
  @JsonKey(nullable: true)
  DateTime startDate;
  @JsonKey(nullable: true)
  String startDateTime;
  @JsonKey(nullable: true)
  String status;
  @JsonKey(nullable: true)
  int studentId;
  @JsonKey(nullable: true)
  String studentName;
  @JsonKey(nullable: true)
  int subjectId;
  @JsonKey(nullable: true)
  String subjectName;
  @JsonKey(nullable: true)
  int teacherId;
  @JsonKey(nullable: true)
  String teacherName;

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}
