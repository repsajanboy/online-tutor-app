// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lessons_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lessons _$LessonsFromJson(Map<String, dynamic> json) {
  return Lessons(
    sessionlist: (json['sessionlist'] as List)
        ?.map((e) =>
            e == null ? null : Sessionlist.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$LessonsToJson(Lessons instance) => <String, dynamic>{
      'sessionlist': instance.sessionlist,
    };

Sessionlist _$SessionlistFromJson(Map<String, dynamic> json) {
  return Sessionlist(
    childClass: json['childClass'] as String,
    childId: json['childId'] as int,
    childName: json['childName'] as String,
    classDescription: json['classDescription'] as String,
    classImage: json['classImage'] as String,
    classImagePath: json['classImagePath'],
    classImageThumb: json['classImageThumb'],
    classImageTile: json['classImageTile'],
    classTitle: json['classTitle'] as String,
    createDate: json['createDate'] == null
        ? null
        : DateTime.parse(json['createDate'] as String),
    endDate: json['endDate'] == null
        ? null
        : DateTime.parse(json['endDate'] as String),
    hasStudentGivenFeedback: json['hasStudentGivenFeedback'] as bool,
    hasTeacherGivenFeedback: json['hasTeacherGivenFeedback'] as bool,
    isProblematic: json['isProblematic'] as bool,
    isStudentJoin: json['isStudentJoin'] as bool,
    isTeacherJoin: json['isTeacherJoin'] as bool,
    isTrial: json['isTrial'] as bool,
    modifyDate: json['modifyDate'] == null
        ? null
        : DateTime.parse(json['modifyDate'] as String),
    orderId: json['orderId'] as int,
    problemId: json['problemId'] as int,
    problemMessage: json['problemMessage'] as String,
    refundId: json['refundId'] as int,
    roomId: json['roomId'] as int,
    sessionId: json['sessionId'] as int,
    studentUrl: json['studentUrl'] as String,
    sessionNumber: json['sessionNumber'] as int,
    sessionType: json['sessionType'] as int,
    sessionUrl: json['sessionUrl'] as String,
    meetingRoomUrl: json['meetingRoomUrl'],
    slotDuration: json['slotDuration'] as int,
    solutionId: json['solutionId'] as int,
    solutionMessage: json['solutionMessage'] as String,
    startTime: json['startTime'] == null
        ? null
        : DateTime.parse(json['startTime'] as String),
    startUrl: json['startUrl'] as String,
    status: json['status'] as int,
    studentClass: json['studentClass'] as String,
    studentEmail: json['studentEmail'] as String,
    studentGoogleId: json['studentGoogleId'] as String,
    studentId: json['studentId'] as int,
    studentLink: json['studentLink'] as String,
    studentImage: json['studentImage'] as String,
    studentImagePath: json['studentImagePath'] as String,
    studentName: json['studentName'] as String,
    studentThumbImage: json['studentThumbImage'],
    studentTileImage: json['studentTileImage'],
    studentType: json['studentType'] as int,
    subjectId: json['subjectId'] as int,
    subjectName: json['subjectName'] as String,
    teacherEmail: json['teacherEmail'] as String,
    teacherGoogleId: json['teacherGoogleId'] as String,
    teacherId: json['teacherId'] as int,
    teacherImage: json['teacherImage'] as String,
    teacherImagePath: json['teacherImagePath'] as String,
    teacherLink: json['teacherLink'] as String,
    teacherName: json['teacherName'] as String,
    teacherPhone: json['teacherPhone'] as String,
    studentPhone: json['studentPhone'],
    teacherThumbImage: json['teacherThumbImage'] as String,
    teacherTileImage: json['teacherTileImage'] as String,
    teacherUniqueName: json['teacherUniqueName'] as String,
    teacherUrl: json['teacherUrl'] as String,
    isconfirmTime: json['isconfirmTime'] as int,
    price: json['price'] as int,
    discountPrice: json['discountPrice'] as int,
    cashoutAmount: json['cashoutAmount'] as int,
    hasStudentJoin: json['hasStudentJoin'] as bool,
    hasTeacherJoin: json['hasTeacherJoin'] as bool,
    hasStudentJoinDate: json['hasStudentJoinDate'] == null
        ? null
        : DateTime.parse(json['hasStudentJoinDate'] as String),
    hasTeacherJoinDate: json['hasTeacherJoinDate'] == null
        ? null
        : DateTime.parse(json['hasTeacherJoinDate'] as String),
    responseResult: json['responseResult'] as int,
    studentTimeZone: json['studentTimeZone'] as String,
    tutorTimeZone: json['tutorTimeZone'] as String,
    isSubscriptionTrial: json['isSubscriptionTrial'] as bool,
    subscriptionLessons: json['subscriptionLessons'] as int,
    subscriptionStatus: json['subscriptionStatus'] as int,
    tokBoxSessionId: json['tokBoxSessionId'],
    trialWithoutCard: json['trialWithoutCard'] as int,
  );
}

Map<String, dynamic> _$SessionlistToJson(Sessionlist instance) =>
    <String, dynamic>{
      'childClass': instance.childClass,
      'childId': instance.childId,
      'childName': instance.childName,
      'classDescription': instance.classDescription,
      'classImage': instance.classImage,
      'classImagePath': instance.classImagePath,
      'classImageThumb': instance.classImageThumb,
      'classImageTile': instance.classImageTile,
      'classTitle': instance.classTitle,
      'createDate': instance.createDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'hasStudentGivenFeedback': instance.hasStudentGivenFeedback,
      'hasTeacherGivenFeedback': instance.hasTeacherGivenFeedback,
      'isProblematic': instance.isProblematic,
      'isStudentJoin': instance.isStudentJoin,
      'isTeacherJoin': instance.isTeacherJoin,
      'isTrial': instance.isTrial,
      'modifyDate': instance.modifyDate?.toIso8601String(),
      'orderId': instance.orderId,
      'problemId': instance.problemId,
      'problemMessage': instance.problemMessage,
      'refundId': instance.refundId,
      'roomId': instance.roomId,
      'sessionId': instance.sessionId,
      'studentUrl': instance.studentUrl,
      'sessionNumber': instance.sessionNumber,
      'sessionType': instance.sessionType,
      'sessionUrl': instance.sessionUrl,
      'meetingRoomUrl': instance.meetingRoomUrl,
      'slotDuration': instance.slotDuration,
      'solutionId': instance.solutionId,
      'solutionMessage': instance.solutionMessage,
      'startTime': instance.startTime?.toIso8601String(),
      'startUrl': instance.startUrl,
      'status': instance.status,
      'studentClass': instance.studentClass,
      'studentEmail': instance.studentEmail,
      'studentGoogleId': instance.studentGoogleId,
      'studentId': instance.studentId,
      'studentLink': instance.studentLink,
      'studentImage': instance.studentImage,
      'studentImagePath': instance.studentImagePath,
      'studentName': instance.studentName,
      'studentThumbImage': instance.studentThumbImage,
      'studentTileImage': instance.studentTileImage,
      'studentType': instance.studentType,
      'subjectId': instance.subjectId,
      'subjectName': instance.subjectName,
      'teacherEmail': instance.teacherEmail,
      'teacherGoogleId': instance.teacherGoogleId,
      'teacherId': instance.teacherId,
      'teacherImage': instance.teacherImage,
      'teacherImagePath': instance.teacherImagePath,
      'teacherLink': instance.teacherLink,
      'teacherName': instance.teacherName,
      'teacherPhone': instance.teacherPhone,
      'studentPhone': instance.studentPhone,
      'teacherThumbImage': instance.teacherThumbImage,
      'teacherTileImage': instance.teacherTileImage,
      'teacherUniqueName': instance.teacherUniqueName,
      'teacherUrl': instance.teacherUrl,
      'isconfirmTime': instance.isconfirmTime,
      'price': instance.price,
      'discountPrice': instance.discountPrice,
      'cashoutAmount': instance.cashoutAmount,
      'hasStudentJoin': instance.hasStudentJoin,
      'hasTeacherJoin': instance.hasTeacherJoin,
      'hasStudentJoinDate': instance.hasStudentJoinDate?.toIso8601String(),
      'hasTeacherJoinDate': instance.hasTeacherJoinDate?.toIso8601String(),
      'responseResult': instance.responseResult,
      'studentTimeZone': instance.studentTimeZone,
      'tutorTimeZone': instance.tutorTimeZone,
      'isSubscriptionTrial': instance.isSubscriptionTrial,
      'subscriptionLessons': instance.subscriptionLessons,
      'subscriptionStatus': instance.subscriptionStatus,
      'tokBoxSessionId': instance.tokBoxSessionId,
      'trialWithoutCard': instance.trialWithoutCard,
    };
