import 'package:hive/hive.dart';

part 'stats_model.g.dart';

@HiveType(typeId: 0)
class StatsModel extends HiveObject {
  @HiveField(0)
  String stats;
  @HiveField(1)
  String date;
  @HiveField(2)
  int answeredQuestions;

  StatsModel({this.stats, this.date, this.answeredQuestions});
}
