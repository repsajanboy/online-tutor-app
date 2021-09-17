import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'users_model.g.dart';

UsersTeacherProfile usersTeacherProfileFromJson(String str) => UsersTeacherProfile.fromJson(json.decode(str));

String usersTeacherProfileToJson(UsersTeacherProfile data) => json.encode(data.toJson());

@JsonSerializable()
class UsersTeacherProfile {
    UsersTeacherProfile({
        this.info,
    });
    @JsonKey(nullable: true)
    Info info;

    factory UsersTeacherProfile.fromJson(Map<String, dynamic> json) => _$UsersTeacherProfileFromJson(json);

    Map<String, dynamic> toJson() => _$UsersTeacherProfileToJson(this);
}

@JsonSerializable()
class Info {
    Info({
        this.profile,
        this.countryFrom,
    });
    @JsonKey(nullable: true)
    Profile profile;
    @JsonKey(nullable: true)
    String countryFrom;

    factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);

    Map<String, dynamic> toJson() => _$InfoToJson(this);
}

@JsonSerializable()
class Profile {
    Profile({
        this.address,
        this.age,
        this.canTakeClass,
        this.certificates,
        this.city,
        this.classId,
        this.country,
        this.countryCode,
        this.countryCodeFrom,
        this.creareDate,
        this.createDate,
        this.description,
        this.dob,
        this.dobDays,
        this.dobMonth,
        this.dobYear,
        this.totalLessons,
        this.email,
        this.firstName,
        this.gender,
        this.profileLanguage,
        this.isApproved,
        this.isCertificate,
        this.isCompleted,
        this.isVideoSystemHosted,
        this.lastName,
        this.maxRatePerHour,
        this.minRatePerHour,
        this.modifyDate,
        this.offeringTrial,
        this.phone,
        this.postalCode,
        this.profileImage,
        this.profileImagePath,
        this.rating,
        this.rawImageData,
        this.registrationId,
        this.shortIntroduction,
        this.languageIso,
        this.languageIsoName,
        this.status,
        this.teachingStatus,
        this.teacherProfileId,
        this.teachersubjectIds,
        this.teacherSubjects,
        this.teacherType,
        this.teacherTypeName,
        this.teacherUniqueName,
        this.thumbImage,
        this.tileImage,
        this.timeSetup,
        this.trialPrice,
        this.price,
        this.price1,
        this.price5,
        this.price10,
        this.videoUrl,
        this.teacherUrl,
        this.unsubscribe,
        this.timezoneInfo,
        this.timezoneInfoGmt,
        this.timezoneInfoForce,
        this.unsubscribeAll,
        this.responseResult,
        this.lastActive,
        this.lastOnline,
    });
    @JsonKey(nullable: true)
    String address;
    @JsonKey(nullable: true)
    int age;
    @JsonKey(nullable: true)
    bool canTakeClass;
    @JsonKey(nullable: true)
    List<dynamic> certificates;
    @JsonKey(nullable: true)
    String city;
    @JsonKey(nullable: true)
    int classId;
    @JsonKey(nullable: true)
    String country;
    @JsonKey(nullable: true)
    String countryCode;
    @JsonKey(nullable: true)
    String countryCodeFrom;
    @JsonKey(nullable: true)
    String creareDate;
    @JsonKey(nullable: true)
    DateTime createDate;
    @JsonKey(nullable: true)
    String description;
    @JsonKey(nullable: true)
    String dob;
    @JsonKey(nullable: true)
    dynamic dobDays;
    @JsonKey(nullable: true)
    dynamic dobMonth;
    @JsonKey(nullable: true)
    dynamic dobYear;
    @JsonKey(nullable: true)
    int totalLessons;
    @JsonKey(nullable: true)
    String email;
    @JsonKey(nullable: true)
    String firstName;
    @JsonKey(nullable: true)
    String gender;
    @JsonKey(nullable: true)
    List<ProfileLanguage> profileLanguage;
    @JsonKey(nullable: true)
    int isApproved;
    @JsonKey(nullable: true)
    int isCertificate;
    @JsonKey(nullable: true)
    int isCompleted;
    @JsonKey(nullable: true)
    bool isVideoSystemHosted;
    @JsonKey(nullable: true)
    String lastName;
    @JsonKey(nullable: true)
    int maxRatePerHour;
    @JsonKey(nullable: true)
    int minRatePerHour;
    @JsonKey(nullable: true)
    String modifyDate;
    @JsonKey(nullable: true)
    bool offeringTrial;
    @JsonKey(nullable: true)
    String phone;
    @JsonKey(nullable: true)
    String postalCode;
    @JsonKey(nullable: true)
    String profileImage;
    @JsonKey(nullable: true)
    dynamic profileImagePath;
    @JsonKey(nullable: true)
    int rating;
    @JsonKey(nullable: true)
    dynamic rawImageData;
    @JsonKey(nullable: true)
    String registrationId;
    @JsonKey(nullable: true)
    String shortIntroduction;
    @JsonKey(nullable: true)
    dynamic languageIso;
    @JsonKey(nullable: true)
    dynamic languageIsoName;
    @JsonKey(nullable: true)
    int status;
    @JsonKey(nullable: true)
    int teachingStatus;
    @JsonKey(nullable: true)
    String teacherProfileId;
    @JsonKey(nullable: true)
    String teachersubjectIds;
    @JsonKey(nullable: true)
    String teacherSubjects;
    @JsonKey(nullable: true)
    String teacherType;
    @JsonKey(nullable: true)
    dynamic teacherTypeName;
    @JsonKey(nullable: true)
    String teacherUniqueName;
    @JsonKey(nullable: true)
    dynamic thumbImage;
    @JsonKey(nullable: true)
    dynamic tileImage;
    @JsonKey(nullable: true)
    bool timeSetup;
    @JsonKey(nullable: true)
    double trialPrice;
    @JsonKey(nullable: true)
    int price;
    @JsonKey(nullable: true)
    int price1;
    @JsonKey(nullable: true)
    int price5;
    @JsonKey(nullable: true)
    int price10;
    @JsonKey(nullable: true)
    String videoUrl;
    @JsonKey(nullable: true)
    String teacherUrl;
    @JsonKey(nullable: true)
    dynamic unsubscribe;
    @JsonKey(nullable: true)
    String timezoneInfo;
    @JsonKey(nullable: true)
    String timezoneInfoGmt;
    @JsonKey(nullable: true)
    int timezoneInfoForce;
    @JsonKey(nullable: true)
    int unsubscribeAll;
    @JsonKey(nullable: true)
    int responseResult;
    @JsonKey(nullable: true)
    DateTime lastActive;
    @JsonKey(nullable: true)
    DateTime lastOnline;

    factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

    Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

@JsonSerializable()
class ProfileLanguage {
    ProfileLanguage({
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
    dynamic languageName;
    @JsonKey(nullable: true)
    String languageIso;
    @JsonKey(nullable: true)
    int languageId;
    @JsonKey(nullable: true)
    dynamic levelName;
    @JsonKey(nullable: true)
    int levelId;
    @JsonKey(nullable: true)
    DateTime createDate;

    factory ProfileLanguage.fromJson(Map<String, dynamic> json) => _$ProfileLanguageFromJson(json);

    Map<String, dynamic> toJson() => _$ProfileLanguageToJson(this);
}