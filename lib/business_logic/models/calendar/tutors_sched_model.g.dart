// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutors_sched_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TutorsSched _$TutorsSchedFromJson(Map<String, dynamic> json) {
  return TutorsSched(
    success: json['success'] as bool,
    data: json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TutorsSchedToJson(TutorsSched instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    end: json['end'] == null ? null : DateTime.parse(json['end'] as String),
    isForClasses: json['isForClasses'] as bool,
    isSelecatble: json['isSelecatble'] as bool,
    slotDuration: json['slotDuration'] as int,
    slotList: json['slotList'] as List,
    start:
        json['start'] == null ? null : DateTime.parse(json['start'] as String),
    teacherId: json['teacherId'] as String,
    zone: json['zone'] as String,
    teacherUrl: json['teacherUrl'] as String,
    slotList0: (json['slotList0'] as List)
        ?.map((e) =>
            e == null ? null : SlotList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    slotList1: (json['slotList1'] as List)
        ?.map((e) =>
            e == null ? null : SlotList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    slotList2: (json['slotList2'] as List)
        ?.map((e) =>
            e == null ? null : SlotList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    slotList3: (json['slotList3'] as List)
        ?.map((e) =>
            e == null ? null : SlotList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    slotList4: (json['slotList4'] as List)
        ?.map((e) =>
            e == null ? null : SlotList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    slotList5: (json['slotList5'] as List)
        ?.map((e) =>
            e == null ? null : SlotList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    slotList6: (json['slotList6'] as List)
        ?.map((e) =>
            e == null ? null : SlotList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    renderStartHours: json['renderStartHours'] == null
        ? null
        : DateTime.parse(json['renderStartHours'] as String),
    totalHoursCounter: json['totalHoursCounter'] as int,
    timeZone: json['timeZone'],
    timeZoneIana: json['timeZoneIana'] as String,
    show3Days: json['show3Days'] as bool,
    is15TimeZone: json['is15TimeZone'] as bool,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'end': instance.end?.toIso8601String(),
      'isForClasses': instance.isForClasses,
      'isSelecatble': instance.isSelecatble,
      'slotDuration': instance.slotDuration,
      'slotList': instance.slotList,
      'start': instance.start?.toIso8601String(),
      'teacherId': instance.teacherId,
      'zone': instance.zone,
      'teacherUrl': instance.teacherUrl,
      'slotList0': instance.slotList0,
      'slotList1': instance.slotList1,
      'slotList2': instance.slotList2,
      'slotList3': instance.slotList3,
      'slotList4': instance.slotList4,
      'slotList5': instance.slotList5,
      'slotList6': instance.slotList6,
      'renderStartHours': instance.renderStartHours?.toIso8601String(),
      'totalHoursCounter': instance.totalHoursCounter,
      'timeZone': instance.timeZone,
      'timeZoneIana': instance.timeZoneIana,
      'show3Days': instance.show3Days,
      'is15TimeZone': instance.is15TimeZone,
    };

SlotList _$SlotListFromJson(Map<String, dynamic> json) {
  return SlotList(
    duration: json['duration'] as int,
    end: json['end'] == null ? null : DateTime.parse(json['end'] as String),
    start:
        json['start'] == null ? null : DateTime.parse(json['start'] as String),
    status: json['status'] as int,
    teacherid: json['teacherid'] as String,
    isRemove: json['isRemove'] as bool,
    sqlStartTime: json['sqlStartTime'],
    sqlStartTimeAdd30Minutes: json['sqlStartTimeAdd30Minutes'],
    sqlDayCode: json['sqlDayCode'],
    sqlDayDate: json['sqlDayDate'],
    sqlDayDateFormat: json['sqlDayDateFormat'] == null
        ? null
        : DateTime.parse(json['sqlDayDateFormat'] as String),
    sqlTeacherZoneInfo: json['sqlTeacherZoneInfo'],
    sqlTeacherZoneInfoId: json['sqlTeacherZoneInfoId'],
    sqlTeacherUrl: json['sqlTeacherUrl'],
  );
}

Map<String, dynamic> _$SlotListToJson(SlotList instance) => <String, dynamic>{
      'duration': instance.duration,
      'end': instance.end?.toIso8601String(),
      'start': instance.start?.toIso8601String(),
      'status': instance.status,
      'teacherid': instance.teacherid,
      'isRemove': instance.isRemove,
      'sqlStartTime': instance.sqlStartTime,
      'sqlStartTimeAdd30Minutes': instance.sqlStartTimeAdd30Minutes,
      'sqlDayCode': instance.sqlDayCode,
      'sqlDayDate': instance.sqlDayDate,
      'sqlDayDateFormat': instance.sqlDayDateFormat?.toIso8601String(),
      'sqlTeacherZoneInfo': instance.sqlTeacherZoneInfo,
      'sqlTeacherZoneInfoId': instance.sqlTeacherZoneInfoId,
      'sqlTeacherUrl': instance.sqlTeacherUrl,
    };
