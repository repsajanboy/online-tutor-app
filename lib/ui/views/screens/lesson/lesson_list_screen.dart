import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:justlearn/business_logic/models/lessons/lessons_model.dart';
import 'package:justlearn/services/action_buttons/action_buttons.dart';
import 'package:justlearn/services/bottomnav_provider.dart';

import 'package:justlearn/services/dashboardDetails.dart/dash_details_provider.dart';
import 'package:justlearn/services/lessons/lessons_list_api.dart';
import 'package:justlearn/ui/views/components/lesson_status.dart';
import 'package:justlearn/ui/views/components/lessonlist_action_button.dart';
import 'package:justlearn/ui/views/screens/menu_screen.dart';
import 'package:justlearn/ui/views/screens/tutor/stripe_subscription_screen.dart';
import 'package:provider/provider.dart';

class LessonListScreen extends StatefulWidget {
  static const String id = 'lesson_screen';
  @override
  _LessonScreenState createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonListScreen> {
  ScrollController _controller = new ScrollController();
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  bool gettingNewLesson = false;

  Future<void> _getNewLessonList() async {
    gettingNewLesson = true;
    final lessonState = Provider.of<LessonListApi>(context, listen: false);
    lessonState.setListNull();
    await lessonState.getLessonsList(lessonState.page);
    await Provider.of<DashDetailsProvider>(context, listen: false).loadDashDetails();
    gettingNewLesson = false;
    // final dashProvider =
    //     Provider.of<DashDetailsProvider>(context, listen: false);
    // await dashProvider.loadParamsAsync;
    // await dashProvider.loadDashDetails;
    // await Future.delayed(Duration(milliseconds: 1000));
  }

  @override
  void initState() {
    super.initState();
    Provider.of<ActionButtonsProvider>(context, listen: false).loadParamsAsync;
    // _controller.addListener(() {
    //   if (_controller.position.pixels == _controller.position.maxScrollExtent) {
    //     final lessonState = Provider.of<LessonListApi>(context, listen: false);
    //     lessonState.loadParamsAsync;
    //     lessonState.getLessonsList(lessonState.page);
    //   }
    // });

    // Provider.of<DashDetailsProvider>(context, listen: false).loadDashDetails();
    // Provider.of<LessonListApi>(context, listen: false).getLessonsList(1);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("lesson list build");
    final clock = Stream<DateTime>.periodic(const Duration(seconds: 1), (_) {
      return DateTime.now();
    });
    final dashProvider = Provider.of<DashDetailsProvider>(context);
    //final lessonProvider = Provider.of<LessonListApi>(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
            child: Column(
              children: [
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
                            StreamBuilder<DateTime>(
                              stream: clock,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    DateFormat('jm').format(snapshot.data),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'WorkSans'),
                                  );
                                }
                                return Text(
                                  DateFormat('jm').format(DateTime.now()),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'WorkSans'),
                                );
                              },
                            ),
                            Text(
                              'Lessons',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                  fontFamily: 'WorkSans'),
                            ),
                          ],
                        ),
                      ),
                    ),
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
                            dashProvider.dashDetails.subscriptionLessons == null
                                ? CircularProgressIndicator()
                                : Text(
                                    '${dashProvider.dashDetails.subscriptionLessons} lessons left')
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Consumer<LessonListApi>(
                    builder: (context, lessonProvider, child) =>
                        NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (!lessonProvider.isFetchingLessons &&
                            scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent) {
                          Provider.of<LessonListApi>(context, listen: false)
                              .getLessonsList(lessonProvider.page);
                        }
                      },
                      child: RefreshIndicator(
                        onRefresh: _getNewLessonList,
                        child: ListView.builder(
                          itemCount: lessonProvider.sessionList.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            // final dashState =
                            //     Provider.of<DashDetailsProvider>(context,
                            //         listen: false);
                            print(lessonProvider.sessionList.length);
                            if (lessonProvider.sessionList.length == 0) {
                              return _noLesson();
                            } else if (index == lessonProvider.sessionList.length) {
                              return _buildProgressIndicator();
                            } else {
                              Sessionlist session =
                                  lessonProvider.sessionList[index];
                              return _lessonWidget(session);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                _buildProgressIndicator()
                // Expanded(
                //   child: Consumer<LessonListApi>(
                //     builder: (context, lessonProvider, child) =>
                //         RefreshIndicator(
                //       child: ListView.builder(
                //         primary: false,
                //         shrinkWrap: true,
                //         controller: _controller,
                //         itemCount: lessonProvider.sessionList.length + 1,
                //         itemBuilder: (BuildContext context, int index) {
                //           final dashProvider =
                //               Provider.of<DashDetailsProvider>(context,
                //                   listen: false);
                //           if (lessonProvider.sessionList.length == 0 &&
                //               dashProvider
                //                       .dashDetails.subscriptionPlanLessons <=
                //                   dashProvider
                //                       .dashDetails.subscriptionLessons) {
                //             return _noLesson();
                //           } else if (index ==
                //               lessonProvider.sessionList.length) {
                //             return _buildProgressIndicator();
                //           } else {
                //             Sessionlist sessionInd =
                //                 lessonProvider.sessionList[index];
                //             return _lessonWidget(sessionInd);
                //           }
                //         },
                //       ),
                //       onRefresh: _getNewLessonList,
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    // return Container(
    //   padding: const EdgeInsets.all(8.0),
    //   child: Consumer<LessonListApi>(
    //     builder: (context, lessonState, child) => Opacity(
    //       opacity: lessonState.isFetchingLessons ? 1.0 : 0.0,
    //       child: CircularProgressIndicator(),
    //     ),
    //   ),
    // );
    final lessonProvider = Provider.of<LessonListApi>(context, listen: false);
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: lessonProvider.isFetchingLessons && !gettingNewLesson ? 50.0 : 0,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _lessonWidget(Sessionlist sess) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          color: Colors.grey[300],
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LessonStatus(
                lessonStatus: sess.status,
              ),
              Consumer<DashDetailsProvider>(
                builder: (context, dashProvider, child) {
                  return dashProvider.loadParams.type == "T"
                      ? CircleAvatar(
                          backgroundImage: "${sess.studentImage}".isEmpty
                              ? NetworkImage(
                                  'https://www.cdnjustlearn.com/image/intet-billede.jpg')
                              : NetworkImage(
                                  '${sess.studentImagePath}${sess.studentImage}'),
                          maxRadius: 45,
                        )
                      : CircleAvatar(
                          backgroundImage: "${sess.teacherImage}".isEmpty
                              ? NetworkImage(
                                  'https://www.cdnjustlearn.com/image/intet-billede.jpg')
                              : NetworkImage(
                                  '${sess.teacherImagePath}${sess.teacherImage}'),
                          maxRadius: 45,
                        );
                },
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Time',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'WorkSans',
                  ),
                ),
                Consumer<DashDetailsProvider>(
                  builder: (context, dashProvider, child) {
                    return dashProvider.loadParams.type == "T"
                        ? Text(
                            'Student',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'WorkSans',
                            ),
                          )
                        : Text(
                            'Teacher',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'WorkSans',
                            ),
                          );
                  },
                ),
              ],
            ),
          ),
          Divider(color: Colors.black),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: sess.status == 85
                      ? Text('-',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'WorkSans',
                          ))
                      : Text(
                          '${DateFormat.yMMMd().format(sess.startTime.toLocal())} | ${DateFormat.jm().format(sess.startTime.toLocal())}',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'WorkSans',
                          )),
                ),
                Expanded(child: Consumer<DashDetailsProvider>(
                  builder: (context, dashProvider, child) {
                    return dashProvider.loadParams.type == "T"
                        ? Text(
                            '${sess.studentName}',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'WorkSans',
                            ),
                          )
                        : Text(
                            '${sess.teacherName}',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'WorkSans',
                            ),
                          );
                  },
                )),
              ],
            ),
          ),
          LessonActionButton(
            sessions: sess,
          ),
        ],
      ),
    );
  }

  Widget _noLesson() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      height: MediaQuery.of(context).size.height * .5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Material(
            color: Color(0xFF3061cc),
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
            elevation: 5.0,
            child: MaterialButton(
              onPressed: () {
                final botnavState = Provider.of<BottomNavigationBarProvider>(
                    context,
                    listen: false);
                botnavState.currentIndex = 0;
                analytics.logEvent(
                  name: 'checkout_page',
                  parameters: null,
                );
                Navigator.pushNamed(context, StripeSubscriptionScreen.id);
              },
              minWidth: MediaQuery.of(context).size.width,
              height: 42.0,
              child: Text(
                'Buy Lesson',
                style: TextStyle(
                  fontFamily: 'WorkSans',
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Text('No lessons yet...', style: TextStyle(color: Colors.black54)),
          Material(
            color: Color(0xFF3061cc),
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
            elevation: 5.0,
            child: MaterialButton(
              onPressed: () {
                final botnavState = Provider.of<BottomNavigationBarProvider>(
                    context,
                    listen: false);
                botnavState.currentIndex = 0;
                Navigator.pushNamed(context, MenuScreen.id);
              },
              minWidth: 200.0,
              height: 42.0,
              child: Text(
                'Find Tutors',
                style: TextStyle(
                  fontFamily: 'WorkSans',
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
