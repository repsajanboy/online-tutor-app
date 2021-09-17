import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'dashboard_details_model.g.dart';

DashboardDetails dashboardDetailsFromJson(String str) => DashboardDetails.fromJson(json.decode(str));

String dashboardDetailsToJson(DashboardDetails data) => json.encode(data.toJson());

@JsonSerializable()
class DashboardDetails {
    DashboardDetails({
        this.dashboardDetails,
    });
    @JsonKey(nullable: true)
    DashboardDetailsClass dashboardDetails;

    factory DashboardDetails.fromJson(Map<String, dynamic> json) => _$DashboardDetailsFromJson(json);

    Map<String, dynamic> toJson() => _$DashboardDetailsToJson(this);

}

@JsonSerializable()
class DashboardDetailsClass {
    DashboardDetailsClass({
        this.isSessions,
        this.isRequest,
        this.profileType,
        this.profileImage,
        this.skypeId,
        this.videoUrl,
        this.shortIntroduction,
        this.phone,
        this.isLanguages,
        this.isResume,
        this.isPhoneValid,
        this.isVisible,
        this.isApproved,
        this.lessonsTotal,
        this.requestTotal,
        this.subscriptionLessons,
        this.subscriptionPlanLessons,
        this.trialPrice,
        this.price1,
        this.price5,
        this.price10,
        this.profileLanguageList,
        this.teacherCvList,
        this.order,
        this.completeFullName,
        this.completePhone,
        this.completeLivesIn,
        this.completeFromCountry,
        this.completeProfilePicture,
        this.completeIntroduction,
        this.completeVideo,
        this.completePrice,
        this.completeSchedule,
        this.completeGuide,
        this.completeCertificate,
        this.lessonRequestDashboard,
        this.subscriptionStatus,
        this.isTrialPeriod,
    });
    @JsonKey(nullable: true)
    bool isSessions;
    @JsonKey(nullable: true)
    bool isRequest;
    @JsonKey(nullable: true)
    dynamic profileType;
    @JsonKey(nullable: true)
    dynamic profileImage;
    @JsonKey(nullable: true)
    dynamic skypeId;
    @JsonKey(nullable: true)
    dynamic videoUrl;
    @JsonKey(nullable: true)
    dynamic shortIntroduction;
    @JsonKey(nullable: true)
    String phone;
    @JsonKey(nullable: true)
    bool isLanguages;
    @JsonKey(nullable: true)
    bool isResume;
    @JsonKey(nullable: true)
    bool isPhoneValid;
    @JsonKey(nullable: true)
    bool isVisible;
    @JsonKey(nullable: true)
    int isApproved;
    @JsonKey(nullable: true)
    int lessonsTotal;
    @JsonKey(nullable: true)
    int requestTotal;
    @JsonKey(nullable: true)
    int subscriptionLessons;
    @JsonKey(nullable: true)
    int subscriptionPlanLessons;
    @JsonKey(nullable: true)
    int trialPrice;
    @JsonKey(nullable: true)
    int price1;
    @JsonKey(nullable: true)
    int price5;
    @JsonKey(nullable: true)
    int price10;
    @JsonKey(nullable: true)
    dynamic profileLanguageList;
    @JsonKey(nullable: true)
    dynamic teacherCvList;
    @JsonKey(nullable: true)
    dynamic order;
    @JsonKey(nullable: true)
    bool completeFullName;
    @JsonKey(nullable: true)
    bool completePhone;
    @JsonKey(nullable: true)
    bool completeLivesIn;
    @JsonKey(nullable: true)
    bool completeFromCountry;
    @JsonKey(nullable: true)
    bool completeProfilePicture;
    @JsonKey(nullable: true)
    bool completeIntroduction;
    @JsonKey(nullable: true)
    bool completeVideo;
    @JsonKey(nullable: true)
    bool completePrice;
    @JsonKey(nullable: true)
    bool completeSchedule;
    @JsonKey(nullable: true)
    bool completeGuide;
    @JsonKey(nullable: true)
    bool completeCertificate;
    @JsonKey(nullable: true)
    dynamic lessonRequestDashboard;
    @JsonKey(nullable: true)
    int subscriptionStatus;
    @JsonKey(nullable: true)
    bool isTrialPeriod;

    factory DashboardDetailsClass.fromJson(Map<String, dynamic> json) => _$DashboardDetailsClassFromJson(json);

    Map<String, dynamic> toJson() => _$DashboardDetailsClassToJson(this);
} 