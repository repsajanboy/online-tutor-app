// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_with_tutors_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LanguageWithTutors _$LanguageWithTutorsFromJson(Map<String, dynamic> json) {
  return LanguageWithTutors(
    language: json['language'] as String,
    tutors: (json['tutors'] as List)
        ?.map(
            (e) => e == null ? null : Tutor.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$LanguageWithTutorsToJson(LanguageWithTutors instance) =>
    <String, dynamic>{
      'language': instance.language,
      'tutors': instance.tutors,
    };

Tutor _$TutorFromJson(Map<String, dynamic> json) {
  return Tutor(
    profile: json['profile'] == null
        ? null
        : Profile.fromJson(json['profile'] as Map<String, dynamic>),
    countryFrom: json['countryFrom'] as String,
  );
}

Map<String, dynamic> _$TutorToJson(Tutor instance) => <String, dynamic>{
      'profile': instance.profile,
      'countryFrom': instance.countryFrom,
    };

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile(
    age: json['age'] as int,
    cityOptions: json['cityOptions'],
    approvalStatus: json['approvalStatus'] as int,
    availableTrial: json['availableTrial'] as bool,
    averageGrade: json['averageGrade'] as int,
    canTakeClass: json['canTakeClass'] as bool,
    country: json['country'] as String,
    countryCode: json['countryCode'] as String,
    countryCodeFrom: json['countryCodeFrom'] as String,
    discountProcent: (json['discountProcent'] as num)?.toDouble(),
    emailId: json['emailId'],
    imageRelativePath: json['imageRelativePath'] as String,
    index: json['index'] as int,
    isActive: json['isActive'] as bool,
    isFavourite: json['isFavourite'] as bool,
    maxRatePerHour: (json['maxRatePerHour'] as num)?.toDouble(),
    maxRatePerHourCurrency: json['maxRatePerHourCurrency'] as String,
    minRatePerHour: (json['minRatePerHour'] as num)?.toDouble(),
    minRatePerHourCurrency: json['minRatePerHourCurrency'] as String,
    name: json['name'] as String,
    modifyDate: json['modifyDate'] == null
        ? null
        : DateTime.parse(json['modifyDate'] as String),
    lastOnline: json['lastOnline'] == null
        ? null
        : DateTime.parse(json['lastOnline'] as String),
    profileIamgeThumb: json['profileIamgeThumb'] as String,
    profileImage: json['profileImage'] as String,
    profileImageTile: json['profileImageTile'] as String,
    rating: json['rating'] as int,
    ratingAverage: (json['ratingAverage'] as num)?.toDouble(),
    ratingAverageLessons: json['ratingAverageLessons'] as int,
    ratingProcent: json['ratingProcent'] as int,
    ratingString: json['ratingString'],
    registrationId: json['registrationId'] as int,
    totalCompletedSessions: json['totalCompletedSessions'] as int,
    totalCompletedSessionsSinceMarch:
        json['totalCompletedSessionsSinceMarch'] as int,
    shortIntroduction: json['shortIntroduction'] as String,
    subjectIds: json['subjectIds'] as String,
    subjectNames: json['subjectNames'] as String,
    languageIso: json['languageIso'] as String,
    languageIsoName: json['languageIsoName'] as String,
    teacherType: json['teacherType'] as String,
    teacherTypeFull: json['teacherTypeFull'] as String,
    teacherUniqueName: json['teacherUniqueName'],
    totalReviews: json['totalReviews'] as int,
    totalSessions: json['totalSessions'] as int,
    notFoundLanguage: json['notFoundLanguage'] as bool,
    notFoundCountry: json['notFoundCountry'] as bool,
    trialPrice: (json['trialPrice'] as num)?.toDouble(),
    trialPriceCurrency: json['trialPriceCurrency'] as String,
    commonPrice: (json['commonPrice'] as num)?.toDouble(),
    commonPriceCurrency: json['commonPriceCurrency'] as String,
    price1: (json['price1'] as num)?.toDouble(),
    price1Currency: json['price1Currency'],
    price5: (json['price5'] as num)?.toDouble(),
    price5Currency: json['price5Currency'],
    price10: (json['price10'] as num)?.toDouble(),
    price10Currency: json['price10Currency'],
    userName: json['userName'],
    teacherUrl: json['teacherUrl'] as String,
    videoUrl: json['videoUrl'] as String,
    lastActive: json['lastActive'] == null
        ? null
        : DateTime.parse(json['lastActive'] as String),
    staffReviewed: json['staffReviewed'] as bool,
    isApproved: json['isApproved'] as bool,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    description: json['description'] as String,
    teacherProfileId: json['teacherProfileId'],
    teacherTypeName: json['teacherTypeName'],
    status: json['status'] as int,
    createDate: json['createDate'] == null
        ? null
        : DateTime.parse(json['createDate'] as String),
    createDateRank: json['createDateRank'] == null
        ? null
        : DateTime.parse(json['createDateRank'] as String),
    offeringTrial: json['offeringTrial'] as bool,
    phone: json['phone'],
    skills: json['skills'] as String,
    totalStudents: json['totalStudents'] as int,
    teacherCv: (json['teacherCv'] as List)
        ?.map((e) =>
            e == null ? null : TeacherCv.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    profileLanguageList: (json['profileLanguageList'] as List)
        ?.map((e) => e == null
            ? null
            : ProfileLanguageList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    teacherReviewList: json['teacherReviewList'] == null
        ? null
        : TeacherReviewList.fromJson(
            json['teacherReviewList'] as Map<String, dynamic>),
    slotWeek: (json['slotWeek'] as List)
        ?.map((e) =>
            e == null ? null : SlotWeek.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    totalResults: json['totalResults'] as int,
    userId: json['userId'] as int,
    subscriptionLessons: json['subscriptionLessons'] as int,
    subscriptionStatus: json['subscriptionStatus'] as int,
    teachCategory: json['teachCategory'] as String,
    teachCategoryArray:
        (json['teachCategoryArray'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'age': instance.age,
      'cityOptions': instance.cityOptions,
      'approvalStatus': instance.approvalStatus,
      'availableTrial': instance.availableTrial,
      'averageGrade': instance.averageGrade,
      'canTakeClass': instance.canTakeClass,
      'country': instance.country,
      'countryCode': instance.countryCode,
      'countryCodeFrom': instance.countryCodeFrom,
      'discountProcent': instance.discountProcent,
      'emailId': instance.emailId,
      'imageRelativePath': instance.imageRelativePath,
      'index': instance.index,
      'isActive': instance.isActive,
      'isFavourite': instance.isFavourite,
      'maxRatePerHour': instance.maxRatePerHour,
      'maxRatePerHourCurrency': instance.maxRatePerHourCurrency,
      'minRatePerHour': instance.minRatePerHour,
      'minRatePerHourCurrency': instance.minRatePerHourCurrency,
      'name': instance.name,
      'modifyDate': instance.modifyDate?.toIso8601String(),
      'lastOnline': instance.lastOnline?.toIso8601String(),
      'profileIamgeThumb': instance.profileIamgeThumb,
      'profileImage': instance.profileImage,
      'profileImageTile': instance.profileImageTile,
      'rating': instance.rating,
      'ratingAverage': instance.ratingAverage,
      'ratingAverageLessons': instance.ratingAverageLessons,
      'ratingProcent': instance.ratingProcent,
      'ratingString': instance.ratingString,
      'registrationId': instance.registrationId,
      'totalCompletedSessions': instance.totalCompletedSessions,
      'totalCompletedSessionsSinceMarch':
          instance.totalCompletedSessionsSinceMarch,
      'shortIntroduction': instance.shortIntroduction,
      'subjectIds': instance.subjectIds,
      'subjectNames': instance.subjectNames,
      'languageIso': instance.languageIso,
      'languageIsoName': instance.languageIsoName,
      'teacherType': instance.teacherType,
      'teacherTypeFull': instance.teacherTypeFull,
      'teacherUniqueName': instance.teacherUniqueName,
      'totalReviews': instance.totalReviews,
      'totalSessions': instance.totalSessions,
      'notFoundLanguage': instance.notFoundLanguage,
      'notFoundCountry': instance.notFoundCountry,
      'trialPrice': instance.trialPrice,
      'trialPriceCurrency': instance.trialPriceCurrency,
      'commonPrice': instance.commonPrice,
      'commonPriceCurrency': instance.commonPriceCurrency,
      'price1': instance.price1,
      'price1Currency': instance.price1Currency,
      'price5': instance.price5,
      'price5Currency': instance.price5Currency,
      'price10': instance.price10,
      'price10Currency': instance.price10Currency,
      'userName': instance.userName,
      'teacherUrl': instance.teacherUrl,
      'videoUrl': instance.videoUrl,
      'lastActive': instance.lastActive?.toIso8601String(),
      'staffReviewed': instance.staffReviewed,
      'isApproved': instance.isApproved,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'description': instance.description,
      'teacherProfileId': instance.teacherProfileId,
      'teacherTypeName': instance.teacherTypeName,
      'status': instance.status,
      'createDate': instance.createDate?.toIso8601String(),
      'createDateRank': instance.createDateRank?.toIso8601String(),
      'offeringTrial': instance.offeringTrial,
      'phone': instance.phone,
      'skills': instance.skills,
      'totalStudents': instance.totalStudents,
      'teacherCv': instance.teacherCv,
      'profileLanguageList': instance.profileLanguageList,
      'teacherReviewList': instance.teacherReviewList,
      'slotWeek': instance.slotWeek,
      'totalResults': instance.totalResults,
      'userId': instance.userId,
      'subscriptionLessons': instance.subscriptionLessons,
      'subscriptionStatus': instance.subscriptionStatus,
      'teachCategory': instance.teachCategory,
      'teachCategoryArray': instance.teachCategoryArray,
    };

ProfileLanguageList _$ProfileLanguageListFromJson(Map<String, dynamic> json) {
  return ProfileLanguageList(
    profileLanguageId: json['profileLanguageId'] as int,
    languageName: json['languageName'] as String,
    languageIso: json['languageIso'] as String,
    languageId: json['languageId'] as int,
    levelName: json['levelName'] as String,
    levelId: json['levelId'] as int,
    createDate: json['createDate'] == null
        ? null
        : DateTime.parse(json['createDate'] as String),
  );
}

Map<String, dynamic> _$ProfileLanguageListToJson(
        ProfileLanguageList instance) =>
    <String, dynamic>{
      'profileLanguageId': instance.profileLanguageId,
      'languageName': instance.languageName,
      'languageIso': instance.languageIso,
      'languageId': instance.languageId,
      'levelName': instance.levelName,
      'levelId': instance.levelId,
      'createDate': instance.createDate?.toIso8601String(),
    };

SlotWeek _$SlotWeekFromJson(Map<String, dynamic> json) {
  return SlotWeek(
    isAvailable: json['isAvailable'] as int,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    teacherId: json['teacherId'],
    dayCode: json['dayCode'] as String,
  );
}

Map<String, dynamic> _$SlotWeekToJson(SlotWeek instance) => <String, dynamic>{
      'isAvailable': instance.isAvailable,
      'date': instance.date?.toIso8601String(),
      'teacherId': instance.teacherId,
      'dayCode': instance.dayCode,
    };

TeacherCv _$TeacherCvFromJson(Map<String, dynamic> json) {
  return TeacherCv(
    registrationId: json['registrationId'] as int,
    cvId: json['cvId'] as int,
    title: json['title'] as String,
    type: json['type'] as String,
    place: json['place'] as String,
    description: json['description'] as String,
    category: json['category'] as int,
    startYear: json['startYear'] as String,
    endYear: json['endYear'] as String,
  );
}

Map<String, dynamic> _$TeacherCvToJson(TeacherCv instance) => <String, dynamic>{
      'registrationId': instance.registrationId,
      'cvId': instance.cvId,
      'title': instance.title,
      'type': instance.type,
      'place': instance.place,
      'description': instance.description,
      'category': instance.category,
      'startYear': instance.startYear,
      'endYear': instance.endYear,
    };

TeacherReviewList _$TeacherReviewListFromJson(Map<String, dynamic> json) {
  return TeacherReviewList(
    reviews: (json['reviews'] as List)
        ?.map((e) =>
            e == null ? null : Review.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TeacherReviewListToJson(TeacherReviewList instance) =>
    <String, dynamic>{
      'reviews': instance.reviews,
    };

Review _$ReviewFromJson(Map<String, dynamic> json) {
  return Review(
    childName: json['childName'] as String,
    endDate: json['endDate'] == null
        ? null
        : DateTime.parse(json['endDate'] as String),
    endDateTime: json['endDateTime'] as String,
    feedbackById: json['feedbackById'] as int,
    feedbackByType: json['feedbackByType'] as String,
    feedbackText: json['feedbackText'] as String,
    imageRelativePath: json['imageRelativePath'],
    profileIamgeThumb: json['profileIamgeThumb'],
    profileImage: json['profileImage'] as String,
    profileImageTile: json['profileImageTile'],
    rating: json['rating'] as String,
    ratingSkills: json['ratingSkills'] as String,
    ratingQuality: json['ratingQuality'] as String,
    ratingMaterials: json['ratingMaterials'] as String,
    ratingPunctuality: json['ratingPunctuality'] as String,
    ratingCommunication: json['ratingCommunication'] as String,
    ratingRecommend: json['ratingRecommend'] as String,
    sessionId: json['sessionId'] as int,
    sessionType: json['sessionType'] as String,
    slotDuration: json['slotDuration'] as String,
    startDate: json['startDate'] == null
        ? null
        : DateTime.parse(json['startDate'] as String),
    startDateTime: json['startDateTime'] as String,
    status: json['status'] as String,
    studentId: json['studentId'] as int,
    studentName: json['studentName'] as String,
    subjectId: json['subjectId'] as int,
    subjectName: json['subjectName'] as String,
    teacherId: json['teacherId'] as int,
    teacherName: json['teacherName'] as String,
  );
}

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'childName': instance.childName,
      'endDate': instance.endDate?.toIso8601String(),
      'endDateTime': instance.endDateTime,
      'feedbackById': instance.feedbackById,
      'feedbackByType': instance.feedbackByType,
      'feedbackText': instance.feedbackText,
      'imageRelativePath': instance.imageRelativePath,
      'profileIamgeThumb': instance.profileIamgeThumb,
      'profileImage': instance.profileImage,
      'profileImageTile': instance.profileImageTile,
      'rating': instance.rating,
      'ratingSkills': instance.ratingSkills,
      'ratingQuality': instance.ratingQuality,
      'ratingMaterials': instance.ratingMaterials,
      'ratingPunctuality': instance.ratingPunctuality,
      'ratingCommunication': instance.ratingCommunication,
      'ratingRecommend': instance.ratingRecommend,
      'sessionId': instance.sessionId,
      'sessionType': instance.sessionType,
      'slotDuration': instance.slotDuration,
      'startDate': instance.startDate?.toIso8601String(),
      'startDateTime': instance.startDateTime,
      'status': instance.status,
      'studentId': instance.studentId,
      'studentName': instance.studentName,
      'subjectId': instance.subjectId,
      'subjectName': instance.subjectName,
      'teacherId': instance.teacherId,
      'teacherName': instance.teacherName,
    };
