// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_lesson_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiveLesson _$LiveLessonFromJson(Map<String, dynamic> json) {
  return LiveLesson(
    success: json['success'] as bool,
    message: json['message'] as String,
    result: json['result'] == null
        ? null
        : LiveLessonResult.fromJson(json['result'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LiveLessonToJson(LiveLesson instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'result': instance.result,
    };

LiveLessonResult _$LiveLessonResultFromJson(Map<String, dynamic> json) {
  return LiveLessonResult(
    sessionLiveId: json['sessionLiveId'] as int,
    studentId: json['studentId'] as int,
    studentName: json['studentName'] as String,
    meetingUrl: json['meetingUrl'] as String,
    createDate: json['createDate'] == null
        ? null
        : DateTime.parse(json['createDate'] as String),
  );
}

Map<String, dynamic> _$LiveLessonResultToJson(LiveLessonResult instance) =>
    <String, dynamic>{
      'sessionLiveId': instance.sessionLiveId,
      'studentId': instance.studentId,
      'studentName': instance.studentName,
      'meetingUrl': instance.meetingUrl,
      'createDate': instance.createDate?.toIso8601String(),
    };
