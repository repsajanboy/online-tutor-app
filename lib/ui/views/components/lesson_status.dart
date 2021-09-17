import 'package:flutter/material.dart';

class LessonStatus extends StatelessWidget {
  final int lessonStatus;

  const LessonStatus({Key key, this.lessonStatus}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (lessonStatus == 83 || lessonStatus == 82 || lessonStatus == 76) {
      return FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.orange)),
          onPressed: () {},
          child: Text('Upcoming', style: TextStyle(color: Colors.orange)));
    } else if (lessonStatus == 85) {
      return FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.green)),
          onPressed: () {},
          child: Text('Unscheduled', style: TextStyle(color: Colors.green)));
    } else if (lessonStatus == 73) {
      return FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.brown)),
          onPressed: () {},
          child: Text('Incomplete', style: TextStyle(color: Colors.brown)));
    }
    else if (lessonStatus == 67) {
      return FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.redAccent[400])),
          onPressed: () {},
          child: Text('Canceled', style: TextStyle(color: Colors.redAccent[400])));
    }
    else if (lessonStatus == 80 || lessonStatus == 77) {
      return FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.lightGreen)),
          onPressed: () {},
          child: Text('Issue', style: TextStyle(color: Colors.lightGreen)));
    }
    else if (lessonStatus == 70 || lessonStatus == 68) {
      return FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.green)),
          onPressed: () {},
          child: Text('Completed', style: TextStyle(color: Colors.green)));
    }
    else if (lessonStatus == 69) {
      return FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.green)),
          onPressed: () {},
          child: Text('Refunded', style: TextStyle(color: Colors.green)));
    }
    else if (lessonStatus == 88) {
      return FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.brown)),
          onPressed: () {},
          child: Text('Expired', style: TextStyle(color: Colors.brown)));
    }
    else{
      return FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.blue)),
          onPressed: () {},
          child: Text('Status', style: TextStyle(color: Colors.blue)));
    }
  }
}
