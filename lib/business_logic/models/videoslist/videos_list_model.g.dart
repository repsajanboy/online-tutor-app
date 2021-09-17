// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'videos_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideosList _$VideosListFromJson(Map<String, dynamic> json) {
  return VideosList(
    success: json['success'] as bool,
    message: json['message'] as String,
    result: json['result'] == null
        ? null
        : VideoResult.fromJson(json['result'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$VideosListToJson(VideosList instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'result': instance.result,
    };

VideoResult _$VideoResultFromJson(Map<String, dynamic> json) {
  return VideoResult(
    videoCourses: (json['videoCourses'] as List)
        ?.map((e) =>
            e == null ? null : VideoCourse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    categories: (json['categories'] as List)?.map((e) => e as String)?.toList(),
    categoriesApproved:
        (json['categoriesApproved'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$VideoResultToJson(VideoResult instance) =>
    <String, dynamic>{
      'videoCourses': instance.videoCourses,
      'categories': instance.categories,
      'categoriesApproved': instance.categoriesApproved,
    };

VideoCourse _$VideoCourseFromJson(Map<String, dynamic> json) {
  return VideoCourse(
    videoCourseId: json['videoCourseId'] as int,
    registrationId: json['registrationId'] as int,
    title: json['title'] as String,
    description: json['description'] as String,
    trailerVideoLink: json['trailerVideoLink'] as String,
    courseVideoLink: json['courseVideoLink'] as String,
    createDate: json['createDate'] == null
        ? null
        : DateTime.parse(json['createDate'] as String),
    modifyDate: json['modifyDate'] == null
        ? null
        : DateTime.parse(json['modifyDate'] as String),
    courseTitleUrl: json['courseTitleUrl'] as String,
    courseIsApproved: json['courseIsApproved'] as int,
    courseIsDeleted: json['courseIsDeleted'] as int,
    videoThumbnail: json['videoThumbnail'] as String,
    subscriptionRequired: json['subscriptionRequired'] as bool,
    category: json['category'] as String,
    isPicked: json['isPicked'] as bool,
    learningScore: json['learningScore'] as int,
    learningScoreDecimal: (json['learningScoreDecimal'] as num)?.toDouble(),
    learningScoreString: json['learningScoreString'] as String,
    learningScoreAll: json['learningScoreAll'] as String,
    registrationName: json['registrationName'] as String,
    courseVideoLinkFile: json['courseVideoLinkFile'] as String,
    videoLink: json['videoLink'],
    embedVideoV2: json['embedVideoV2'] as String,
    videoDuration: json['videoDuration'] as int,
    videoPlaylistId: json['videoPlaylistId'] as int,
    videoCourses: (json['videoCourses'] as List)
        ?.map((e) =>
            e == null ? null : VideoCourse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$VideoCourseToJson(VideoCourse instance) =>
    <String, dynamic>{
      'videoCourseId': instance.videoCourseId,
      'registrationId': instance.registrationId,
      'title': instance.title,
      'description': instance.description,
      'trailerVideoLink': instance.trailerVideoLink,
      'courseVideoLink': instance.courseVideoLink,
      'createDate': instance.createDate?.toIso8601String(),
      'modifyDate': instance.modifyDate?.toIso8601String(),
      'courseTitleUrl': instance.courseTitleUrl,
      'courseIsApproved': instance.courseIsApproved,
      'courseIsDeleted': instance.courseIsDeleted,
      'videoThumbnail': instance.videoThumbnail,
      'subscriptionRequired': instance.subscriptionRequired,
      'category': instance.category,
      'isPicked': instance.isPicked,
      'learningScore': instance.learningScore,
      'learningScoreDecimal': instance.learningScoreDecimal,
      'learningScoreString': instance.learningScoreString,
      'learningScoreAll': instance.learningScoreAll,
      'registrationName': instance.registrationName,
      'courseVideoLinkFile': instance.courseVideoLinkFile,
      'videoLink': instance.videoLink,
      'embedVideoV2': instance.embedVideoV2,
      'videoDuration': instance.videoDuration,
      'videoPlaylistId': instance.videoPlaylistId,
      'videoCourses': instance.videoCourses,
    };
