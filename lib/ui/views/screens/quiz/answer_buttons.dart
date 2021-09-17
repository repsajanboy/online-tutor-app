import 'package:flutter/material.dart';
import 'package:justlearn/business_logic/models/quiz/colors_model.dart';
import 'package:provider/provider.dart';

class AnswerButtons extends StatelessWidget {
  AnswerButtons(
      {this.choices, this.choose, this.buttonFontSize, this.highlightedButton});

  final dynamic choices;
  final Function choose;
  final double buttonFontSize;
  final int highlightedButton;

  Widget choiceButton(
      int choice, Color color, bool highlighted, BuildContext ctx) {
    return GestureDetector(
      onTap: () {
        choose(choice, ctx);
      },
      child: Consumer<ColorsModel>(
        builder: (context, cm, child) {
          return Container(
            alignment: Alignment(0.0, 0.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border.all(
                  color: highlighted ? Color(cm.caHighlight) : color,
                  width: 5.0),
              borderRadius: BorderRadius.circular(8.0),
              color: color,
            ),
            child: Text(
              choices['choices' + choice.toString()],
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: buttonFontSize,
                  fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      height: MediaQuery.of(context).size.height / 3,
      child: Consumer<ColorsModel>(builder: (context, cm, child) {
        Widget _child;
        if (cm != null) {
          _child = Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: choiceButton(
                          1,
                          Color(cm.choices.choice1),
                          highlightedButton == 1,
                          context,
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: choiceButton(
                          2,
                          Color(cm.choices.choice2),
                          highlightedButton == 2,
                          context,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Expanded(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(
                          child: choiceButton(
                        3,
                        Color(cm.choices.choice3),
                        highlightedButton == 3,
                        context,
                      )),
                      SizedBox(width: 10.0),
                      Expanded(
                          child: choiceButton(
                        4,
                        Color(cm.choices.choice4),
                        highlightedButton == 4,
                        context,
                      )),
                    ],
                  ),
                ),
              )
            ],
          );
        } else {
          _child = SizedBox();
        }
        return _child;
      }),
    );
  }
}
