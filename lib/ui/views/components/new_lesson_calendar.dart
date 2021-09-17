import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:justlearn/services/action_buttons/action_buttons.dart';
import 'package:justlearn/services/bottomnav_provider.dart';
import 'package:justlearn/services/calendar/calendar_provider.dart';
import 'package:justlearn/services/dashboardDetails.dart/dash_details_provider.dart';
import 'package:justlearn/services/lessons/lessons_list_api.dart';
import 'package:justlearn/ui/views/screens/menu_screen.dart';
import 'package:justlearn/ui/views/screens/tutor/stripe_subscription_screen.dart';
import 'package:provider/provider.dart';
import 'package:time_machine/time_machine.dart';
import 'package:timetable/timetable.dart';
import 'package:intl/intl.dart';

class NewLessonCalender extends StatefulWidget {
  static const String id = "new_lesson_screen";
  final int teachersId;

  const NewLessonCalender({Key key, this.teachersId}) : super(key: key);

  @override
  _NewLessonCalenderState createState() => _NewLessonCalenderState();
}

class _NewLessonCalenderState extends State<NewLessonCalender> {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  TimetableController<BasicEvent> _controller;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    DateTime date = DateTime.now();
    int dayToday = date.weekday;
    var day = DayOfWeek(dayToday);
    final calendarState = Provider.of<CalendarProvider>(context, listen: false);
    _controller = TimetableController(
      // A basic EventProvider containing a single event:
      //eventProvider: EventProvider.list(_scheds),
      eventProvider: EventProvider.stream(
          eventGetter: (range) => Stream.fromFuture(
              calendarState.loadCalendar(widget.teachersId, range.start))),

      initialTimeRange: InitialTimeRange.range(
        startTime: LocalTime(0, 0, 0),
        endTime: LocalTime(08, 0, 0),
      ),
      initialDate: LocalDate.today(),
      visibleRange: VisibleRange.week(),
      firstDayOfWeek: day,
    );
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lessonState = Provider.of<LessonListApi>(context, listen: false);
    final dashProvider =
        Provider.of<DashDetailsProvider>(context, listen: false);
    print("Calendar build");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Book Time',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        brightness: Brightness.light,
      ),
      body: SafeArea(
        child: Timetable<BasicEvent>(
          controller: _controller,
          onEventBackgroundTap: (start, isAllDay) {},
          eventBuilder: (event) {
            return BasicEventWidget(
              event,
              onTap: () async {
                if (dashProvider.dashDetails.subscriptionStatus == 1 &&
                    dashProvider.dashDetails.subscriptionLessons == 0 &&
                    dashProvider.dashDetails.isTrialPeriod) {
                  final actionState = Provider.of<ActionButtonsProvider>(
                      context,
                      listen: false);
                  bool response = await actionState
                      .getMoreLessonTrial(int.parse(actionState.loadParams.id));
                  if (response) {
                    print('more-lesson-endtrial');
                    analytics.logEvent(
                      name: 'more_lesson-trial',
                      parameters: {
                        'plan': dashProvider.stripes.subPlanLessons,
                        'price': dashProvider.stripes.subPlanPrice,
                      },
                    );
                    await dashProvider.loadParamsAsync;
                    await dashProvider.loadDashDetails();
                    bool sucess = await _showEventDate(event);
                    if (sucess) {
                      await dashProvider.loadParamsAsync;
                      await dashProvider.loadDashDetails();
                      await lessonState.loadParamsAsync;
                      await lessonState.setListNull();
                      await lessonState.getLessonsList(lessonState.page);
                      final botnavState =
                          Provider.of<BottomNavigationBarProvider>(context,
                              listen: false);
                      botnavState.currentIndex = 1;
                      Navigator.popAndPushNamed(context, MenuScreen.id);
                    } else {
                      setState(() {});
                    }
                  }
                } else if (dashProvider.dashDetails.subscriptionLessons == 0 &&
                    dashProvider.dashDetails.subscriptionStatus == 1) {
                  print("charge for stripe");
                  final actionState = Provider.of<ActionButtonsProvider>(
                      context,
                      listen: false);
                  final dashProvider =
                      Provider.of<DashDetailsProvider>(context, listen: false);
                  bool response = await actionState
                      .getMoreLesson(dashProvider.stripes.subPlanLessons);
                  if (response) {
                    analytics.logEvent(
                      name: 'more_lesson',
                      parameters: {
                        'plan': dashProvider.stripes.subPlanLessons,
                        'price': dashProvider.stripes.subPlanPrice,
                      },
                    );
                    await dashProvider.loadParamsAsync;
                    await dashProvider.loadDashDetails();
                    bool sucess = await _showEventDate(event);
                    if (sucess) {
                      await dashProvider.loadParamsAsync;
                      await dashProvider.loadDashDetails();
                      await lessonState.loadParamsAsync;
                      await lessonState.setListNull();
                      await lessonState.getLessonsList(lessonState.page);
                      final botnavState =
                          Provider.of<BottomNavigationBarProvider>(context,
                              listen: false);
                      botnavState.currentIndex = 1;
                      Navigator.popAndPushNamed(context, MenuScreen.id);
                    } else {
                      setState(() {});
                    }
                    //Navigator.of(context).pop();
                  }
                } else if (dashProvider.dashDetails.subscriptionStatus == 1) {
                  bool sucess = await _showEventDate(event);
                  if (sucess) {
                    await dashProvider.loadParamsAsync;
                    await dashProvider.loadDashDetails();
                    await lessonState.loadParamsAsync;
                    await lessonState.setListNull();
                    await lessonState.getLessonsList(lessonState.page);
                    final botnavState =
                        Provider.of<BottomNavigationBarProvider>(context,
                            listen: false);
                    botnavState.currentIndex = 1;
                    Navigator.popAndPushNamed(context, MenuScreen.id);
                  } else {
                    setState(() {});
                  }
                } else {
                  analytics.logEvent(
                    name: 'checkout_page',
                    parameters: null,
                  );
                  Navigator.pushNamed(context, StripeSubscriptionScreen.id);
                }
              },
            );
          },
          allDayEventBuilder: (context, event, info) => BasicAllDayEventWidget(
            event,
            info: info,
            onTap: () {
              print('All-day event $event tapped');
            },
          ),
        ),
      ),
    );
  }

  Future<bool> _showEventDate(BasicEvent event) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        final newLessonState =
            Provider.of<ActionButtonsProvider>(context, listen: false);
        Widget _eventContent() {
          if (event.color == Colors.grey) {
            return Container(
              child: Text('Not Available'),
            );
          } else {
            return Container(
              child: Text(
                  '${DateFormat.yMMMd().format(event.start.toDateTimeLocal())}' +
                      ' ${event.start}'.substring(11, 20)),
            );
          }
        }

        List<Widget> _actionButtons() {
          return [
            Center(
              child: FlatButton(
                child: Text(
                  'Close',
                  style: TextStyle(fontSize: 18.0),
                ),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
            ),
            Center(
              child: FlatButton(
                child: Text(
                  'Confirm',
                  style: TextStyle(fontSize: 18.0),
                ),
                onPressed: () async {
                  final calendarState =
                      Provider.of<CalendarProvider>(context, listen: false);
                  await newLessonState.loadParamsAsync;
                  bool response = await newLessonState.bookLessonApi(
                      widget.teachersId, event);
                  if (response) {
                    analytics.logEvent(
                      name: 'lesson_booked',
                      parameters: null,
                    );
                    calendarState.loadCalendar(
                        widget.teachersId, LocalDate.today());
                    Navigator.pop(context, true);
                  }
                },
              ),
            ),
          ];
        }

        return AlertDialog(
            title: Center(child: Text('Book Lesson')),
            content: _eventContent(),
            actions: _actionButtons());
      },
    );
  }
}
