import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:justlearn/business_logic/models/quiz/colors_model.dart';
import 'package:justlearn/business_logic/models/quiz/stats_model.dart';
import 'package:provider/provider.dart';

class StatsTab extends StatefulWidget {
  StatsTab({Key key}) : super(key: key);

  @override
  _StatsTabState createState() => _StatsTabState();
}

class _StatsTabState extends State<StatsTab> {
  DateFormat format = DateFormat('yyyy-MM-dd');
  DateTime dateTime = DateTime.now();
  String now;

  // Box<StatsModel> statsBox;

  @override
  void initState() {
    super.initState();
    now = format.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: ValueListenableBuilder(
          valueListenable: Hive.box('stats').listenable(keys: [now]),
          builder: (context, box, child) {
            // print(box.length);
            StatsModel initStat =
                StatsModel(stats: "none", date: now, answeredQuestions: 0);

            final todayStat =
                box.get(now, defaultValue: initStat) as StatsModel;
            return Consumer<ColorsModel>(
              builder: (context, cm, child) {
                return Container(
                  color: Color(cm.todayProfBg),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment(0, -0.70),
                        child: Container(
                          height: 150,
                          child: (todayStat.answeredQuestions < 9)
                              ? Text(
                                  'You need to answer at least 10 questions to view your stat',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black),
                                )
                              : Column(
                                  children: [
                                    Text(
                                      'TODAY',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      todayStat.stats,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 50.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: MediaQuery.of(context).size.height / 2,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30))),
                          child: Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: 10.0),
                                  padding: EdgeInsets.all(10.0),
                                  child: Text('Proficiency level history',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                              box.length < 2
                                  ? Container(
                                      padding: EdgeInsets.only(top: 30.0),
                                      child: Text(
                                          'You have no history of proficiency level yet'),
                                    )
                                  : Expanded(
                                      child: ListView.builder(
                                          itemCount: box.length,
                                          itemBuilder: (context, index) {
                                            final stat =
                                                box.getAt(index) as StatsModel;
                                            Widget _returnedWidget;
                                            if (stat.date != now) {
                                              _returnedWidget = Container(
                                                  padding: EdgeInsets.only(
                                                      left: 20.0),
                                                  margin: EdgeInsets.only(
                                                      top: 5, bottom: 5),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        stat.date,
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.grey),
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Text(
                                                        stat.stats,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20),
                                                      )
                                                    ],
                                                  ));
                                            }

                                            return _returnedWidget;
                                          }),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ));
  }
}
