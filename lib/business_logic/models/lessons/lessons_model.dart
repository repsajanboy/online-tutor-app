import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'lessons_model.g.dart';

Lessons lessonsFromJson(String str) => Lessons.fromJson(json.decode(str));

String lessonsToJson(Lessons data) => json.encode(data.toJson());

@JsonSerializable()
class Lessons {
    Lessons({
        this.sessionlist,
    });

    @JsonKey(nullable: true)
    List<Sessionlist> sessionlist;

    factory Lessons.fromJson(Map<String, dynamic> json) => _$LessonsFromJson(json);
    
    Map<String, dynamic> toJson() => _$LessonsToJson(this);

}

Sessionlist sessionlistFromJson(String str) => Sessionlist.fromJson(json.decode(str));

String sessionlistToJson(Sessionlist data) => json.encode(data.toJson());

@JsonSerializable()
class Sessionlist {
    Sessionlist({
        this.childClass,
        this.childId,
        this.childName,
        this.classDescription,
        this.classImage,
        this.classImagePath,
        this.classImageThumb,
        this.classImageTile,
        this.classTitle,
        this.createDate,
        this.endDate,
        this.hasStudentGivenFeedback,
        this.hasTeacherGivenFeedback,
        this.isProblematic,
        this.isStudentJoin,
        this.isTeacherJoin,
        this.isTrial,
        this.modifyDate,
        this.orderId,
        this.problemId,
        this.problemMessage,
        this.refundId,
        this.roomId,
        this.sessionId,
        this.studentUrl,
        this.sessionNumber,
        this.sessionType,
        this.sessionUrl,
        this.meetingRoomUrl,
        this.slotDuration,
        this.solutionId,
        this.solutionMessage,
        this.startTime,
        this.startUrl,
        this.status,
        this.studentClass,
        this.studentEmail,
        this.studentGoogleId,
        this.studentId,
        this.studentLink,
        this.studentImage,
        this.studentImagePath,
        this.studentName,
        this.studentThumbImage,
        this.studentTileImage,
        this.studentType,
        this.subjectId,
        this.subjectName,
        this.teacherEmail,
        this.teacherGoogleId,
        this.teacherId,
        this.teacherImage,
        this.teacherImagePath,
        this.teacherLink,
        this.teacherName,
        this.teacherPhone,
        this.studentPhone,
        this.teacherThumbImage,
        this.teacherTileImage,
        this.teacherUniqueName,
        this.teacherUrl,
        this.isconfirmTime,
        this.price,
        this.discountPrice,
        this.cashoutAmount,
        this.hasStudentJoin,
        this.hasTeacherJoin,
        this.hasStudentJoinDate,
        this.hasTeacherJoinDate,
        this.responseResult,
        this.studentTimeZone,
        this.tutorTimeZone,
        this.isSubscriptionTrial,
        this.subscriptionLessons,
        this.subscriptionStatus,
        this.tokBoxSessionId,
        this.trialWithoutCard
    });

