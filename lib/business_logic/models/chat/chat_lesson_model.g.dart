// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_lesson_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatLesson _$ChatLessonFromJson(Map<String, dynamic> json) {
  return ChatLesson(
    success: json['success'] as bool,
    message: json['message'] as String,
    result: json['result'] == null
        ? null
        : ChatResult.fromJson(json['result'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ChatLessonToJson(ChatLesson instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'result': instance.result,
    };

ChatResult _$ChatResultFromJson(Map<String, dynamic> json) {
  return ChatResult(
    chatList: (json['chatList'] as List)
        ?.map(
            (e) => e == null ? null : Chat.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    chatMessages: (json['chatMessages'] as List)
        ?.map(
            (e) => e == null ? null : Chat.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ChatResultToJson(ChatResult instance) =>
    <String, dynamic>{
      'chatList': instance.chatList,
      'chatMessages': instance.chatMessages,
    };

Chat _$ChatFromJson(Map<String, dynamic> json) {
  return Chat(
    messageId: json['messageId'] as int,
    senderId: json['senderId'] as int,
    receiverId: json['receiverId'] as int,
    contactPersonId: json['contactPersonId'] as int,
    senderFirstName: json['senderFirstName'] as String,
    senderLastName: json['senderLastName'] as String,
    senderUrl: json['senderUrl'],
    senderImage: json['senderImage'],
    senderEmail: json['senderEmail'],
    senderTitle: json['senderTitle'],
    senderTimeZone: json['senderTimeZone'],
    senderTimeZoneInfo: json['senderTimeZoneInfo'],
    receiverFirstName: json['receiverFirstName'],
    receiverLastName: json['receiverLastName'],
    receiverUrl: json['receiverUrl'],
    receiverImage: json['receiverImage'],
    receiverEmail: json['receiverEmail'],
    receiverTitle: json['receiverTitle'],
    receiverTimeZone: json['receiverTimeZone'],
    receiverTimeZoneInfo: json['receiverTimeZoneInfo'],
    messageText: json['messageText'] as String,
    messageTextEvent: json['messageTextEvent'] as String,
    createDate: json['createDate'] == null
        ? null
        : DateTime.parse(json['createDate'] as String),
    fileName: json['fileName'] as String,
    fileOriginalName: json['fileOriginalName'] as String,
    seenByReceiver: json['seenByReceiver'] as bool,
  );
}

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'messageId': instance.messageId,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'contactPersonId': instance.contactPersonId,
      'senderFirstName': instance.senderFirstName,
      'senderLastName': instance.senderLastName,
      'senderUrl': instance.senderUrl,
      'senderImage': instance.senderImage,
      'senderEmail': instance.senderEmail,
      'senderTitle': instance.senderTitle,
      'senderTimeZone': instance.senderTimeZone,
      'senderTimeZoneInfo': instance.senderTimeZoneInfo,
      'receiverFirstName': instance.receiverFirstName,
      'receiverLastName': instance.receiverLastName,
      'receiverUrl': instance.receiverUrl,
      'receiverImage': instance.receiverImage,
      'receiverEmail': instance.receiverEmail,
      'receiverTitle': instance.receiverTitle,
      'receiverTimeZone': instance.receiverTimeZone,
      'receiverTimeZoneInfo': instance.receiverTimeZoneInfo,
      'messageText': instance.messageText,
      'messageTextEvent': instance.messageTextEvent,
      'createDate': instance.createDate?.toIso8601String(),
      'fileName': instance.fileName,
      'fileOriginalName': instance.fileOriginalName,
      'seenByReceiver': instance.seenByReceiver,
    };
