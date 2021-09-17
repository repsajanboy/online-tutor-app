import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:justlearn/business_logic/models/chat/chat_lesson_model.dart';
import 'package:justlearn/business_logic/models/utils/networking.dart';
import 'package:http/http.dart' as http;

class ChatLessonProvider with ChangeNotifier {
  ChatLesson chatLesson = ChatLesson();
  List<Chat> chatList;
  bool isLoading = false;
  bool isSendMessage = false;

  void setLoading(value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> getChatMessages(
      int regId, String tzone, String tzoneInfo, int sessionId) async {
    var url = NetworkHelper.baseUrl +
        "api/user-messages?registrationid=$regId&zone=$tzone&timezoneinfo=$tzoneInfo&sessionid=$sessionId";
    // print(url);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final result = ChatLesson.fromJson(json.decode(response.body));
      if (result.success == true) {
        chatLesson = result;
        // print(result.result.chatMessages);
        chatList = result.result.chatMessages.reversed.toList();
        // print(
        //     'Chat list: ${result.result.chatMessages.reversed.map((e) => e.senderEmail)}');
        // print(chatList);
        notifyListeners();
      }
    } else {
      print(response.statusCode);
    }
  }

  Future<bool> sendMessage(String regId, String receiverId, String userType,
      String senderName, String message) async {
    var url = NetworkHelper.baseUrl + "api/send-message";
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        "RegistrationId": "$regId",
        "ReceiverId": "$receiverId",
        "UserType": "$userType",
        "SenderName": "$senderName",
        "ChatMessage": "$message"
      }),
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['success'] == true) {
        isSendMessage = true;
        notifyListeners();
      }
    }
    return isSendMessage;
  }
}
