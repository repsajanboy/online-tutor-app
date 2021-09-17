import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:justlearn/business_logic/models/lessons/lessons_model.dart';
import 'package:justlearn/services/action_buttons/action_buttons.dart';
import 'package:justlearn/services/dashboardDetails.dart/dash_details_provider.dart';
import 'package:justlearn/services/lessons/lessons_list_api.dart';
import 'package:justlearn/ui/views/components/edit_time_lesson.dart';
import 'package:justlearn/ui/views/components/new_lesson_calendar.dart';
import 'package:justlearn/ui/views/screens/lesson/view_screen.dart';
import 'package:provider/provider.dart';

class LessonActionButton extends StatefulWidget {
  final Sessionlist sessions;

  const LessonActionButton({Key key, this.sessions}) : super(key: key);

  @override
  _LessonActionButtonState createState() => _LessonActionButtonState();
}

class _LessonActionButtonState extends State<LessonActionButton> {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  @override
  void initState() {
    //WidgetsBinding.instance.addPostFrameCallback((_) => _afterLayout(context));
    super.initState();
  }

  // _afterLayout(BuildContext context) async {
  //   final cancelState =
  //       Provider.of<ActionButtonsProvider>(context, listen: false);
  //   await cancelState.loadParamsAsync;
  // }
  void showInfoFlushbar(BuildContext context, String message) {
    Flushbar(
      message: message,
      icon: Icon(
        Icons.info_outline,
        size: 28,
        color: Color(0xFF3061cc),
      ),
      leftBarIndicatorColor: Color(0xFF3061cc),
      duration: Duration(seconds: 5),
    )..show(context);
  }