    @JsonKey(nullable: true)
    String childClass;
    @JsonKey(nullable: true)
    int childId;
    @JsonKey(nullable: true)
    String childName;
    @JsonKey(nullable: true)
    String classDescription;
    @JsonKey(nullable: true)
    String classImage;
    @JsonKey(nullable: true)
    dynamic classImagePath;
    @JsonKey(nullable: true)
    dynamic classImageThumb;
    @JsonKey(nullable: true)
    dynamic classImageTile;
    @JsonKey(nullable: true)
    String classTitle;
    @JsonKey(nullable: true)
    DateTime createDate;
    @JsonKey(nullable: true)
    DateTime endDate;
    @JsonKey(nullable: true)
    bool hasStudentGivenFeedback;
    @JsonKey(nullable: true)
    bool hasTeacherGivenFeedback;
    @JsonKey(nullable: true)
    bool isProblematic;
    @JsonKey(nullable: true)
    bool isStudentJoin;
    @JsonKey(nullable: true)
    bool isTeacherJoin;
    @JsonKey(nullable: true)
    bool isTrial;
    @JsonKey(nullable: true)
    DateTime modifyDate;
    @JsonKey(nullable: true)
    int orderId;
    @JsonKey(nullable: true)
    int problemId;
    @JsonKey(nullable: true)
    String problemMessage;
    @JsonKey(nullable: true)
    int refundId;
    @JsonKey(nullable: true)
    int roomId;
    @JsonKey(nullable: true)
    int sessionId;
    @JsonKey(nullable: true)
    String studentUrl;
    @JsonKey(nullable: true)
    int sessionNumber;
    @JsonKey(nullable: true)
    int sessionType;
    @JsonKey(nullable: true)
    String sessionUrl;
    @JsonKey(nullable: true)
    dynamic meetingRoomUrl;
    @JsonKey(nullable: true)
    int slotDuration;
    @JsonKey(nullable: true)
    int solutionId;
    @JsonKey(nullable: true)
    String solutionMessage;
    @JsonKey(nullable: true)
    DateTime startTime;
    @JsonKey(nullable: true)
    String startUrl;
    @JsonKey(nullable: true)
    int status;
    @JsonKey(nullable: true)
    String studentClass;
    @JsonKey(nullable: true)
    String studentEmail;
    @JsonKey(nullable: true)
    String studentGoogleId;
    @JsonKey(nullable: true)
    int studentId;
    @JsonKey(nullable: true)
    String studentLink;
    @JsonKey(nullable: true)
    String studentImage;
    @JsonKey(nullable: true)
    String studentImagePath;
    @JsonKey(nullable: true)
    String studentName;
    @JsonKey(nullable: true)
    dynamic studentThumbImage;
    @JsonKey(nullable: true)
    dynamic studentTileImage;
    @JsonKey(nullable: true)
    int studentType;
    @JsonKey(nullable: true)
    int subjectId;
    @JsonKey(nullable: true)
    String subjectName;
    @JsonKey(nullable: true)
    String teacherEmail;
    @JsonKey(nullable: true)
    String teacherGoogleId;
    @JsonKey(nullable: true)
    int teacherId;
    @JsonKey(nullable: true)
    String teacherImage;
    @JsonKey(nullable: true)
    String teacherImagePath;
    @JsonKey(nullable: true)
    String teacherLink;
    @JsonKey(nullable: true)
    String teacherName;
    @JsonKey(nullable: true)
    String teacherPhone;
    @JsonKey(nullable: true)
    dynamic studentPhone;
    @JsonKey(nullable: true)
    String teacherThumbImage;
    @JsonKey(nullable: true)
    String teacherTileImage;
    @JsonKey(nullable: true)
    String teacherUniqueName;
    @JsonKey(nullable: true)
    String teacherUrl;
    @JsonKey(nullable: true)
    int isconfirmTime;
    @JsonKey(nullable: true)
    int price;
    @JsonKey(nullable: true)
    int discountPrice;
    @JsonKey(nullable: true)
    int cashoutAmount;
    @JsonKey(nullable: true)
    bool hasStudentJoin;
    @JsonKey(nullable: true)
    bool hasTeacherJoin;
    @JsonKey(nullable: true)
    DateTime hasStudentJoinDate;
    @JsonKey(nullable: true)
    DateTime hasTeacherJoinDate;
    @JsonKey(nullable: true)
    int responseResult;
    @JsonKey(nullable: true)
    String studentTimeZone;
    @JsonKey(nullable: true)
    String tutorTimeZone;
    @JsonKey(nullable: true)
    bool isSubscriptionTrial;
    @JsonKey(nullable: true)
    int subscriptionLessons;
    @JsonKey(nullable: true)
    int subscriptionStatus;
    @JsonKey(nullable: true)
    dynamic tokBoxSessionId;
    int trialWithoutCard;

    factory Sessionlist.fromJson(Map<String, dynamic> json) => _$SessionlistFromJson(json);
    
    Map<String, dynamic> toJson() => _$SessionlistToJson(this);
    
}