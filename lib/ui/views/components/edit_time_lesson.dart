import 'package:flutter/material.dart';
import 'package:justlearn/business_logic/models/lessons/lessons_model.dart';
import 'package:justlearn/services/action_buttons/action_buttons.dart';
import 'package:justlearn/services/bottomnav_provider.dart';
import 'package:justlearn/services/calendar/calendar_provider.dart';
import 'package:justlearn/services/lessons/lessons_list_api.dart';
import 'package:justlearn/ui/views/screens/menu_screen.dart';
import 'package:provider/provider.dart';
import 'package:time_machine/time_machine.dart';
import 'package:timetable/timetable.dart';
import 'package:intl/intl.dart';

class EditTimeLesson extends StatefulWidget {
  static const String id = "edit_lesson_screen";
  final Sessionlist sessions;

  const EditTimeLesson({Key key, this.sessions}) : super(key: key);
  @override
  _EditTimeLessonState createState() => _EditTimeLessonState();
}

class _EditTimeLessonState extends State<EditTimeLesson> {
  TimetableController<BasicEvent> _controller;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _afterLayout(context));
    super.initState();
  }

  _afterLayout(BuildContext context) async {
    final editLessonState =
        Provider.of<ActionButtonsProvider>(context, listen: false);
    await editLessonState.loadParamsAsync;
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
          eventGetter: (range) => Stream.fromFuture(calendarState.loadCalendar(
              widget.sessions.teacherId, range.start))),

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
  Widget build(BuildContext context) {
    print("Calendar build");
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Book Time', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        brightness: Brightness.light,
      ),
      body: Consumer<CalendarProvider>(
        builder: (context, calendarProvider, child) => Timetable<BasicEvent>(
          controller: _controller,
          onEventBackgroundTap: (start, isAllDay) {},
          eventBuilder: (event) {
            return BasicEventWidget(
              event,
              onTap: () async {
                _showEventDate(widget.sessions.sessionId, event);
                print(event);
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

  Future<void> _showEventDate(int sessionId, BasicEvent event) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('Edit Book Lesson')),
          content: event.color == Colors.grey
              ? Container(
                  child: Text('Not Available'),
                )
              : Container(
                  height: MediaQuery.of(context).size.width * .5,
                  child: Column(
                    children: [
                      Text('Update your lesson schedule to:'),
                      SizedBox(
                        height: 20,
                      ),
                      Text('${DateFormat.yMMMd().format(event.start.toDateTimeLocal())}' + ' ${event.start}'.substring(11,20)),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text('To'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('${DateFormat.yMMMd().format(event.start.toDateTimeLocal())}' + ' ${event.start.addMinutes(30)}'.substring(11,20)),
                    ],
                  ),
                ),
          actions: [
            Center(
              child: FlatButton(
                child: Text(
                  'Close',
                  style: TextStyle(fontSize: 18.0),
                ),
                onPressed: () {
                  Navigator.pop(context, () {
                    setState(() {});
                  });
                },
              ),
            ),
            event.color == Colors.grey
                ? Container()
                : Center(
                    child: FlatButton(
                      child: Text(
                        'Confirm',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      onPressed: () async {
                        final editTimeProvider =
                            Provider.of<ActionButtonsProvider>(context,
                                listen: false);
                        final lessonState =
                            Provider.of<LessonListApi>(context, listen: false);
                        bool response = await editTimeProvider.editBookTimeApi(
                            sessionId, event);
                        if (response) {
                          print("success edit");
                          await lessonState.setListNull();
                          await lessonState.getLessonsList(lessonState.page);
                          final botnavState =
                              Provider.of<BottomNavigationBarProvider>(context,
                                  listen: false);
                          botnavState.currentIndex = 1;
                          Navigator.popAndPushNamed(context, MenuScreen.id);
                        }
                      },
                    ),
                  ),
          ],
        );
      },
    );
  }
}
