import 'dart:async';

import 'package:flutter/material.dart';
import 'package:justlearn/services/livelesson/live_lesson_provider.dart';
import 'package:justlearn/services/user_profile/user_profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CountDownLive extends StatefulWidget {
  static const String id = "countdown_live";
  @override
  _CountDownLiveState createState() => _CountDownLiveState();
}

class _CountDownLiveState extends State<CountDownLive> {
  final interval = const Duration(seconds: 1);
  final int timerMaxSeconds = 180;

  int currentSeconds = 0;

  Timer _clockTimer;

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}:${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  startTimeout(int tickk) async {
    setState(() {
      currentSeconds = tickk;
      if (tickk >= timerMaxSeconds) _clockTimer.cancel();
    });
    if (tickk == 2) {
      final userState = Provider.of<UserProvider>(context, listen: false);
      final liveLessonState =
          Provider.of<LiveLessonProvider>(context, listen: false);
      await liveLessonState.getLiveLesson(
          userState.student.registrationId, userState.student.firstName);
      if (liveLessonState.liveLesson.result.meetingUrl.isNotEmpty) {
        print(liveLessonState.liveLesson.result.meetingUrl);
        _clockTimer.cancel();
      }
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _afterLayout(context));
    super.initState();
  }

  _afterLayout(BuildContext context) async {
    final userState = Provider.of<UserProvider>(context, listen: false);
    await userState.loadParamsAsync;
    await userState.checkUser();
    _clockTimer =
        Timer.periodic(interval, (Timer timer) => startTimeout(timer.tick));
  }

  @override
  void dispose() {
    _clockTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 8),
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Live English Tutor',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'WorkSans',
                                    fontSize: 22.0,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              thickness: 2.0,
                              height: 30.0,
                            ),
                            SizedBox(height: 50.0),
                            Text(
                              'Tutor will join in $timerText',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Consumer<LiveLessonProvider>(
                              builder: (context, liveLessonState, child) =>
                                  liveLessonState.isLoading
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Material(
                                            color: Color(0xFF3061cc),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                            elevation: 5.0,
                                            child: MaterialButton(
                                              onPressed: () async {
                                                if (await canLaunch(
                                                    liveLessonState.liveLesson
                                                        .result.meetingUrl)) {
                                                  await launch(liveLessonState
                                                      .liveLesson
                                                      .result
                                                      .meetingUrl);
                                                } else {
                                                  throw "Can't open the link.";
                                                }
                                              },
                                              minWidth: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .75,
                                              height: 42.0,
                                              child: Text(
                                                'Join Lesson',
                                                style: TextStyle(
                                                  fontFamily: 'WorkSans',
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : CircularProgressIndicator(),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
