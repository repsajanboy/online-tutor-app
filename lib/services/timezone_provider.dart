import 'package:flutter/foundation.dart';
import 'package:justlearn/business_logic/models/timezone_list_model.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart';

class TimezoneProvider with ChangeNotifier {
  List<Timezone> timezoneList = [];

  loadTimezones() async {
    tz.initializeTimeZones();
    var locations = tz.timeZoneDatabase.locations;
    List<Timezone> tzones = List<Timezone>();
    locations.values.forEach((element) {
      var now = TZDateTime.now(element);
      var year = now.year;
      var month = now.month;
      var offsetTz = TZDateTime(element, year, month);
      var hours = offsetTz.timeZoneOffset.inHours > 0
          ? offsetTz.timeZoneOffset.inHours
          : 1;
      if (!offsetTz.timeZoneOffset.isNegative) {
        tzones.add(Timezone(
            name: element.name,
            timezone: '+' +
                offsetTz.timeZoneOffset.inHours.toString().padLeft(2, '0') +
                ':' +
                (offsetTz.timeZoneOffset.inMinutes % (hours * 60))
                    .toString()
                    .padLeft(2, '0')));
      } else {
        tzones.add(Timezone(
            name: element.name,
            timezone: '-' +
                offsetTz.timeZoneOffset.inHours
                    .abs()
                    .toString()
                    .padLeft(2, '0') +
                ':' +
                (offsetTz.timeZoneOffset.inMinutes % (hours * 60))
                    .toString()
                    .padLeft(2, '0')));
      }
      //tzones.add(Timezone(name: element.name, timezone: offsetTz.timeZoneOffset.inHours.toString() + ':' + offsetTz.timeZoneOffset.inMinutes % 60));
      //print(element.name + ' ' + offsetTz.timeZoneOffset.inHours.toString() + ':' + (offsetTz.timeZoneOffset.inMinutes % 60).toString());
    });
    timezoneList.addAll(tzones);
    notifyListeners();
  }

  //get loadTimezoneAsync => _loadTimezones();
}
