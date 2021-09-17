// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardDetails _$DashboardDetailsFromJson(Map<String, dynamic> json) {
  return DashboardDetails(
    dashboardDetails: json['dashboardDetails'] == null
        ? null
        : DashboardDetailsClass.fromJson(
            json['dashboardDetails'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DashboardDetailsToJson(DashboardDetails instance) =>
    <String, dynamic>{
      'dashboardDetails': instance.dashboardDetails,
    };

DashboardDetailsClass _$DashboardDetailsClassFromJson(
    Map<String, dynamic> json) {
  return DashboardDetailsClass(
    isSessions: json['isSessions'] as bool,
    isRequest: json['isRequest'] as bool,
    profileType: json['profileType'],
    profileImage: json['profileImage'],
    skypeId: json['skypeId'],
    videoUrl: json['videoUrl'],
    shortIntroduction: json['shortIntroduction'],
    phone: json['phone'] as String,
    isLanguages: json['isLanguages'] as bool,
    isResume: json['isResume'] as bool,
    isPhoneValid: json['isPhoneValid'] as bool,
    isVisible: json['isVisible'] as bool,
    isApproved: json['isApproved'] as int,
    lessonsTotal: json['lessonsTotal'] as int,
    requestTotal: json['requestTotal'] as int,
    subscriptionLessons: json['subscriptionLessons'] as int,
    subscriptionPlanLessons: json['subscriptionPlanLessons'] as int,
    trialPrice: json['trialPrice'] as int,
    price1: json['price1'] as int,
    price5: json['price5'] as int,
    price10: json['price10'] as int,
    profileLanguageList: json['profileLanguageList'],
    teacherCvList: json['teacherCvList'],
    order: json['order'],
    completeFullName: json['completeFullName'] as bool,
    completePhone: json['completePhone'] as bool,
    completeLivesIn: json['completeLivesIn'] as bool,
    completeFromCountry: json['completeFromCountry'] as bool,
    completeProfilePicture: json['completeProfilePicture'] as bool,
    completeIntroduction: json['completeIntroduction'] as bool,
    completeVideo: json['completeVideo'] as bool,
    completePrice: json['completePrice'] as bool,
    completeSchedule: json['completeSchedule'] as bool,
    completeGuide: json['completeGuide'] as bool,
    completeCertificate: json['completeCertificate'] as bool,
    lessonRequestDashboard: json['lessonRequestDashboard'],
    subscriptionStatus: json['subscriptionStatus'] as int,
    isTrialPeriod: json['isTrialPeriod'] as bool,
  );
}

Map<String, dynamic> _$DashboardDetailsClassToJson(
        DashboardDetailsClass instance) =>
    <String, dynamic>{
      'isSessions': instance.isSessions,
      'isRequest': instance.isRequest,
      'profileType': instance.profileType,
      'profileImage': instance.profileImage,
      'skypeId': instance.skypeId,
      'videoUrl': instance.videoUrl,
      'shortIntroduction': instance.shortIntroduction,
      'phone': instance.phone,
      'isLanguages': instance.isLanguages,
      'isResume': instance.isResume,
      'isPhoneValid': instance.isPhoneValid,
      'isVisible': instance.isVisible,
      'isApproved': instance.isApproved,
      'lessonsTotal': instance.lessonsTotal,
      'requestTotal': instance.requestTotal,
      'subscriptionLessons': instance.subscriptionLessons,
      'subscriptionPlanLessons': instance.subscriptionPlanLessons,
      'trialPrice': instance.trialPrice,
      'price1': instance.price1,
      'price5': instance.price5,
      'price10': instance.price10,
      'profileLanguageList': instance.profileLanguageList,
      'teacherCvList': instance.teacherCvList,
      'order': instance.order,
      'completeFullName': instance.completeFullName,
      'completePhone': instance.completePhone,
      'completeLivesIn': instance.completeLivesIn,
      'completeFromCountry': instance.completeFromCountry,
      'completeProfilePicture': instance.completeProfilePicture,
      'completeIntroduction': instance.completeIntroduction,
      'completeVideo': instance.completeVideo,
      'completePrice': instance.completePrice,
      'completeSchedule': instance.completeSchedule,
      'completeGuide': instance.completeGuide,
      'completeCertificate': instance.completeCertificate,
      'lessonRequestDashboard': instance.lessonRequestDashboard,
      'subscriptionStatus': instance.subscriptionStatus,
      'isTrialPeriod': instance.isTrialPeriod,
    };
