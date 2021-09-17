import 'package:flutter/material.dart';
import 'package:justlearn/business_logic/models/quiz/colors_model.dart';
import 'package:justlearn/services/quiz/quiz_provider.dart';
import 'package:provider/provider.dart';

class EndQuiz extends StatefulWidget {
  EndQuiz({Key key}) : super(key: key);

  @override
  _EndQuizState createState() => _EndQuizState();
}

class _EndQuizState extends State<EndQuiz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F3F3),
      body: Container(
          padding: EdgeInsets.all(15.0),
          alignment: Alignment(0.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Come back later for more questions!',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
              Consumer<ColorsModel>(builder: (context, cm, child) {
                return Container(
                  margin: EdgeInsets.only(top: 25.0),
                  decoration: BoxDecoration(
                      color: Color(cm.restartButton),
                      borderRadius: BorderRadius.circular(5)),
                  child: FlatButton(
                    onPressed: () {
                      Provider.of<QuizProvider>(context, listen: false)
                          .restartQuiz();
                    },
                    child: Text(
                      'Restart Quiz',
                      style: TextStyle(
                          fontSize: 18.0,
                          letterSpacing: 1.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              })
            ],
          )),
    );
  }
}
