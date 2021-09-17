import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'tutors_sched_model.g.dart';

TutorsSched tutorsSchedFromJson(String str) => TutorsSched.fromJson(json.decode(str));

String tutorsSchedToJson(TutorsSched data) => json.encode(data.toJson());

@JsonSerializable()
class TutorsSched {
    TutorsSched({
        this.success,
        this.data,
    });
    @JsonKey(nullable: true)
    bool success;
    @JsonKey(nullable: true)
    Data data;

    factory TutorsSched.fromJson(Map<String, dynamic> json) => _$TutorsSchedFromJson(json);

    Map<String, dynamic> toJson() => _$TutorsSchedToJson(this);
}

@JsonSerializable()
class Data {
    Data({
        this.end,
        this.isForClasses,
        this.isSelecatble,
        this.slotDuration,
        this.slotList,
        this.start,
        this.teacherId,
        this.zone,
        this.teacherUrl,
        this.slotList0,
        this.slotList1,
        this.slotList2,
        this.slotList3,
        this.slotList4,
        this.slotList5,
        this.slotList6,
        this.renderStartHours,
        this.totalHoursCounter,
        this.timeZone,
        this.timeZoneIana,
        this.show3Days,
        this.is15TimeZone,
    });
    @JsonKey(nullable: true)
    DateTime end;
    @JsonKey(nullable: true)
    bool isForClasses;
    @JsonKey(nullable: true)
    bool isSelecatble;
    @JsonKey(nullable: true)
    int slotDuration;
    @JsonKey(nullable: true)
    List<dynamic> slotList;
    @JsonKey(nullable: true)
    DateTime start;
    @JsonKey(nullable: true)
    String teacherId;
    @JsonKey(nullable: true)
    String zone;
    @JsonKey(nullable: true)
    String teacherUrl;
    @JsonKey(nullable: true)
    List<SlotList> slotList0;
    @JsonKey(nullable: true)
    List<SlotList> slotList1;
    @JsonKey(nullable: true)
    List<SlotList> slotList2;
    @JsonKey(nullable: true)
    List<SlotList> slotList3;
    @JsonKey(nullable: true)
    List<SlotList> slotList4;
    @JsonKey(nullable: true)
    List<SlotList> slotList5;
    @JsonKey(nullable: true)
    List<SlotList> slotList6;
    @JsonKey(nullable: true)
    DateTime renderStartHours;
    @JsonKey(nullable: true)
    int totalHoursCounter;
    @JsonKey(nullable: true)
    dynamic timeZone;
    @JsonKey(nullable: true)
    String timeZoneIana;
    @JsonKey(nullable: true)
    bool show3Days;
    @JsonKey(nullable: true)
    bool is15TimeZone;

    factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

    Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class SlotList {
    SlotList({
        this.duration,
        this.end,
        this.start,
        this.status,
        this.teacherid,
        this.isRemove,
        this.sqlStartTime,
        this.sqlStartTimeAdd30Minutes,
        this.sqlDayCode,
        this.sqlDayDate,
        this.sqlDayDateFormat,
        this.sqlTeacherZoneInfo,
        this.sqlTeacherZoneInfoId,
        this.sqlTeacherUrl,
    });
    @JsonKey(nullable: true)
    int duration;
    @JsonKey(nullable: true)
    DateTime end;
    @JsonKey(nullable: true)
    DateTime start;
    @JsonKey(nullable: true)
    int status;
    @JsonKey(nullable: true)
    String teacherid;
    @JsonKey(nullable: true)
    bool isRemove;
    @JsonKey(nullable: true)
    dynamic sqlStartTime;
    @JsonKey(nullable: true)
    dynamic sqlStartTimeAdd30Minutes;
    @JsonKey(nullable: true)
    dynamic sqlDayCode;
    @JsonKey(nullable: true)
    dynamic sqlDayDate;
    @JsonKey(nullable: true)
    DateTime sqlDayDateFormat;
    @JsonKey(nullable: true)
    dynamic sqlTeacherZoneInfo;
    @JsonKey(nullable: true)
    dynamic sqlTeacherZoneInfoId;
    @JsonKey(nullable: true)
    dynamic sqlTeacherUrl;

    factory SlotList.fromJson(Map<String, dynamic> json) => _$SlotListFromJson(json);

    Map<String, dynamic> toJson() => _$SlotListToJson(this);

}