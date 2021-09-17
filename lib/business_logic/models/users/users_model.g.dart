// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersTeacherProfile _$UsersTeacherProfileFromJson(Map<String, dynamic> json) {
  return UsersTeacherProfile(
    info: json['info'] == null
        ? null
        : Info.fromJson(json['info'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UsersTeacherProfileToJson(
        UsersTeacherProfile instance) =>
    <String, dynamic>{
      'info': instance.info,
    };

Info _$InfoFromJson(Map<String, dynamic> json) {
  return Info(
    profile: json['profile'] == null
        ? null
        : Profile.fromJson(json['profile'] as Map<String, dynamic>),
    countryFrom: json['countryFrom'] as String,
  );
}

Map<String, dynamic> _$InfoToJson(Info instance) => <String, dynamic>{
      'profile': instance.profile,
      'countryFrom': instance.countryFrom,
    };

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile(
    address: json['address'] as String,
    age: json['age'] as int,
    canTakeClass: json['canTakeClass'] as bool,
    certificates: json['certificates'] as List,
    city: json['city'] as String,
    classId: json['classId'] as int,
    country: json['country'] as String,
    countryCode: json['countryCode'] as String,
    countryCodeFrom: json['countryCodeFrom'] as String,
    creareDate: json['creareDate'] as String,
    createDate: json['createDate'] == null
        ? null
        : DateTime.parse(json['createDate'] as String),
    description: json['description'] as String,
    dob: json['dob'] as String,
    dobDays: json['dobDays'],
    dobMonth: json['dobMonth'],
    dobYear: json['dobYear'],
    totalLessons: json['totalLessons'] as int,
    email: json['email'] as String,
    firstName: json['firstName'] as String,
    gender: json['gender'] as String,
    profileLanguage: (json['profileLanguage'] as List)
        ?.map((e) => e == null
            ? null
            : ProfileLanguage.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    isApproved: json['isApproved'] as int,
    isCertificate: json['isCertificate'] as int,
    isCompleted: json['isCompleted'] as int,
    isVideoSystemHosted: json['isVideoSystemHosted'] as bool,
    lastName: json['lastName'] as String,
    maxRatePerHour: json['maxRatePerHour'] as int,
    minRatePerHour: json['minRatePerHour'] as int,
    modifyDate: json['modifyDate'] as String,
    offeringTrial: json['offeringTrial'] as bool,
    phone: json['phone'] as String,
    postalCode: json['postalCode'] as String,
    profileImage: json['profileImage'] as String,
    profileImagePath: json['profileImagePath'],
    rating: json['rating'] as int,
    rawImageData: json['rawImageData'],
    registrationId: json['registrationId'] as String,
    shortIntroduction: json['shortIntroduction'] as String,
    languageIso: json['languageIso'],
    languageIsoName: json['languageIsoName'],
    status: json['status'] as int,
    teachingStatus: json['teachingStatus'] as int,
    teacherProfileId: json['teacherProfileId'] as String,
    teachersubjectIds: json['teachersubjectIds'] as String,
    teacherSubjects: json['teacherSubjects'] as String,
    teacherType: json['teacherType'] as String,
    teacherTypeName: json['teacherTypeName'],
    teacherUniqueName: json['teacherUniqueName'] as String,
    thumbImage: json['thumbImage'],
    tileImage: json['tileImage'],
    timeSetup: json['timeSetup'] as bool,
    trialPrice: (json['trialPrice'] as num)?.toDouble(),
    price: json['price'] as int,
    price1: json['price1'] as int,
    price5: json['price5'] as int,
    price10: json['price10'] as int,
    videoUrl: json['videoUrl'] as String,
    teacherUrl: json['teacherUrl'] as String,
    unsubscribe: json['unsubscribe'],
    timezoneInfo: json['timezoneInfo'] as String,
    timezoneInfoGmt: json['timezoneInfoGmt'] as String,
    timezoneInfoForce: json['timezoneInfoForce'] as int,
    unsubscribeAll: json['unsubscribeAll'] as int,
    responseResult: json['responseResult'] as int,
    lastActive: json['lastActive'] == null
        ? null
        : DateTime.parse(json['lastActive'] as String),
    lastOnline: json['lastOnline'] == null
        ? null
        : DateTime.parse(json['lastOnline'] as String),
  );
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'address': instance.address,
      'age': instance.age,
      'canTakeClass': instance.canTakeClass,
      'certificates': instance.certificates,
      'city': instance.city,
      'classId': instance.classId,
      'country': instance.country,
      'countryCode': instance.countryCode,
      'countryCodeFrom': instance.countryCodeFrom,
      'creareDate': instance.creareDate,
      'createDate': instance.createDate?.toIso8601String(),
      'description': instance.description,
      'dob': instance.dob,
      'dobDays': instance.dobDays,
      'dobMonth': instance.dobMonth,
      'dobYear': instance.dobYear,
      'totalLessons': instance.totalLessons,
      'email': instance.email,
      'firstName': instance.firstName,
      'gender': instance.gender,
      'profileLanguage': instance.profileLanguage,
      'isApproved': instance.isApproved,
      'isCertificate': instance.isCertificate,
      'isCompleted': instance.isCompleted,
      'isVideoSystemHosted': instance.isVideoSystemHosted,
      'lastName': instance.lastName,
      'maxRatePerHour': instance.maxRatePerHour,
      'minRatePerHour': instance.minRatePerHour,
      'modifyDate': instance.modifyDate,
      'offeringTrial': instance.offeringTrial,
      'phone': instance.phone,
      'postalCode': instance.postalCode,
      'profileImage': instance.profileImage,
      'profileImagePath': instance.profileImagePath,
      'rating': instance.rating,
      'rawImageData': instance.rawImageData,
      'registrationId': instance.registrationId,
      'shortIntroduction': instance.shortIntroduction,
      'languageIso': instance.languageIso,
      'languageIsoName': instance.languageIsoName,
      'status': instance.status,
      'teachingStatus': instance.teachingStatus,
      'teacherProfileId': instance.teacherProfileId,
      'teachersubjectIds': instance.teachersubjectIds,
      'teacherSubjects': instance.teacherSubjects,
      'teacherType': instance.teacherType,
      'teacherTypeName': instance.teacherTypeName,
      'teacherUniqueName': instance.teacherUniqueName,
      'thumbImage': instance.thumbImage,
      'tileImage': instance.tileImage,
      'timeSetup': instance.timeSetup,
      'trialPrice': instance.trialPrice,
      'price': instance.price,
      'price1': instance.price1,
      'price5': instance.price5,
      'price10': instance.price10,
      'videoUrl': instance.videoUrl,
      'teacherUrl': instance.teacherUrl,
      'unsubscribe': instance.unsubscribe,
      'timezoneInfo': instance.timezoneInfo,
      'timezoneInfoGmt': instance.timezoneInfoGmt,
      'timezoneInfoForce': instance.timezoneInfoForce,
      'unsubscribeAll': instance.unsubscribeAll,
      'responseResult': instance.responseResult,
      'lastActive': instance.lastActive?.toIso8601String(),
      'lastOnline': instance.lastOnline?.toIso8601String(),
    };

ProfileLanguage _$ProfileLanguageFromJson(Map<String, dynamic> json) {
  return ProfileLanguage(
    profileLanguageId: json['profileLanguageId'] as int,
    languageName: json['languageName'],
    languageIso: json['languageIso'] as String,
    languageId: json['languageId'] as int,
    levelName: json['levelName'],
    levelId: json['levelId'] as int,
    createDate: json['createDate'] == null
        ? null
        : DateTime.parse(json['createDate'] as String),
  );
}

Map<String, dynamic> _$ProfileLanguageToJson(ProfileLanguage instance) =>
    <String, dynamic>{
      'profileLanguageId': instance.profileLanguageId,
      'languageName': instance.languageName,
      'languageIso': instance.languageIso,
      'languageId': instance.languageId,
      'levelName': instance.levelName,
      'levelId': instance.levelId,
      'createDate': instance.createDate?.toIso8601String(),
    };
