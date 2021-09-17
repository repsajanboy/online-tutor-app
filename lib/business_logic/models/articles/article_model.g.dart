// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return Article(
    success: json['success'] as bool,
    message: json['message'] as String,
    result: (json['result'] as List)
        ?.map((e) =>
            e == null ? null : Result.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'result': instance.result,
    };

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
    authorId: json['authorId'] as int,
    authorName: json['authorName'] as String,
    authorProfile: json['authorProfile'],
    authorType: json['authorType'] as String,
    articleUrl: json['articleUrl'] as String,
    contentText: json['contentText'] as String,
    createDate: json['createDate'] == null
        ? null
        : DateTime.parse(json['createDate'] as String),
    readByTime: json['readByTime'] as String,
    headLine: json['headLine'] as String,
    id: json['id'] as int,
    image: json['image'] as String,
    imagePath: json['imagePath'] as String,
    imageSourceUrl: json['imageSourceUrl'],
    imageSourceUrlPreview: json['imageSourceUrlPreview'],
    isActive: json['isActive'] as bool,
    recommendedTeachers: json['recommendedTeachers'] as List,
    thumbImage: json['thumbImage'] as String,
    tileImage: json['tileImage'] as String,
    topicId: json['topicId'] as int,
    topiclist: json['topiclist'],
    topicName: json['topicName'] as String,
    uniqueTitle: json['uniqueTitle'] as String,
    category: json['category'] as String,
    articleList: json['articleList'],
    articlesFaq: json['articlesFaq'] == null
        ? null
        : ArtoclesFac.fromJson(json['articlesFaq'] as Map<String, dynamic>),
    modifyDate: json['modifyDate'] == null
        ? null
        : DateTime.parse(json['modifyDate'] as String),
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'authorId': instance.authorId,
      'authorName': instance.authorName,
      'authorProfile': instance.authorProfile,
      'authorType': instance.authorType,
      'articleUrl': instance.articleUrl,
      'contentText': instance.contentText,
      'createDate': instance.createDate?.toIso8601String(),
      'readByTime': instance.readByTime,
      'headLine': instance.headLine,
      'id': instance.id,
      'image': instance.image,
      'imagePath': instance.imagePath,
      'imageSourceUrl': instance.imageSourceUrl,
      'imageSourceUrlPreview': instance.imageSourceUrlPreview,
      'isActive': instance.isActive,
      'recommendedTeachers': instance.recommendedTeachers,
      'thumbImage': instance.thumbImage,
      'tileImage': instance.tileImage,
      'topicId': instance.topicId,
      'topiclist': instance.topiclist,
      'topicName': instance.topicName,
      'uniqueTitle': instance.uniqueTitle,
      'category': instance.category,
      'articleList': instance.articleList,
      'articlesFaq': instance.articlesFaq,
      'modifyDate': instance.modifyDate?.toIso8601String(),
    };

