import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:justlearn/business_logic/models/lessons/lessons_model.dart';
import 'package:justlearn/services/chat/chat_Lesson_provider.dart';
import 'package:justlearn/services/dashboardDetails.dart/dash_details_provider.dart';
import 'package:justlearn/ui/views/components/viewlesson_action_buttons.dart';
import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher.dart';

import 'chat_lesson_screen.dart';

class ViewLesson extends StatefulWidget {
  final Sessionlist sessions;

  const ViewLesson({Key key, this.sessions}) : super(key: key);
  @override
  _ViewLessonState createState() => _ViewLessonState();
}

class _ViewLessonState extends State<ViewLesson> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _afterLayout(context));
  }

  _afterLayout(BuildContext context) async {
    final dashState = Provider.of<DashDetailsProvider>(context, listen: false);
    final chatState = Provider.of<ChatLessonProvider>(context, listen: false);
    await dashState.loadParamsAsync;
    await dashState.loadDashDetails();
    await chatState.getChatMessages(
        int.parse(dashState.loadParams.id),
        dashState.loadParams.timezone,
        dashState.loadParams.timezoneinfo,
        widget.sessions.sessionId);
    chatState.setLoading(true);
  }

  _navigateToChat(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          sessions: widget.sessions,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.only(
                top: 10.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back),
                        tooltip: "Leave",
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          'Leave',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () => _navigateToChat(context),
                    child: Text(
                      'Chat',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 230,
                    decoration: BoxDecoration(
                        color: Colors.black87,
                        image: DecorationImage(
                            image: AssetImage('assets/img/jbg.png'),
                            fit: BoxFit.contain)),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          widget.sessions.status == 67 ||
                                  widget.sessions.status == 70 ||
                                  widget.sessions.status == 68
                              ? Container()
                              : RaisedButton(
                                  color: Color(0xFF3061cc),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                      side:
                                          BorderSide(color: Color(0xFF3061cc))),
                                  onPressed: () async {
                                    if (await canLaunch(
                                        widget.sessions.startUrl)) {
                                      await launch(widget.sessions.startUrl);
                                    } else {
                                      throw "Can't open the link.";
                                    }
                                  },
                                  child: Text('Join',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: 'WorkSans',
                                          fontWeight: FontWeight.bold))),
                          Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: widget.sessions.status == 67 ||
                                    widget.sessions.status == 70 ||
                                    widget.sessions.status == 68
                                ? Text(
                                    'The classroom is closed. Encourage the student to book a new lesson',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                      fontFamily: 'WorkSans',
                                    ))
                                : Text('${widget.sessions.startUrl}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                      fontFamily: 'WorkSans',
                                    )),
                          )
                        ]),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Center(
                child: Column(
                  children: [
                    Text('Lesson',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontFamily: 'WorkSans',
                        )),
                    SizedBox(
                      height: 8.0,
                    ),
                    Consumer<DashDetailsProvider>(
                      builder: (context, dashProvider, child) =>
                          "${dashProvider.loadParams.type}" == "S"
                              ? Text(
                                  'Enter the classroom 5 minutes before time and wait for the teacher',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'WorkSans',
                                  ),
                                )
                              : Text(
                                  'Enter the classroom 5 minutes before time and wait for the student',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'WorkSans',
                                  ),
                                ),
                    )
                  ],
                ),
              ),
            ),
            Divider(
              height: 10,
              thickness: 2,
              color: Color(0xFF3061cc),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Consumer<DashDetailsProvider>(
                builder: (context, dashProvider, child) => Text(
                  'Time (GMT ${dashProvider.loadParams?.timezone})',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                  '${DateFormat.jm().format(widget.sessions.startTime.toLocal())}',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.bold)),
              Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: Text(
                    '${DateFormat.E().format(widget.sessions.startTime)}, ${DateFormat.yMMMd().format(widget.sessions.startTime)}',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                      fontFamily: 'WorkSans',
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: Text(
                    '${widget.sessions.subjectName}, ${widget.sessions.slotDuration} Minutes lesson',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                      fontFamily: 'WorkSans',
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: Consumer<DashDetailsProvider>(
                  builder: (context, dashProvider, child) =>
                      dashProvider.loadParams.type == "T"
                          ? Text(
                              'Student: ${widget.sessions.studentName}',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15,
                                fontFamily: 'WorkSans',
                              ),
                            )
                          : Text(
                              'Teacher: ${widget.sessions.teacherName}',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15,
                                fontFamily: 'WorkSans',
                              ),
                            ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: Consumer<DashDetailsProvider>(
                  builder: (context, dashProvider, child) => dashProvider
                              .loadParams.type ==
                          "T"
                      ? widget.sessions.slotDuration != 25
                          ? Text(
                              'Cashout: \$0',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15,
                                fontFamily: 'WorkSans',
                              ),
                            )
                          : widget.sessions.isSubscriptionTrial ||
                                  widget.sessions.trialWithoutCard == 1
                              ? Column(
                                  children: [
                                    Text(
                                      'Type: Trial Lesson',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 15,
                                        fontFamily: 'WorkSans',
                                      ),
                                    ),
                                    widget.sessions.status == 68
                                        ? widget.sessions.trialWithoutCard == 1
                                            ? widget.sessions
                                                        .subscriptionStatus ==
                                                    1
                                                ? Text(
                                                    'Cashout Amount : \$12. The student has paid for a new lesson',
                                                    style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 15,
                                                      fontFamily: 'WorkSans',
                                                    ),
                                                  )
                                                : Text(
                                                    'Get \$12, if the student pays for a new lesson',
                                                    style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 15,
                                                      fontFamily: 'WorkSans',
                                                    ),
                                                  )
                                            : Text(
                                                'Cashout Amount: \$0',
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 15,
                                                  fontFamily: 'WorkSans',
                                                ),
                                              )
                                        : widget.sessions.trialWithoutCard ==
                                                    1 &&
                                                widget.sessions
                                                        .subscriptionStatus ==
                                                    3
                                            ? Text(
                                                'Get \$12, if the student pays for a new lesson',
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 15,
                                                  fontFamily: 'WorkSans',
                                                ),
                                              )
                                            : Text(
                                                '\$0',
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 15,
                                                  fontFamily: 'WorkSans',
                                                ),
                                              )
                                  ],
                                )
                              : Text(
                                  'Cashout: \$6',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15,
                                    fontFamily: 'WorkSans',
                                  ),
                                )
                      : Container(),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Consumer<DashDetailsProvider>(
                    builder: (context, dashProvider, child) {
                      return dashProvider == null
                          ? Container()
                          : dashProvider != null &&
                                  dashProvider.dashDetails.subscriptionLessons >
                                      0
                              ? Text(
                                  '${dashProvider.dashDetails.subscriptionLessons} lessons remaining',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15,
                                    fontFamily: 'WorkSans',
                                  ),
                                )
                              : Text(
                                  '${dashProvider.dashDetails.subscriptionLessons} lessons remaining',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15,
                                    fontFamily: 'WorkSans',
                                  ),
                                );
                    },
                  )),
            ]),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: ViewLessonActionButtons(
                sess: widget?.sessions,
              ),
            )
          ]),
        ),
      )),
    );
  }
}
