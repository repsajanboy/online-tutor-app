import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:justlearn/business_logic/models/auth/params_model.dart';
import 'package:justlearn/business_logic/models/chat/chat_lesson_model.dart';
import 'package:justlearn/business_logic/models/lessons/lessons_model.dart';
import 'package:justlearn/services/chat/chat_Lesson_provider.dart';
import 'package:justlearn/services/dashboardDetails.dart/dash_details_provider.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  static const String id = "chat_screen";
  final Sessionlist sessions;

  const ChatScreen({Key key, this.sessions}) : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Chat> chatmessages = [];
  ParamsResponse details;
  // ScrollController _controller;
  final chatM = TextEditingController();
  Timer timer;
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    // _controller = new ScrollController();
    timer =
        Timer.periodic(Duration(seconds: 5), (Timer t) => chatMessagesApi());
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   print(_controller.position.maxScrollExtent);
    //   _controller.animateTo(_controller.position.maxScrollExtent,
    //       duration: Duration(milliseconds: 5), curve: Curves.bounceIn);
    // });
    chatM.addListener(_getMessageText);
  }

  @override
  void dispose() {
    timer?.cancel();
    chatM.dispose();
    // _controller.dispose();
    super.dispose();
  }

  _getMessageText() {
    setState(() {
      chatM.text;
    });
  }

  chatMessagesApi() async {
    final dashState = Provider.of<DashDetailsProvider>(context, listen: false);
    final chatState = Provider.of<ChatLessonProvider>(context, listen: false);
    await chatState.getChatMessages(
        int.parse(dashState.loadParams.id),
        dashState.loadParams.timezone,
        dashState.loadParams.timezoneinfo,
        widget.sessions.sessionId);
    print("every5");
  }

  @override
  Widget build(BuildContext context) {
    print('chat build');
    // Timer(Duration(milliseconds: 500),
    //     () => _controller.jumpTo(_controller.position.maxScrollExtent));
    final dashState = Provider.of<DashDetailsProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: dashState.loadParams.type == 'S'
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: "${widget.sessions.teacherImage}".isEmpty
                        ? NetworkImage(
                            'https://www.cdnjustlearn.com/image/intet-billede.jpg')
                        : NetworkImage(
                            '${widget.sessions.teacherImagePath}${widget.sessions.teacherImage}'),
                    maxRadius: 20,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text('${widget.sessions.teacherName}'),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: "${widget.sessions.studentImage}".isEmpty
                        ? NetworkImage(
                            'https://www.cdnjustlearn.com/image/intet-billede.jpg')
                        : NetworkImage(
                            '${widget.sessions.teacherImagePath}${widget.sessions.studentImage}'),
                    maxRadius: 20,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text('${widget.sessions.studentName}'),
                ],
              ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Consumer<ChatLessonProvider>(
                  builder: (context, chatProvider, child) =>
                      !chatProvider.isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView.builder(
                              addAutomaticKeepAlives: true,
                              primary: false,
                              shrinkWrap: true,
                              reverse: true,
                              // controller: _controller,
                              itemCount: chatProvider.chatList.length,
                              itemBuilder: (context, index) {
                                Chat chats = chatProvider.chatList[index];
                                // print(chats.receiverFirstName);
                                // return Text('');
                                return _chatMessagesList(chats);
                              },
                            ),
                ),
              ),
            ),
            Divider(height: 5.0, color: Colors.black54),
            Container(
              height: MediaQuery.of(context).size.height * .15,
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  // Icon(
                  //   Icons.attach_file_rounded,
                  //   color: Color(0xFF3061cc),
                  //   size: 32.0,
                  // ),
                  SizedBox(width: 15.0),
                  Expanded(
                    child: TextField(
                      controller: chatM,
                      autofocus: true,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'Message',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 30.0),
                        border: OutlineInputBorder(),
                      ),
                      onTap: () {
                        // print(_controller.position.maxScrollExtent);
                        // _controller
                        //     .jumpTo(_controller.position.maxScrollExtent);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  FlatButton(
                    disabledColor: Colors.transparent,
                    height: 45.0,
                    color: Color(0xFF3061cc),
                    textColor: Colors.white,
                    child: _isSending
                        ? Container(
                            margin: EdgeInsets.all(10.0),
                            child: CircularProgressIndicator(),
                          )
                        : Text(
                            'Send',
                            style: TextStyle(fontSize: 18.0),
                          ),
                    onPressed: !_isSending
                        ? () async {
                            // bool _response;
                            setState(() {
                              _isSending = true;
                            });
                            final chatProvider =
                                Provider.of<ChatLessonProvider>(context,
                                    listen: false);
                            final dashState = Provider.of<DashDetailsProvider>(
                                context,
                                listen: false);
                            var receiverId = dashState.loadParams.type == "T"
                                ? widget.sessions.studentId
                                : widget.sessions.teacherId;
                            var senderName = dashState.loadParams.type == "T"
                                ? widget.sessions.studentName
                                : widget.sessions.teacherName;
                            // _response = await chatProvider.sendMessage(
                            //     dashState.loadParams.id,
                            //     receiverId.toString(),
                            //     dashState.loadParams.type,
                            //     senderName,
                            //     chatM.text);

                            await chatProvider
                                .sendMessage(
                                    dashState.loadParams.id,
                                    receiverId.toString(),
                                    dashState.loadParams.type,
                                    senderName,
                                    chatM.text)
                                .then((value) async {
                              if (value) {
                                chatM.clear();

                                await chatProvider.getChatMessages(
                                    int.parse(dashState.loadParams.id),
                                    dashState.loadParams.timezone,
                                    dashState.loadParams.timezoneinfo,
                                    widget.sessions.sessionId);
                                // _controller
                                //     .jumpTo(_controller.position.maxScrollExtent);
                                // FocusScope.of(context).requestFocus(new FocusNode());
                              }
                            }).whenComplete(() {
                              setState(() {
                                _isSending = false;
                              });
                            });

                            // print(_response);

                            // if (_response) {
                            //   await chatProvider.getChatMessages(
                            //       int.parse(dashState.loadParams.id),
                            //       dashState.loadParams.timezone,
                            //       dashState.loadParams.timezoneinfo,
                            //       widget.sessions.sessionId);
                            //   // _controller
                            //   //     .jumpTo(_controller.position.maxScrollExtent);
                            //   // FocusScope.of(context).requestFocus(new FocusNode());
                            // }
                          }
                        : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chatMessagesList(Chat chatL) {
    final dashState = Provider.of<DashDetailsProvider>(context, listen: false);
    return int.parse(dashState.loadParams.id) == chatL.senderId
        ? Card(
            elevation: 0,
            color: Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 5.0),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${chatL.messageText}',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                        chatL.messageTextEvent.isNotEmpty
                            ? _chatContentSender(chatL.messageTextEvent)
                            : SizedBox(),
                      ],
                    ),
                  ),
                  Text(
                    '${DateFormat.yMd().add_jm().format(chatL.createDate)}',
                    style: TextStyle(color: Colors.black54, fontSize: 11.0),
                  )
                ],
              ),
            ),
          )
        : Card(
            elevation: 0,
            color: Colors.transparent,
            child: Container(
              child: Row(
                children: [
                  dashState.loadParams.type == "S"
                      ? CircleAvatar(
                          backgroundImage: "${widget.sessions.teacherImage}"
                                  .isEmpty
                              ? NetworkImage(
                                  'https://www.cdnjustlearn.com/image/intet-billede.jpg')
                              : NetworkImage(
                                  '${widget.sessions.teacherImagePath}${widget.sessions.teacherImage}'),
                          maxRadius: 15,
                        )
                      : CircleAvatar(
                          backgroundImage: "${widget.sessions.studentImage}"
                                  .isEmpty
                              ? NetworkImage(
                                  'https://www.cdnjustlearn.com/image/intet-billede.jpg')
                              : NetworkImage(
                                  '${widget.sessions.teacherImagePath}${widget.sessions.studentImage}'),
                          maxRadius: 15,
                        ),
                  SizedBox(width: 8.0),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(color: Colors.black54, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.only(bottom: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${chatL.messageText}',
                                style: TextStyle(fontSize: 16.0),
                              ),
                              chatL.messageTextEvent.isNotEmpty
                                  ? _chatContent(chatL.messageTextEvent)
                                  : SizedBox(),
                            ],
                          ),
                        ),
                        Text(
                          '${DateFormat.yMd().add_jm().format(chatL.createDate)}',
                          style:
                              TextStyle(color: Colors.black54, fontSize: 11.0),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }

  Widget _chatContent(String messageEvent) {
    var eventArr = messageEvent.split(',');
    switch (eventArr[0]) {
      case "purchase":
        {
          if (eventArr.length > 3) {
            DateFormat inputFormat = DateFormat("MM/dd/yyyy hh:mm:ss a");
            DateTime temp1 = inputFormat.parse(eventArr[3]);
            var datee = DateTime.parse(temp1.toString() + 'Z');
            return eventArr[1] == "0"
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Lesson: 1',
                      ),
                      Wrap(
                        direction: Axis.vertical,
                        children: [
                          Text(
                            'Time: ${DateFormat.jm().format(datee.toLocal())}',
                          ),
                          Text(
                            '${DateFormat.yMMMMEEEEd().format(datee.toLocal())}',
                          ),
                        ],
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Text(
                        'Total Lesson: ${eventArr[1]}',
                      ),
                      Wrap(
                        direction: Axis.vertical,
                        children: [
                          Text(
                            'Time: ${DateFormat.jm().format(datee.toLocal())}',
                          ),
                          Text(
                            '${DateFormat.yMMMMEEEEd().format(datee.toLocal())}',
                          ),
                        ],
                      ),
                    ],
                  );
          } else {
            return eventArr[1] == "0"
                ? Text(
                    'Total Lesson: 1',
                  )
                : Text(
                    'Total Lesson: ${eventArr[1]}',
                  );
          }
        }
        break;

      case "reschedule":
        {
          DateFormat inputFormat = DateFormat("MM/dd/yyyy hh:mm:ss a");
          DateTime temp1 = inputFormat.parse(eventArr[3]);
          var datee = DateTime.parse(temp1.toString() + 'Z');
          DateTime temp2 = inputFormat.parse(eventArr[2]);
          var datee2 = DateTime.parse(temp2.toString() + 'Z');
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                direction: Axis.vertical,
                children: [
                  Text(
                    'Original Time: ',
                  ),
                  Text(
                    '${DateFormat.jm().format(datee.toLocal())} ${DateFormat.yMMMMEEEEd().format(datee.toLocal())}',
                    style: TextStyle(decoration: TextDecoration.lineThrough),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ],
              ),
              Wrap(
                direction: Axis.vertical,
                children: [
                  Text(
                    'Time: ${DateFormat.jm().format(datee2.toLocal())} ',
                  ),
                  Text(
                    '${DateFormat.yMMMMEEEEd().format(datee2.toLocal())}',
                  ),
                ],
              ),
            ],
          );
        }
        break;
      case "booked":
        {
          DateFormat inputFormat = DateFormat("MM/dd/yyyy hh:mm:ss a");
          DateTime temp1 = inputFormat.parse(eventArr[2]);
          var datee = DateTime.parse(temp1.toString() + 'Z');
          return Column(
            children: [
              Wrap(
                direction: Axis.vertical,
                children: [
                  Text(
                    'Time: ${DateFormat.jm().format(datee.toLocal())}',
                  ),
                  Text(
                    '${DateFormat.yMMMMEEEEd().format(datee.toLocal())}',
                  ),
                ],
              ),
            ],
          );
        }
        break;
      default:
        {
          return SizedBox();
        }
    }
  }

  Widget _chatContentSender(String messageEvent) {
    var eventArr = messageEvent.split(',');
    switch (eventArr[0]) {
      case "purchase":
        {
          if (eventArr.length > 3) {
            DateFormat inputFormat = DateFormat("MM/dd/yyyy hh:mm:ss a");
            DateTime temp1 = inputFormat.parse(eventArr[3]);
            var datee = DateTime.parse(temp1.toString() + 'Z');
            return eventArr[1] == "0"
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Lesson: 1',
                        style: TextStyle(color: Colors.white),
                      ),
                      Wrap(
                        direction: Axis.vertical,
                        children: [
                          Text(
                            'Time: ${DateFormat.jm().format(datee.toLocal())}',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            '${DateFormat.yMMMMEEEEd().format(datee.toLocal())}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Text(
                        'Total Lesson: ${eventArr[1]}',
                        style: TextStyle(color: Colors.white),
                      ),
                      Wrap(
                        direction: Axis.vertical,
                        children: [
                          Text(
                            'Time: ${DateFormat.jm().format(datee.toLocal())}',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            '${DateFormat.yMMMMEEEEd().format(datee.toLocal())}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  );
          } else {
            return eventArr[1] == "0"
                ? Text(
                    'Total Lesson: 1',
                    style: TextStyle(color: Colors.white),
                  )
                : Text(
                    'Total Lesson: ${eventArr[1]}',
                    style: TextStyle(color: Colors.white),
                  );
          }
        }
        break;

      case "reschedule":
        {
          DateFormat inputFormat = DateFormat("MM/dd/yyyy hh:mm:ss a");
          DateTime temp1 = inputFormat.parse(eventArr[3]);
          var datee = DateTime.parse(temp1.toString() + 'Z');
          DateTime temp2 = inputFormat.parse(eventArr[2]);
          var datee2 = DateTime.parse(temp2.toString() + 'Z');
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                direction: Axis.vertical,
                children: [
                  Text(
                    'Original Time: ',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    '${DateFormat.jm().format(datee.toLocal())} ${DateFormat.yMMMMEEEEd().format(datee.toLocal())}',
                    style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ],
              ),
              Wrap(
                direction: Axis.vertical,
                children: [
                  Text(
                    'Time: ${DateFormat.jm().format(datee2.toLocal())} ',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    '${DateFormat.yMMMMEEEEd().format(datee2.toLocal())}',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          );
        }
        break;
      case "booked":
        {
          DateFormat inputFormat = DateFormat("MM/dd/yyyy hh:mm:ss a");
          DateTime temp1 = inputFormat.parse(eventArr[2]);
          var datee = DateTime.parse(temp1.toString() + 'Z');
          return Column(
            children: [
              Wrap(
                direction: Axis.vertical,
                children: [
                  Text(
                    'Time: ${DateFormat.jm().format(datee.toLocal())}',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    '${DateFormat.yMMMMEEEEd().format(datee.toLocal())}',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          );
        }
        break;

      default:
        {
          return SizedBox();
        }
    }
  }
}