ArtoclesFac _$ArtoclesFacFromJson(Map<String, dynamic> json) {
  return ArtoclesFac(
    articleFaqId: json['articleFaqId'] as int,
    articleId: json['articleId'] as int,
    faqTitle1: json['faqTitle1'] as String,
    faqAnswer1: json['faqAnswer1'] as String,
    faqTitle2: json['faqTitle2'] as String,
    faqAnswer2: json['faqAnswer2'] as String,
    faqTitle3: json['faqTitle3'] as String,
    faqAnswer3: json['faqAnswer3'] as String,
    faqTitle4: json['faqTitle4'] as String,
    faqAnswer4: json['faqAnswer4'] as String,
    faqTitle5: json['faqTitle5'] as String,
    faqAnswer5: json['faqAnswer5'] as String,
    faqTitle6: json['faqTitle6'] as String,
    faqAnswer6: json['faqAnswer6'] as String,
    faqTitle7: json['faqTitle7'] as String,
    faqAnswer7: json['faqAnswer7'] as String,
    faqTitle8: json['faqTitle8'] as String,
    faqAnswer8: json['faqAnswer8'] as String,
    faqTitle9: json['faqTitle9'] as String,
    faqAnswer9: json['faqAnswer9'] as String,
    faqTitle10: json['faqTitle10'] as String,
    faqAnswer10: json['faqAnswer10'] as String,
    faqTitle11: json['faqTitle11'] as String,
    faqAnswer11: json['faqAnswer11'] as String,
    faqTitle12: json['faqTitle12'] as String,
    faqAnswer12: json['faqAnswer12'] as String,
    faqTitle13: json['faqTitle13'] as String,
    faqAnswer13: json['faqAnswer13'] as String,
    faqTitle14: json['faqTitle14'] as String,
    faqAnswer14: json['faqAnswer14'] as String,
    faqTitle15: json['faqTitle15'] as String,
    faqAnswer15: json['faqAnswer15'] as String,
    faqTitle16: json['faqTitle16'] as String,
    faqAnswer16: json['faqAnswer16'] as String,
    faqTitle17: json['faqTitle17'] as String,
    faqAnswer17: json['faqAnswer17'] as String,
    faqTitle18: json['faqTitle18'] as String,
    faqAnswer18: json['faqAnswer18'] as String,
    faqTitle19: json['faqTitle19'] as String,
    faqAnswer19: json['faqAnswer19'] as String,
    faqTitle20: json['faqTitle20'] as String,
    faqAnswer20: json['faqAnswer20'] as String,
    createDate: json['createDate'] == null
        ? null
        : DateTime.parse(json['createDate'] as String),
    modifyDate: json['modifyDate'] == null
        ? null
        : DateTime.parse(json['modifyDate'] as String),
  );
}

Map<String, dynamic> _$ArtoclesFacToJson(ArtoclesFac instance) =>
    <String, dynamic>{
      'articleFaqId': instance.articleFaqId,
      'articleId': instance.articleId,
      'faqTitle1': instance.faqTitle1,
      'faqAnswer1': instance.faqAnswer1,
      'faqTitle2': instance.faqTitle2,
      'faqAnswer2': instance.faqAnswer2,
      'faqTitle3': instance.faqTitle3,
      'faqAnswer3': instance.faqAnswer3,
      'faqTitle4': instance.faqTitle4,
      'faqAnswer4': instance.faqAnswer4,
      'faqTitle5': instance.faqTitle5,
      'faqAnswer5': instance.faqAnswer5,
      'faqTitle6': instance.faqTitle6,
      'faqAnswer6': instance.faqAnswer6,
      'faqTitle7': instance.faqTitle7,
      'faqAnswer7': instance.faqAnswer7,
      'faqTitle8': instance.faqTitle8,
      'faqAnswer8': instance.faqAnswer8,
      'faqTitle9': instance.faqTitle9,
      'faqAnswer9': instance.faqAnswer9,
      'faqTitle10': instance.faqTitle10,
      'faqAnswer10': instance.faqAnswer10,
      'faqTitle11': instance.faqTitle11,
      'faqAnswer11': instance.faqAnswer11,
      'faqTitle12': instance.faqTitle12,
      'faqAnswer12': instance.faqAnswer12,
      'faqTitle13': instance.faqTitle13,
      'faqAnswer13': instance.faqAnswer13,
      'faqTitle14': instance.faqTitle14,
      'faqAnswer14': instance.faqAnswer14,
      'faqTitle15': instance.faqTitle15,
      'faqAnswer15': instance.faqAnswer15,
      'faqTitle16': instance.faqTitle16,
      'faqAnswer16': instance.faqAnswer16,
      'faqTitle17': instance.faqTitle17,
      'faqAnswer17': instance.faqAnswer17,
      'faqTitle18': instance.faqTitle18,
      'faqAnswer18': instance.faqAnswer18,
      'faqTitle19': instance.faqTitle19,
      'faqAnswer19': instance.faqAnswer19,
      'faqTitle20': instance.faqTitle20,
      'faqAnswer20': instance.faqAnswer20,
      'createDate': instance.createDate?.toIso8601String(),
      'modifyDate': instance.modifyDate?.toIso8601String(),
    };