  Future<void> _showCancelDialog() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          final actionProvider =
              Provider.of<ActionButtonsProvider>(context, listen: false);
          final lessonState =
              Provider.of<LessonListApi>(context, listen: false);
          final dashProvider =
              Provider.of<DashDetailsProvider>(context, listen: false);
          // final cancelState =
          //     Provider.of<ActionButtonsProvider>(context, listen: false);
          return AlertDialog(
            title: Center(child: Text('Cancel Lesson')),
            content: Consumer<ActionButtonsProvider>(
              builder: (context, actionState, child) => actionState.isLoading
                  ? Container(
                      height: MediaQuery.of(context).size.width * .5,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                'You are about to cancel the lesson.',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                            Text(
                              '• The lesson will be canceled.',
                            ),
                            Consumer<DashDetailsProvider>(
                              builder: (context, dashProvider, child) {
                                return dashProvider.loadParams.type == 'S'
                                    ? Text(
                                        '• ${widget.sessions.teacherName} will receive a message.',
                                      )
                                    : Text(
                                        '• ${widget.sessions.studentName} will receive a message.',
                                      );
                              },
                            ),
                            Text(
                              '• You will be refunded the amount of the lesson.',
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                'Are you sure that you want to cancel the lesson?',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ],
                        ),
                      ),
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
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Center(
                child: FlatButton(
                  child: Text(
                    'Cancel Lesson',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  onPressed: () async {
                    actionProvider.setIsLoading(true);
                    bool response = await actionProvider
                        .cancelLessonApi(widget.sessions.sessionId);
                    if (response) {
                      await lessonState.setListNull()();
                      await lessonState.getLessonsList(lessonState.page);
                      await dashProvider.loadParamsAsync;
                      await dashProvider.loadDashDetails();
                      actionProvider.setIsLoading(false);
                      Navigator.pop(context);
                      showInfoFlushbar(
                          context, "Lesson cancelled successfully.");
                    }
                  },
                ),
              ),
            ],
          );
        });
  }

  Future<void> _requestRefundDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        int _problemId = 0;
        final message = TextEditingController();
        final lessonState = Provider.of<LessonListApi>(context, listen: false);
        final dashProvider =
            Provider.of<DashDetailsProvider>(context, listen: false);
        return AlertDialog(
          title: Text('Request Refund'),
          content: Consumer<ActionButtonsProvider>(
            builder: (context, actionState, child) => actionState.isLoading
                ? Container(
                    height: MediaQuery.of(context).size.width * .5,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : StatefulBuilder(
                    builder: (BuildContext context, setState) {
                      return SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text('Type*'),
                              DropdownButton(
                                isExpanded: true,
                                value: _problemId,
                                items: [
                                  DropdownMenuItem(
                                    child: Text('Select Type'),
                                    value: 0,
                                  ),
                                  DropdownMenuItem(
                                    child:
                                        Text('Teacher did not attend lesson'),
                                    value: 1,
                                  ),
                                  DropdownMenuItem(
                                    child:
                                        Text('Student did not attend lesson'),
                                    value: 2,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Technical Problem'),
                                    value: 3,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Other'),
                                    value: 4,
                                  )
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    print(value);
                                    _problemId = value;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              Text(
                                'Describe the issue*',
                                style: TextStyle(color: Colors.black54),
                              ),
                              TextField(
                                controller: message,
                                keyboardType: TextInputType.multiline,
                                maxLines: 8,
                                decoration: new InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black54, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black54, width: 1.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          actions: [
            FlatButton(
              child: Text(
                'Close',
                style: TextStyle(fontSize: 18.0),
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: Colors.blue, width: 1, style: BorderStyle.solid),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Text(
                'Send',
                style: TextStyle(fontSize: 18.0),
              ),
              onPressed: () async {
                final actionState =
                    Provider.of<ActionButtonsProvider>(context, listen: false);
                actionState.setIsLoading(true);
                bool response = await actionState.requestRefundApi(
                    widget.sessions.sessionId, _problemId, message.text);
                if (response) {
                  await lessonState.setListNull();
                  await lessonState.getLessonsList(lessonState.page);
                  await dashProvider.loadParamsAsync;
                  await dashProvider.loadDashDetails();
                  actionState.setIsLoading(false);
                  Navigator.pop(context);
                  showInfoFlushbar(
                      context, "Your request for refund is being reviewed.");
                }
                print("Request refund");
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _sendReview() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          final review = TextEditingController();
          return AlertDialog(
            title: Center(child: Text('Feedback')),
            content: Consumer<ActionButtonsProvider>(
              builder: (context, actionState, child) => actionState.isLoading
                  ? Container(
                      height: MediaQuery.of(context).size.width * .5,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Container(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text('Feedback to teacher'),
                            Text('Skills'),
                            Text('Quality'),
                            Text('Materials'),
                            Text('Punctuality'),
                            Text('Communication'),
                            Text('Recommend'),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'Share details about the lesson',
                              style: TextStyle(color: Colors.black54),
                            ),
                            TextField(
                              onChanged: (value) {
                                actionState.setReviewValid(false);
                              },
                              controller: review,
                              keyboardType: TextInputType.multiline,
                              maxLines: 4,
                              decoration: new InputDecoration(
                                  errorText: actionState.isReviewValid
                                      ? "Please write a review."
                                      : null,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black54, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black54, width: 1.0),
                                  ),
                                  hintText:
                                      'Did you like the session? Can you recommend ${widget.sessions.teacherName}?'),
                            ),
                          ],
                        ),
                      ),
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
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Center(
                child: FlatButton(
                  child: Text(
                    'Send',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  onPressed: () async {
                    final actionState = Provider.of<ActionButtonsProvider>(
                        context,
                        listen: false);
                    if (review.text.isNotEmpty) {
                      actionState.setIsLoading(true);
                      bool response = await actionState.sendReview(
                          widget.sessions.sessionId, review.text);
                      if (response) {
                        actionState.setIsLoading(false);
                        Navigator.of(context).pop();
                        showInfoFlushbar(
                            context, "Thank you for sending your review. ");
                      } else {
                        actionState.setIsLoading(false);
                        Flushbar(
                          title: "Send Review",
                          message:
                              "Send review failed. Already write a feedback",
                          duration: Duration(seconds: 3),
                        ).show(context);
                      }
                    } else {
                      actionState.setReviewValid(true);
                    }
                    //Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          );
        });
  }

  Future<void> _sendRefundDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        int _solutionId = 4;
        final message = TextEditingController();
        final lessonState = Provider.of<LessonListApi>(context, listen: false);
        final dashProvider =
            Provider.of<DashDetailsProvider>(context, listen: false);
        Widget _issueWidget() {
          if (widget.sessions.problemId == 0) {
            return Container();
          } else if (widget.sessions.problemId == 1) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Isssue:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Teacher did not attend the lesson'),
                  Text(
                    'Description:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('${widget.sessions.problemMessage}')
                ],
              ),
            );
          } else if (widget.sessions.problemId == 2) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Isssue:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Student did not attend the lesson'),
                  Text(
                    'Description:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('${widget.sessions.problemMessage}')
                ],
              ),
            );
          } else if (widget.sessions.problemId == 3) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Isssue:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Technical Problem'),
                  Text(
                    'Description:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('${widget.sessions.problemMessage}')
                ],
              ),
            );
          } else if (widget.sessions.problemId == 4) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Isssue:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Other'),
                  Text(
                    'Description:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('${widget.sessions.problemMessage}')
                ],
              ),
            );
          }
          return Container();
        }

        return AlertDialog(
          title: Center(child: Text('Select Solution')),
          content: Consumer<ActionButtonsProvider>(
            builder: (context, actionState, child) => actionState.isLoading
                ? Container(
                    height: MediaQuery.of(context).size.width * .5,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : StatefulBuilder(
                    builder: (BuildContext context, setState) {
                      return SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _issueWidget(),
                              SizedBox(
                                height: 30.0,
                              ),
                              Text('Solution*'),
                              DropdownButton(
                                isExpanded: true,
                                value: _solutionId,
                                items: [
                                  DropdownMenuItem(
                                    child: Text('Add new lesson'),
                                    value: 1,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Mark as Completed'),
                                    value: 2,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Send Refund'),
                                    value: 4,
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    print(value);
                                    _solutionId = value;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'Message to student*',
                                style: TextStyle(color: Colors.black54),
                              ),
                              TextField(
                                controller: message,
                                keyboardType: TextInputType.multiline,
                                maxLines: 8,
                                decoration: new InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black54, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black54, width: 1.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          actions: [
            FlatButton(
              child: Text(
                'Close',
                style: TextStyle(fontSize: 18.0),
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: Colors.blue, width: 1, style: BorderStyle.solid),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Text(
                'Send',
                style: TextStyle(fontSize: 18.0),
              ),
              onPressed: () async {
                final actionState =
                    Provider.of<ActionButtonsProvider>(context, listen: false);
                actionState.setIsLoading(true);
                bool response = await actionState.sendRefundApi(
                    widget.sessions.sessionId, _solutionId, message.text);
                if (response) {
                  await lessonState.setListNull();
                  await lessonState.getLessonsList(lessonState.page);
                  await dashProvider.loadParamsAsync;
                  await dashProvider.loadDashDetails();
                  actionState.setIsLoading(false);
                  Navigator.of(context).pop();
                  showInfoFlushbar(context,
                      "You successfully send refund to ${widget.sessions.studentName}");
                }

                print("send refund");
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _markasCompleted() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        int _solutionId = 2;
        final message = TextEditingController();
        final lessonState = Provider.of<LessonListApi>(context, listen: false);
        final dashProvider =
            Provider.of<DashDetailsProvider>(context, listen: false);
        Widget _issueWidget() {
          if (widget.sessions.problemId == 0) {
            return Container();
          } else if (widget.sessions.problemId == 1) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Isssue:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Teacher did not attend the lesson'),
                  Text(
                    'Description:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('${widget.sessions.problemMessage}')
                ],
              ),
            );
          } else if (widget.sessions.problemId == 2) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Isssue:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Student did not attend the lesson'),
                  Text(
                    'Description:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('${widget.sessions.problemMessage}')
                ],
              ),
            );
          } else if (widget.sessions.problemId == 3) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Isssue:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Technical Problem'),
                  Text(
                    'Description:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('${widget.sessions.problemMessage}')
                ],
              ),
            );
          } else if (widget.sessions.problemId == 4) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Isssue:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Other'),
                  Text(
                    'Description:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('${widget.sessions.problemMessage}')
                ],
              ),
            );
          }
          return Container();
        }

        return AlertDialog(
          title: Center(child: Text('Select Solution')),
          content: Consumer<ActionButtonsProvider>(
            builder: (context, actionState, child) => actionState.isLoading
                ? Container(
                    height: MediaQuery.of(context).size.width * .5,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : StatefulBuilder(
                    builder: (BuildContext context, setState) {
                      return SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _issueWidget(),
                              SizedBox(
                                height: 30.0,
                              ),
                              Text('Solution*'),
                              DropdownButton(
                                value: _solutionId,
                                items: [
                                  DropdownMenuItem(
                                    child: Text('Add new lesson'),
                                    value: 1,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Mark as Completed'),
                                    value: 2,
                                  ),
                                  DropdownMenuItem(
                                    child: Text('Send Refund'),
                                    value: 4,
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    print(value);
                                    _solutionId = value;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'Message to student*',
                                style: TextStyle(color: Colors.black54),
                              ),
                              TextField(
                                controller: message,
                                keyboardType: TextInputType.multiline,
                                maxLines: 8,
                                decoration: new InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black54, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black54, width: 1.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          actions: [
            FlatButton(
              child: Text(
                'Close',
                style: TextStyle(fontSize: 18.0),
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: Colors.blue, width: 1, style: BorderStyle.solid),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Text(
                'Send',
                style: TextStyle(fontSize: 18.0),
              ),
              onPressed: () async {
                final actionState =
                    Provider.of<ActionButtonsProvider>(context, listen: false);
                actionState.setIsLoading(true);
                bool response = await actionState.markasCompletedApi(
                    widget.sessions.sessionId, _solutionId, message.text);
                if (response) {
                  await lessonState.setListNull();
                  await lessonState.getLessonsList(lessonState.page);
                  await dashProvider.loadParamsAsync;
                  await dashProvider.loadDashDetails();
                  actionState.setIsLoading(false);
                  Navigator.pop(context);
                  showInfoFlushbar(
                      context, "Lesson mark as completed successfully.");
                }
              },
            ),
          ],
        );
      },
    );
  }

  _navigateToView(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewLesson(
          sessions: widget.sessions,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dashProvider = Provider.of<DashDetailsProvider>(context);
    if (widget.sessions.status == 83 ||
        widget.sessions.status == 82 ||
        widget.sessions.status == 76) {
      if (dashProvider.loadParams.type == 'T') {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RaisedButton(
              color: Color(0xFF3061cc),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
                side: BorderSide(
                  color: Color(0xFF3061cc),
                ),
              ),
              onPressed: () {
                _navigateToView(context);
              },
              child: Text(
                'View',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold),
              ),
            ),
            RaisedButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  side: BorderSide(color: Colors.white)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditTimeLesson(
                      sessions: widget.sessions,
                    ),
                  ),
                );
              },
              child: Text(
                'Edit Time',
                style: TextStyle(
                    color: Color(0xFF3061cc),
                    fontSize: 16,
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold),
              ),
            ),
            RaisedButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  side: BorderSide(color: Colors.white)),
              onPressed: () {
                print("clicked");
                _showCancelDialog();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                    color: Color(0xFF3061cc),
                    fontSize: 16,
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RaisedButton(
              color: Color(0xFF3061cc),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
                side: BorderSide(
                  color: Color(0xFF3061cc),
                ),
              ),
              onPressed: () {
                _navigateToView(context);
              },
              child: Text(
                'View',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold),
              ),
            ),
            RaisedButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  side: BorderSide(color: Colors.white)),
              onPressed: () async {
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewLessonCalender(
                            teachersId: widget.sessions.teacherId),
                      ),
                    );
                  }
                } else if (dashProvider.dashDetails.subscriptionLessons == 0 &&
                    dashProvider.stripes.subStatus == 1 &&
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewLessonCalender(
                            teachersId: widget.sessions.teacherId),
                      ),
                    );
                  }
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewLessonCalender(
                          teachersId: widget.sessions.teacherId),
                    ),
                  );
                }
              },
              child: Consumer<ActionButtonsProvider>(
                builder: (context, actionState, child) =>
                    actionState.isMoreLessonLoads
                        ? Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Text(
                            'New Lesson',
                            style: TextStyle(
                                color: Color(0xFF3061cc),
                                fontSize: 16,
                                fontFamily: 'WorkSans',
                                fontWeight: FontWeight.bold),
                          ),
              ),
            ),
            RaisedButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  side: BorderSide(color: Colors.white)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditTimeLesson(
                      sessions: widget.sessions,
                    ),
                  ),
                );
              },
              child: Text(
                'Edit Time',
                style: TextStyle(
                    color: Color(0xFF3061cc),
                    fontSize: 16,
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold),
              ),
            ),
            RaisedButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  side: BorderSide(color: Colors.white)),
              onPressed: () {
                print("clicked");
                _showCancelDialog();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                    color: Color(0xFF3061cc),
                    fontSize: 16,
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      }
    } else if (widget.sessions.status == 85) {
      if (dashProvider.loadParams.type == 'T') {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RaisedButton(
              color: Color(0xFF3061cc),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
                side: BorderSide(
                  color: Color(0xFF3061cc),
                ),
              ),
              onPressed: () {
                _navigateToView(context);
              },
              child: Text(
                'View',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold),
              ),
            ),
            RaisedButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  side: BorderSide(color: Colors.white)),
              onPressed: () {
                print("clicked");
                _showCancelDialog();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                    color: Color(0xFF3061cc),
                    fontSize: 16,
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RaisedButton(
              color: Color(0xFF3061cc),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
                side: BorderSide(
                  color: Color(0xFF3061cc),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditTimeLesson(
                      sessions: widget.sessions,
                    ),
                  ),
                );
              },
              child: Text(
                'Book Time',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold),
              ),
            ),
            RaisedButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  side: BorderSide(color: Colors.white)),
              onPressed: () async {
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewLessonCalender(
                            teachersId: widget.sessions.teacherId),
                      ),
                    );
                  }
                } else if (dashProvider.dashDetails.subscriptionLessons == 0 &&
                    dashProvider.stripes.subStatus == 1 &&
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewLessonCalender(
                            teachersId: widget.sessions.teacherId),
                      ),
                    );
                  }
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewLessonCalender(
                          teachersId: widget.sessions.teacherId),
                    ),
                  );
                }
              },
              child: Consumer<ActionButtonsProvider>(
                builder: (context, actionState, child) =>
                    actionState.isMoreLessonLoads
                        ? Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Text(
                            'New Lesson',
                            style: TextStyle(
                                color: Color(0xFF3061cc),
                                fontSize: 16,
                                fontFamily: 'WorkSans',
                                fontWeight: FontWeight.bold),
                          ),
              ),
            ),
            RaisedButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  side: BorderSide(color: Colors.white)),
              onPressed: () {
                _showCancelDialog();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                    color: Color(0xFF3061cc),
                    fontSize: 16,
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      }
    } else if (widget.sessions.status == 67) {
      if (dashProvider.loadParams.type == 'T') {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RaisedButton(
              color: Color(0xFF3061cc),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
                side: BorderSide(
                  color: Color(0xFF3061cc),
                ),
              ),
              onPressed: () {
                _navigateToView(context);
              },
              child: Text(
                'View',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RaisedButton(
              color: Color(0xFF3061cc),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
                side: BorderSide(
                  color: Color(0xFF3061cc),
                ),
              ),
              onPressed: () {
                _navigateToView(context);
              },
              child: Text(
                'View',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold),
              ),
            ),
            RaisedButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  side: BorderSide(color: Colors.white)),
              onPressed: () async {
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewLessonCalender(
                            teachersId: widget.sessions.teacherId),
                      ),
                    );
                  }
                } else if (dashProvider.dashDetails.subscriptionLessons == 0 &&
                    dashProvider.stripes.subStatus == 1 &&
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewLessonCalender(
                            teachersId: widget.sessions.teacherId),
                      ),
                    );
                  }
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewLessonCalender(
                          teachersId: widget.sessions.teacherId),
                    ),
                  );
                }
              },
              child: Consumer<ActionButtonsProvider>(
                builder: (context, actionState, child) =>
                    actionState.isMoreLessonLoads
                        ? Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Text(
                            'New Lesson',
                            style: TextStyle(
                                color: Color(0xFF3061cc),
                                fontSize: 16,
                                fontFamily: 'WorkSans',
                                fontWeight: FontWeight.bold),
                          ),
              ),
            ),
          ],
        );
      }
    } else if (widget.sessions.status == 73) {
      if (dashProvider.loadParams.type == 'T') {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RaisedButton(
              color: Color(0xFF3061cc),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
                side: BorderSide(
                  color: Color(0xFF3061cc),
                ),
              ),
              onPressed: () {
                _navigateToView(context);
              },
              child: Text(
                'View',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold),
              ),
            ),
            RaisedButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  side: BorderSide(color: Colors.white)),
              onPressed: () {
                _markasCompleted();
              },
              child: Text(
                'Mark as Completed',
                style: TextStyle(
                    color: Color(0xFF3061cc),
                    fontSize: 16,
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold),
              ),
            ),
            RaisedButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  side: BorderSide(color: Colors.white)),
              onPressed: () {
                _sendRefundDialog();
              },
              child: Text(
                'Send Refund',
                style: TextStyle(
                    color: Color(0xFF3061cc),
                    fontSize: 16,
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RaisedButton(
              color: Color(0xFF3061cc),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
                side: BorderSide(
                  color: Color(0xFF3061cc),
                ),
              ),
              onPressed: () {
                _navigateToView(context);
              },
              child: Text(
                'View',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold),
              ),
            ),
            RaisedButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  side: BorderSide(color: Colors.white)),
              onPressed: () async {
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewLessonCalender(
                            teachersId: widget.sessions.teacherId),
                      ),
                    );
                  }
                } else if (dashProvider.dashDetails.subscriptionLessons == 0 &&
                    dashProvider.stripes.subStatus == 1 &&
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewLessonCalender(
                            teachersId: widget.sessions.teacherId),
                      ),
                    );
                  }
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewLessonCalender(
                          teachersId: widget.sessions.teacherId),
                    ),
                  );
                }
              },
              child: Consumer<ActionButtonsProvider>(
                builder: (context, actionState, child) =>
                    actionState.isMoreLessonLoads
                        ? Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Text(
                            'New Lesson',
                            style: TextStyle(
                                color: Color(0xFF3061cc),
                                fontSize: 16,
                                fontFamily: 'WorkSans',
                                fontWeight: FontWeight.bold),
                          ),
              ),
            ),
            RaisedButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  side: BorderSide(color: Colors.white)),
              onPressed: () {
                _requestRefundDialog();
              },
              child: Text(
                'Request Refund',
                style: TextStyle(
                    color: Color(0xFF3061cc),
                    fontSize: 16,
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      }
    } else if (widget.sessions.status == 80 || widget.sessions.status == 77) {
      if (dashProvider.loadParams.type == 'T') {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RaisedButton(
              color: Color(0xFF3061cc),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
                side: BorderSide(
                  color: Color(0xFF3061cc),
                ),
              ),
              onPressed: () {
                _navigateToView(context);
              },
              child: Text(
                'View',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold),
              ),
            ),
            RaisedButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  side: BorderSide(color: Colors.white)),
              onPressed: () {
                _markasCompleted();
              },
              child: Text(
                'Mark as Completed',
                style: TextStyle(
                    color: Color(0xFF3061cc),
                    fontSize: 16,
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold),
              ),
            ),
            RaisedButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  side: BorderSide(color: Colors.white)),
              onPressed: () {
                _sendRefundDialog();
              },
              child: Text(
                'Send Refund',
                style: TextStyle(
                    color: Color(0xFF3061cc),
                    fontSize: 16,
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RaisedButton(
              color: Color(0xFF3061cc),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
                side: BorderSide(
                  color: Color(0xFF3061cc),
                ),
              ),
              onPressed: () {
                _navigateToView(context);
              },
              child: Text(
                'View',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold),
              ),
            ),
            RaisedButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  side: BorderSide(color: Colors.white)),
              onPressed: () async {
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewLessonCalender(
                            teachersId: widget.sessions.teacherId),
                      ),
                    );
                  }
                } else if (dashProvider.dashDetails.subscriptionLessons == 0 &&
                    dashProvider.stripes.subStatus == 1 &&
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewLessonCalender(
                            teachersId: widget.sessions.teacherId),
                      ),
                    );
                  }
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewLessonCalender(
                          teachersId: widget.sessions.teacherId),
                    ),
                  );
                }
              },
              child: Consumer<ActionButtonsProvider>(
                builder: (context, actionState, child) =>
                    actionState.isMoreLessonLoads
                        ? Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Text(
                            'New Lesson',
                            style: TextStyle(
                                color: Color(0xFF3061cc),
                                fontSize: 16,
                                fontFamily: 'WorkSans',
                                fontWeight: FontWeight.bold),
                          ),
              ),
            ),
          ],
        );
      }
    } else if (widget.sessions.status == 70 || widget.sessions.status == 68) {
      if (dashProvider.loadParams.type == 'T') {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RaisedButton(
              color: Color(0xFF3061cc),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
                side: BorderSide(
                  color: Color(0xFF3061cc),
                ),
              ),
              onPressed: () {
                _navigateToView(context);
              },
              child: Text(
                'View',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RaisedButton(
              color: Color(0xFF3061cc),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
                side: BorderSide(
                  color: Color(0xFF3061cc),
                ),
              ),
              onPressed: () {
                _navigateToView(context);
              },
              child: Text(
                'View',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold),
              ),
            ),
            RaisedButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  side: BorderSide(color: Colors.white)),
              onPressed: () async {
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewLessonCalender(
                            teachersId: widget.sessions.teacherId),
                      ),
                    );
                  }
                } else if (dashProvider.dashDetails.subscriptionLessons == 0 &&
                    dashProvider.stripes.subStatus == 1 &&
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewLessonCalender(
                            teachersId: widget.sessions.teacherId),
                      ),
                    );
                  }
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewLessonCalender(
                          teachersId: widget.sessions.teacherId),
                    ),
                  );
                }
              },
              child: Consumer<ActionButtonsProvider>(
                builder: (context, actionState, child) =>
                    actionState.isMoreLessonLoads
                        ? Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Text(
                            'New Lesson',
                            style: TextStyle(
                                color: Color(0xFF3061cc),
                                fontSize: 16,
                                fontFamily: 'WorkSans',
                                fontWeight: FontWeight.bold),
                          ),
              ),
            ),
            RaisedButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  side: BorderSide(color: Colors.white)),
              onPressed: () async {
                _sendReview();
              },
              child: Text(
                'Review',
                style: TextStyle(
                    color: Color(0xFF3061cc),
                    fontSize: 16,
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      }
    } else if (widget.sessions.status == 69) {
      if (dashProvider.loadParams.type == 'T') {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RaisedButton(
              color: Color(0xFF3061cc),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
                side: BorderSide(
                  color: Color(0xFF3061cc),
                ),
              ),
              onPressed: () {
                _navigateToView(context);
              },
              child: Text(
                'View',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RaisedButton(
              color: Color(0xFF3061cc),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
                side: BorderSide(
                  color: Color(0xFF3061cc),
                ),
              ),
              onPressed: () {
                _navigateToView(context);
              },
              child: Text(
                'View',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold),
              ),
            ),
            RaisedButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  side: BorderSide(color: Colors.white)),
              onPressed: () async {
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewLessonCalender(
                            teachersId: widget.sessions.teacherId),
                      ),
                    );
                  }
                } else if (dashProvider.dashDetails.subscriptionLessons == 0 &&
                    dashProvider.stripes.subStatus == 1 &&
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewLessonCalender(
                            teachersId: widget.sessions.teacherId),
                      ),
                    );
                  }
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewLessonCalender(
                          teachersId: widget.sessions.teacherId),
                    ),
                  );
                }
              },
              child: Consumer<ActionButtonsProvider>(
                builder: (context, actionState, child) =>
                    actionState.isMoreLessonLoads
                        ? Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Text(
                            'New Lesson',
                            style: TextStyle(
                                color: Color(0xFF3061cc),
                                fontSize: 16,
                                fontFamily: 'WorkSans',
                                fontWeight: FontWeight.bold),
                          ),
              ),
            ),
          ],
        );
      }
    } else if (widget.sessions.status == 88) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RaisedButton(
            color: Color(0xFF3061cc),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
              side: BorderSide(
                color: Color(0xFF3061cc),
              ),
            ),
            onPressed: () {
              _navigateToView(context);
            },
            child: Text(
              'View',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'WorkSans',
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    }
    return Container();
  }
}
