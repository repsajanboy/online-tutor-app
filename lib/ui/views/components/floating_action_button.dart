import 'package:flutter/material.dart';
import 'package:justlearn/ui/views/screens/lesson/lessons_screen.dart.txt';

class FloatButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Color(0xFF3061cc),
      child: Icon(
        Icons.playlist_play,
        color: Colors.white,
      ),
      onPressed: () => Navigator.pushNamed(
        context,
        LessonScreen.id,
      ),
    );
  }
}
