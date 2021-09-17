import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:justlearn/ui/views/screens/quiz/quiz_tab.dart';
import 'package:justlearn/ui/views/screens/quiz/stats_tab.dart';

class QuizHomeScreen extends StatefulWidget {
  static const String id = "quiz_home_screen";
  QuizHomeScreen({Key key}) : super(key: key);

  @override
  _QuizHomeState createState() => _QuizHomeState();
}

class _QuizHomeState extends State<QuizHomeScreen> {
  final String assetName = "assets/icon/puzzle.svg";

  @override
  Widget build(BuildContext context) {
    //  final Widget quizIcon = SvgPicture.asset(assetName, semanticsLabel: 'Quiz',);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                  icon: SvgPicture.asset(
                    assetName,
                    width: 20,
                    color: Colors.white,
                    semanticsLabel: 'Quiz',
                  ),
                  text: 'Quiz'),
              Tab(icon: Icon(Icons.stacked_bar_chart), text: 'Stats')
            ],
          ),
        ),
        body: TabBarView(
          children: [QuizTab(), StatsTab()],
        ),
      ),
    );
  }
}
