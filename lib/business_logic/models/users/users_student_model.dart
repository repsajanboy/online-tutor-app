import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'users_student_model.g.dart';

UsersStudentProfile usersStudentProfileFromJson(String str) => UsersStudentProfile.fromJson(json.decode(str));

String usersStudentProfileToJson(UsersStudentProfile data) => json.encode(data.toJson());

@JsonSerializable()
class UsersStudentProfile {
    UsersStudentProfile({
        this.student,
    });
    @JsonKey(nullable: true)
    Student student;

    factory UsersStudentProfile.fromJson(Map<String, dynamic> json) => _$UsersStudentProfileFromJson(json);

    Map<String, dynamic> toJson() => _$UsersStudentProfileToJson(this);
}

@JsonSerializable()
class Student {
    Student({
        this.address,
        this.city,
        this.classId,
        this.className,
        this.country,
        this.createDate,
        this.createDateOffset,
        this.email,
        this.firstName,
        this.gender,
        this.lastName,
        this.modifyDate,
        this.phone,
        this.profileImage,
        this.profileImagePath,
        this.postalCode,
        this.rawImageData,
        this.rawImageFile,
        this.registrationId,
        this.lastActive,
        this.stats,
        this.studentClasses,
        this.profileLanguage,
        this.studentProfileId,
        this.studentSubjects,
        this.subjectIds,
        this.thumbImage,
        this.tileImage,
        this.unsubscribeAll,
        this.url,
        this.lastOnline,
        this.timezoneInfo,
        this.timezoneInfoGmt,
        this.timezoneInfoForce,
    });
    @JsonKey(nullable: true)
    String address;
    @JsonKey(nullable: true)
    @JsonKey(nullable: true)
    String city;
    @JsonKey(nullable: true)
    int classId;
    @JsonKey(nullable: true)
    String className;
    @JsonKey(nullable: true)
    String country;
    @JsonKey(nullable: true)
    String createDate;
    @JsonKey(nullable: true)
    DateTime createDateOffset;
    @JsonKey(nullable: true)
    String email;
    @JsonKey(nullable: true)
    String firstName;
    @JsonKey(nullable: true)
    String gender;
    @JsonKey(nullable: true)
    String lastName;
    @JsonKey(nullable: true)
    String modifyDate;
    @JsonKey(nullable: true)
    String phone;
    @JsonKey(nullable: true)
    String profileImage;
    @JsonKey(nullable: true)
    dynamic profileImagePath;
    @JsonKey(nullable: true)
    String postalCode;
    @JsonKey(nullable: true)
    dynamic rawImageData;
    @JsonKey(nullable: true)
    dynamic rawImageFile;
    @JsonKey(nullable: true)
    String registrationId;
    @JsonKey(nullable: true)
    DateTime lastActive;
    @JsonKey(nullable: true)
    dynamic stats;
    @JsonKey(nullable: true)
    List<StudentClass> studentClasses;
    @JsonKey(nullable: true)
    dynamic profileLanguage;
    @JsonKey(nullable: true)
    String studentProfileId;
    @JsonKey(nullable: true)
    List<StudentSubject> studentSubjects;
    @JsonKey(nullable: true)
    String subjectIds;
    @JsonKey(nullable: true)
    dynamic thumbImage;
    @JsonKey(nullable: true)
    dynamic tileImage;
    @JsonKey(nullable: true)
    int unsubscribeAll;
    @JsonKey(nullable: true)
    dynamic url;
    @JsonKey(nullable: true)
    DateTime lastOnline;
    @JsonKey(nullable: true)
    String timezoneInfo;
    @JsonKey(nullable: true)
    String timezoneInfoGmt;
    @JsonKey(nullable: true)
    int timezoneInfoForce;

    factory Student.fromJson(Map<String, dynamic> json) => _$StudentFromJson(json);

    Map<String, dynamic> toJson() => _$StudentToJson(this);
}

@JsonSerializable()
class StudentClass {
    StudentClass({
        this.checked,
        this.classDescription,
        this.classId,
        this.className,
        this.order,
    });
    @JsonKey(nullable: true)
    bool checked;
    @JsonKey(nullable: true)
    String classDescription;
    @JsonKey(nullable: true)
    int classId;
    @JsonKey(nullable: true)
    String className;
    @JsonKey(nullable: true)
    int order;

    factory StudentClass.fromJson(Map<String, dynamic> json) => _$StudentClassFromJson(json);

    Map<String, dynamic> toJson() => _$StudentClassToJson(this);
}

@JsonSerializable()
class StudentSubject {
    StudentSubject({
        this.checked,
        this.subjectDescription,
        this.subjectId,
        this.subjectName,
    });
    @JsonKey(nullable: true)
    bool checked;
    @JsonKey(nullable: true)
    String subjectDescription;
    @JsonKey(nullable: true)
    int subjectId;
    @JsonKey(nullable: true)
    String subjectName;

    factory StudentSubject.fromJson(Map<String, dynamic> json) => _$StudentSubjectFromJson(json);

    Map<String, dynamic> toJson() => _$StudentSubjectToJson(this);
}

