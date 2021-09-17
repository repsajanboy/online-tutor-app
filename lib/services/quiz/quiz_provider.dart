import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:justlearn/business_logic/models/quiz/stats_model.dart';

class QuizProvider extends ChangeNotifier {
  int _lose = 0;
  int _quizIndex = 0;
  int _score = 0;
  String _stats = "none";
  int _correctAnswer = 0;
  // bool _playedEnough = false;
  bool _showBadge = false;

  int get lose => _lose;
  int get quizIndex => _quizIndex;
  int get score => _score;
  String get stats => _stats;
  int get correctAnswer => _correctAnswer;
  // bool get playedEnough => _playedEnough;
  bool get showBadge => _showBadge;

  wrong() async {
    _correctAnswer = 0;
    _lose++;
    _quizIndex++;
    await updateStats();
    notifyListeners();
  }

  correct() async {
    _correctAnswer = 0;
    _score++;
    _quizIndex++;
    await updateStats();
    notifyListeners();
  }

  highlightCorrect(int correctAnswer) {
    _correctAnswer = correctAnswer;
    notifyListeners();
  }

  restartQuiz() {
    _quizIndex = 0;
    notifyListeners();
  }

  continueQuiz(int lastQuizIndex) {
    _quizIndex = lastQuizIndex;
  }

  Future updateStats() async {
    int correct = _score * 2;
    int wrong = _quizIndex - _score;
    double stat = (correct + wrong) / _quizIndex;

    // RemoteConfigService rcService = await RemoteConfigService.getInstance();
    //stat < 1.1
    if (stat < 1.1) {
      _stats = "A1";
    }
    //1.1 < stat < 1.3
    else if (stat > 1.1 && stat < 1.3) {
      _stats = "A2";
    }
    //1.3 < stat < 1.5
    else if (stat > 1.3 && stat < 1.4) {
      _stats = "B1";
      // notifyListeners();
    }
    //1.5 < stat < 1.6
    else if (stat > 1.5 && stat < 1.6) {
      _stats = "B2";
    }
    //1.6 < stat < 1.7
    else if (stat > 1.6 && stat < 1.7) {
      _stats = "C1";
    }
    //stat > 1.7
    else if (stat > 1.7) {
      _stats = "C2";
    }

    if (_quizIndex > 10) {
      saveStats();
    }
  }

  saveStats() {
    DateFormat format = DateFormat('yyyy-MM-dd');
    DateTime dateTime = DateTime.now();
    String now = format.format(dateTime);

    StatsModel statsModel =
        StatsModel(date: now, stats: _stats, answeredQuestions: _quizIndex);
    final statsBox = Hive.box('stats');
    StatsModel initStat =
        StatsModel(stats: "none", date: now, answeredQuestions: 0);
    final prevStats = statsBox.get(now, defaultValue: initStat) as StatsModel;
    checkStats(prevStats.stats, statsModel.stats, statsModel.answeredQuestions);
    statsBox.put(now, statsModel);
  }

  checkStats(String prevStats, String currentStats, int answeredQuestions) {
    print('prev stats: $prevStats');
    print('current stats: $currentStats');
    if (prevStats != currentStats && answeredQuestions > 10) {
      enableBadge();
    }
    print('show badge: $_showBadge');
  }

  enableBadge() {
    _showBadge = true;
    notifyListeners();
  }

  disableBadge() {
    _showBadge = false;
    notifyListeners();
  }
}
