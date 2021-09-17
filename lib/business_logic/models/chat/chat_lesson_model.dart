import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'chat_lesson_model.g.dart';

ChatLesson chatLessonFromJson(String str) => ChatLesson.fromJson(json.decode(str));

String chatLessonToJson(ChatLesson data) => json.encode(data.toJson());

@JsonSerializable()
class ChatLesson {
    ChatLesson({
        this.success,
        this.message,
        this.result,
    });
    @JsonKey(nullable: true)
    bool success;
    @JsonKey(nullable: true)
    String message;
    @JsonKey(nullable: true)
    ChatResult result;

    factory ChatLesson.fromJson(Map<String, dynamic> json) => _$ChatLessonFromJson(json);

    Map<String, dynamic> toJson() => _$ChatLessonToJson(this);
}

@JsonSerializable()
class ChatResult {
    ChatResult({
        this.chatList,
        this.chatMessages,
    });
    @JsonKey(nullable: true)
    List<Chat> chatList;
    @JsonKey(nullable: true)
    List<Chat> chatMessages;

    factory ChatResult.fromJson(Map<String, dynamic> json) => _$ChatResultFromJson(json);

    Map<String, dynamic> toJson() => _$ChatResultToJson(this);

}

@JsonSerializable()
class Chat {
    Chat({
        this.messageId,
        this.senderId,
        this.receiverId,
        this.contactPersonId,
        this.senderFirstName,
        this.senderLastName,
        this.senderUrl,
        this.senderImage,
        this.senderEmail,
        this.senderTitle,
        this.senderTimeZone,
        this.senderTimeZoneInfo,
        this.receiverFirstName,
        this.receiverLastName,
        this.receiverUrl,
        this.receiverImage,
        this.receiverEmail,
        this.receiverTitle,
        this.receiverTimeZone,
        this.receiverTimeZoneInfo,
        this.messageText,
        this.messageTextEvent,
        this.createDate,
        this.fileName,
        this.fileOriginalName,
        this.seenByReceiver,
    });
    @JsonKey(nullable: true)
    int messageId;
    @JsonKey(nullable: true)
    int senderId;
    @JsonKey(nullable: true)
    int receiverId;
    @JsonKey(nullable: true)
    int contactPersonId;
    @JsonKey(nullable: true)
    String senderFirstName;
    @JsonKey(nullable: true)
    String senderLastName;
    @JsonKey(nullable: true)
    dynamic senderUrl;
    @JsonKey(nullable: true)
    dynamic senderImage;
    @JsonKey(nullable: true)
    dynamic senderEmail;
    @JsonKey(nullable: true)
    dynamic senderTitle;
    @JsonKey(nullable: true)
    dynamic senderTimeZone;
    @JsonKey(nullable: true)
    dynamic senderTimeZoneInfo;
    @JsonKey(nullable: true)
    dynamic receiverFirstName;
    @JsonKey(nullable: true)
    dynamic receiverLastName;
    @JsonKey(nullable: true)
    dynamic receiverUrl;
    @JsonKey(nullable: true)
    dynamic receiverImage;
    @JsonKey(nullable: true)
    dynamic receiverEmail;
    @JsonKey(nullable: true)
    dynamic receiverTitle;
    @JsonKey(nullable: true)
    dynamic receiverTimeZone;
    @JsonKey(nullable: true)
    dynamic receiverTimeZoneInfo;
    @JsonKey(nullable: true)
    String messageText;
    @JsonKey(nullable: true)
    String messageTextEvent;
    @JsonKey(nullable: true)
    DateTime createDate;
    @JsonKey(nullable: true)
    String fileName;
    @JsonKey(nullable: true)
    String fileOriginalName;
    @JsonKey(nullable: true)
    bool seenByReceiver;

    factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);

    Map<String, dynamic> toJson() => _$ChatToJson(this);
    
}