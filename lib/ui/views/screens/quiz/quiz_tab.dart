import 'dart:convert';
import 'dart:async';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:justlearn/services/quiz/answer_state.dart';
import 'package:justlearn/services/quiz/quiz_provider.dart';
import 'package:justlearn/ui/views/screens/quiz/answer_buttons.dart';
import 'package:justlearn/ui/views/screens/quiz/quiz_end.dart';
import 'package:provider/provider.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class QuizTab extends StatefulWidget {
  QuizTab({Key key}) : super(key: key);

  @override
  _QuizTabState createState() => _QuizTabState();
}

class _QuizTabState extends State<QuizTab>
    with AutomaticKeepAliveClientMixin<QuizTab> {
  int _counter = 10;
  dynamic _quizData;
  CountDownController _controller = CountDownController();

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          // margin: const EdgeInsets.only(top:20.0),
          child: FutureBuilder(
            future: DefaultAssetBundle.of(context)
                .loadString('assets/quizzes/english_quiz.json'),
            builder: (context, snapshot) {
              int quizIndex =
                  Provider.of<QuizProvider>(context, listen: true).quizIndex;
              _quizData = jsonDecode(snapshot.data.toString());

              if (_quizData != null && _quizData.length > quizIndex) {
                return Container(
                  alignment: Alignment(0.0, 0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      // SizedBox(height: 20.0),
                      Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          height: 130.0,
                          child: CircularCountDownTimer(
                            duration: _counter,
                            controller: _controller,
                            color: Colors.white,
                            fillColor: Colors.red,
                            backgroundColor: Colors.transparent,
                            width: MediaQuery.of(context).size.width / 2,
                            height: MediaQuery.of(context).size.height / 2,
                            textStyle: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            isReverse: true,
                            isReverseAnimation: true,
                            strokeWidth: 5.0,
                            onComplete: () {
                              showFlushBar(context, AnswerState.timeComplete);
                              _controller.pause();
                              var vm = Provider.of<QuizProvider>(context,
                                  listen: false);
                              int correctAnswer =
                                  _quizData[quizIndex]['answer'];
                              vm.highlightCorrect(correctAnswer);

                              Timer(Duration(seconds: 2), () {
                                vm.wrong();

                                // if (Provider.of<QuizProvider>(context,
                                //                     listen: false)
                                //                 .lose %
                                //             _interstitialAdFrequency ==
                                //         0 &&
                                //     _isInterstitialAdReady) {
                                //   _interstitialAd.show();
                                // } else {
                                //   _controller.restart();
                                // }
                                _controller.restart();
                              });
                            },
                          )),
                      SizedBox(height: 45.0),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                        child: Text(
                          _quizData[quizIndex]['question'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      AnswerButtons(
                        choices: _quizData[quizIndex],
                        choose: choose,
                        buttonFontSize: 20.0,
                        highlightedButton:
                            Provider.of<QuizProvider>(context, listen: true)
                                .correctAnswer,
                      )
                    ],
                  ),
                );
              } else if (_quizData != null && _quizData.length <= quizIndex) {
                // _bannerAd.dispose();
                return EndQuiz();
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }

  void showFlushBar(BuildContext ctx, AnswerState answerState) {
    Flushbar(
      messageText: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            answerState == AnswerState.correct ? Icons.check : Icons.close,
            color: Colors.white,
            size: 20.0,
          ),
          SizedBox(width: 10.0),
          Text(
            answerState == AnswerState.correct
                ? "CORRECT"
                : answerState == AnswerState.wrong
                    ? "INCORRECT"
                    : "TIME IS UP",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'BalsamiqSans-Bold',
                fontSize: 15.0),
          ),
        ],
      ),
      duration: Duration(seconds: 1),
      flushbarPosition: FlushbarPosition.BOTTOM,
      backgroundColor:
          answerState == AnswerState.correct ? Color(0xFF199728) : Colors.red,
    )..show(ctx);
  }

  void choose(int choice, BuildContext ctx) {
    int quizIndex = Provider.of<QuizProvider>(context, listen: false).quizIndex;
    int correctAnswer = _quizData[quizIndex]['answer'];
    AnswerState answer =
        choice == correctAnswer ? AnswerState.correct : AnswerState.wrong;
    _controller.pause();
    showFlushBar(ctx, answer);
    Provider.of<QuizProvider>(context, listen: false)
        .highlightCorrect(correctAnswer);

    Timer(Duration(seconds: 2), () {
      if (answer == AnswerState.wrong) {
        Provider.of<QuizProvider>(context, listen: false).wrong();
        // if (Provider.of<QuizProvider>(context, listen: false).lose %
        //             _interstitialAdFrequency ==
        //         0 &&
        //     _isInterstitialAdReady) {
        //   _interstitialAd.show();
        // } else {
        //   _controller.restart();
        // }
        _controller.restart();
      } else {
        Provider.of<QuizProvider>(context, listen: false).correct();
        _controller.restart();
      }
    });
  }
}
