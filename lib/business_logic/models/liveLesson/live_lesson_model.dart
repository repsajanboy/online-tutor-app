import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'live_lesson_model.g.dart';

LiveLesson liveLessonFromJson(String str) => LiveLesson.fromJson(json.decode(str));

String liveLessonToJson(LiveLesson data) => json.encode(data.toJson());

@JsonSerializable()
class LiveLesson {
    LiveLesson({
        this.success,
        this.message,
        this.result,
    });
    @JsonKey(nullable: true)
    bool success;
    @JsonKey(nullable: true)
    String message;
    @JsonKey(nullable: true)
    LiveLessonResult result;
    factory LiveLesson.fromJson(Map<String, dynamic> json) => _$LiveLessonFromJson(json);

    Map<String, dynamic> toJson() => _$LiveLessonToJson(this);

}

@JsonSerializable()
class LiveLessonResult {
    LiveLessonResult({
        this.sessionLiveId,
        this.studentId,
        this.studentName,
        this.meetingUrl,
        this.createDate,
    });
    @JsonKey(nullable: true)
    int sessionLiveId;
    @JsonKey(nullable: true)
    int studentId;
    @JsonKey(nullable: true)
    String studentName;
    @JsonKey(nullable: true)
    String meetingUrl;
    @JsonKey(nullable: true)
    DateTime createDate;

    factory LiveLessonResult.fromJson(Map<String, dynamic> json) => _$LiveLessonResultFromJson(json);

    Map<String, dynamic> toJson() => _$LiveLessonResultToJson(this);
}
