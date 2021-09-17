// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_student_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersStudentProfile _$UsersStudentProfileFromJson(Map<String, dynamic> json) {
  return UsersStudentProfile(
    student: json['student'] == null
        ? null
        : Student.fromJson(json['student'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UsersStudentProfileToJson(
        UsersStudentProfile instance) =>
    <String, dynamic>{
      'student': instance.student,
    };

Student _$StudentFromJson(Map<String, dynamic> json) {
  return Student(
    address: json['address'] as String,
    city: json['city'] as String,
    classId: json['classId'] as int,
    className: json['className'] as String,
    country: json['country'] as String,
    createDate: json['createDate'] as String,
    createDateOffset: json['createDateOffset'] == null
        ? null
        : DateTime.parse(json['createDateOffset'] as String),
    email: json['email'] as String,
    firstName: json['firstName'] as String,
    gender: json['gender'] as String,
    lastName: json['lastName'] as String,
    modifyDate: json['modifyDate'] as String,
    phone: json['phone'] as String,
    profileImage: json['profileImage'] as String,
    profileImagePath: json['profileImagePath'],
    postalCode: json['postalCode'] as String,
    rawImageData: json['rawImageData'],
    rawImageFile: json['rawImageFile'],
    registrationId: json['registrationId'] as String,
    lastActive: json['lastActive'] == null
        ? null
        : DateTime.parse(json['lastActive'] as String),
    stats: json['stats'],
    studentClasses: (json['studentClasses'] as List)
        ?.map((e) =>
            e == null ? null : StudentClass.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    profileLanguage: json['profileLanguage'],
    studentProfileId: json['studentProfileId'] as String,
    studentSubjects: (json['studentSubjects'] as List)
        ?.map((e) => e == null
            ? null
            : StudentSubject.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    subjectIds: json['subjectIds'] as String,
    thumbImage: json['thumbImage'],
    tileImage: json['tileImage'],
    unsubscribeAll: json['unsubscribeAll'] as int,
    url: json['url'],
    lastOnline: json['lastOnline'] == null
        ? null
        : DateTime.parse(json['lastOnline'] as String),
    timezoneInfo: json['timezoneInfo'] as String,
    timezoneInfoGmt: json['timezoneInfoGmt'] as String,
    timezoneInfoForce: json['timezoneInfoForce'] as int,
  );
}

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      'address': instance.address,
      'city': instance.city,
      'classId': instance.classId,
      'className': instance.className,
      'country': instance.country,
      'createDate': instance.createDate,
      'createDateOffset': instance.createDateOffset?.toIso8601String(),
      'email': instance.email,
      'firstName': instance.firstName,
      'gender': instance.gender,
      'lastName': instance.lastName,
      'modifyDate': instance.modifyDate,
      'phone': instance.phone,
      'profileImage': instance.profileImage,
      'profileImagePath': instance.profileImagePath,
      'postalCode': instance.postalCode,
      'rawImageData': instance.rawImageData,
      'rawImageFile': instance.rawImageFile,
      'registrationId': instance.registrationId,
      'lastActive': instance.lastActive?.toIso8601String(),
      'stats': instance.stats,
      'studentClasses': instance.studentClasses,
      'profileLanguage': instance.profileLanguage,
      'studentProfileId': instance.studentProfileId,
      'studentSubjects': instance.studentSubjects,
      'subjectIds': instance.subjectIds,
      'thumbImage': instance.thumbImage,
      'tileImage': instance.tileImage,
      'unsubscribeAll': instance.unsubscribeAll,
      'url': instance.url,
      'lastOnline': instance.lastOnline?.toIso8601String(),
      'timezoneInfo': instance.timezoneInfo,
      'timezoneInfoGmt': instance.timezoneInfoGmt,
      'timezoneInfoForce': instance.timezoneInfoForce,
    };

StudentClass _$StudentClassFromJson(Map<String, dynamic> json) {
  return StudentClass(
    checked: json['checked'] as bool,
    classDescription: json['classDescription'] as String,
    classId: json['classId'] as int,
    className: json['className'] as String,
    order: json['order'] as int,
  );
}

Map<String, dynamic> _$StudentClassToJson(StudentClass instance) =>
    <String, dynamic>{
      'checked': instance.checked,
      'classDescription': instance.classDescription,
      'classId': instance.classId,
      'className': instance.className,
      'order': instance.order,
    };

StudentSubject _$StudentSubjectFromJson(Map<String, dynamic> json) {
  return StudentSubject(
    checked: json['checked'] as bool,
    subjectDescription: json['subjectDescription'] as String,
    subjectId: json['subjectId'] as int,
    subjectName: json['subjectName'] as String,
  );
}

Map<String, dynamic> _$StudentSubjectToJson(StudentSubject instance) =>
    <String, dynamic>{
      'checked': instance.checked,
      'subjectDescription': instance.subjectDescription,
      'subjectId': instance.subjectId,
      'subjectName': instance.subjectName,
    };
