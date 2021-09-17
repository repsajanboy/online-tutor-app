import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:intl/intl.dart';
import 'package:justlearn/business_logic/models/auth/params_model.dart';
import 'package:justlearn/business_logic/models/calendar/tutors_sched_model.dart';
import 'package:justlearn/business_logic/models/utils/networking.dart';
import 'package:justlearn/services/shared_preference.dart';
import 'package:time_machine/time_machine.dart';
import 'package:timetable/timetable.dart';
import 'package:http/http.dart' as http;

class CalendarProvider with ChangeNotifier {
  TutorsSched tutorSched;
  Data tutorsData;
  ParamsResponse loadParams = ParamsResponse();
  List<SlotList> slotList0 = [];
  List<SlotList> slotList1 = [];
  List<SlotList> slotList2 = [];
  List<SlotList> slotList3 = [];
  List<SlotList> slotList4 = [];
  List<SlotList> slotList5 = [];
  List<SlotList> slotList6 = [];
  List<BasicEvent> scheds = [];
  List<BasicEvent> _schedd = [];
  String _icon = "📅";

  String _timezoneInfo = "";
  String _timezone = "";

  var url = "";

  get loadParamsAsync => _loadParams();

  _loadParams() async {
    try {
      ParamsResponse params =
          ParamsResponse.fromJson(await SharedPref().read("params"));
      loadParams = params;
      print('loaded');
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<Iterable<BasicEvent>> loadCalendar(int regId, LocalDate today) async {
    await _loadParams();
    _setToNull();
    bool checkExist = await SharedPref().isExisting('isLogin');
    if (!checkExist) {
      print('not login calendar');
      var nDate = today.toDateTimeUnspecified();
      var dateFrom = new DateFormat('yMd').format(nDate);
      String localTimezone;
      String localTZ;
      var hours = DateTime.now().timeZoneOffset.inHours;
      var minutes = DateTime.now().timeZoneOffset.inMinutes;
      var dateUtc =
          DateTime.now().timeZoneOffset.inHours.toString().padLeft(2, '0');
      var negative = DateTime.now().timeZoneOffset.inHours.isNegative;
      var min = (minutes % (hours * 60)).toString().padRight(2, '0');
      localTimezone = await FlutterNativeTimezone.getLocalTimezone();
      // print(minutes);
      // print(min);

      if (negative == false) {
        localTZ = "+" + "$dateUtc" + ":" + "$min";
        // print(localTZ);
        _timezoneInfo = localTimezone;
        _timezone = localTZ;
        notifyListeners();
      } else {
        localTZ = "-" + "$dateUtc" + ":" + "$min";
        _timezoneInfo = localTimezone;
        _timezone = localTZ;
        notifyListeners();
      }
      url = NetworkHelper.baseUrl +
          "api/tutor-calendar?zone=$_timezone&timezoneinfo=$_timezoneInfo&userregistrationid=${regId.toString()}&from=$dateFrom";
    } else {
      print('users login');
      var nDate = today.toDateTimeUnspecified();
      var dateFrom = new DateFormat('yMd').format(nDate);
      url = NetworkHelper.baseUrl +
          "api/tutor-calendar?zone=${loadParams.timezone}&timezoneinfo=${loadParams.timezoneinfo}&userregistrationid=${regId.toString()}&from=$dateFrom&studentid=${loadParams.id}";
      notifyListeners();
    }

    final response = await http.get(url);
    if (response.statusCode == 200) {
      _setToNull();
      final result = TutorsSched.fromJson(json.decode(response.body));
      tutorsData = result.data;
      slotList0 = tutorsData.slotList0;
      slotList1 = tutorsData.slotList1;
      slotList2 = tutorsData.slotList2;
      slotList3 = tutorsData.slotList3;
      slotList4 = tutorsData.slotList4;
      slotList5 = tutorsData.slotList5;
      slotList6 = tutorsData.slotList6;
      notifyListeners();
      for (int i = 0; i < slotList0.length; i++) {
        var sched = BasicEvent(
          id: "slot0-$i",
          title: _icon,
          color: slotList0[i].status == 1 ? Colors.green : Colors.grey,
          start: LocalDate(
            int.parse(DateFormat.y().format(slotList0[i].start.toLocal())),
            int.parse(DateFormat.M().format(slotList0[i].start.toLocal())),
            int.parse(DateFormat.d().format(slotList0[i].start.toLocal())),
          ).at(LocalTime(
              int.parse(DateFormat.H().format(slotList0[i].start.toLocal())),
              int.parse(DateFormat.m().format(slotList0[i].start.toLocal())),
              int.parse(DateFormat.s().format(slotList0[i].start.toLocal())))),
          end: LocalDate(
                  int.parse(
                      DateFormat.y().format(slotList0[i].start.toLocal())),
                  int.parse(
                      DateFormat.M().format(slotList0[i].start.toLocal())),
                  int.parse(
                      DateFormat.d().format(slotList0[i].start.toLocal())))
              .at(LocalTime(
                  int.parse(
                      DateFormat.H().format(slotList0[i].start.toLocal())),
                  int.parse(
                      DateFormat.m().format(slotList0[i].start.toLocal())),
                  int.parse(
                      DateFormat.s().format(slotList0[i].start.toLocal())))),
        );
        _schedd.add(sched);
      }
      for (int i = 0; i < slotList1.length; i++) {
        var sched1 = BasicEvent(
          id: "slot1-$i",
          title: _icon,
          color: slotList1[i].status == 1 ? Colors.green : Colors.grey,
          start: LocalDate(
                  int.parse(
                      DateFormat.y().format(slotList1[i].start.toLocal())),
                  int.parse(
                      DateFormat.M().format(slotList1[i].start.toLocal())),
                  int.parse(
                      DateFormat.d().format(slotList1[i].start.toLocal())))
              .at(LocalTime(
                  int.parse(
                      DateFormat.H().format(slotList1[i].start.toLocal())),
                  int.parse(
                      DateFormat.m().format(slotList1[i].start.toLocal())),
                  int.parse(
                      DateFormat.s().format(slotList1[i].start.toLocal())))),
          end: LocalDate(
                  int.parse(
                      DateFormat.y().format(slotList1[i].start.toLocal())),
                  int.parse(
                      DateFormat.M().format(slotList1[i].start.toLocal())),
                  int.parse(
                      DateFormat.d().format(slotList1[i].start.toLocal())))
              .at(LocalTime(
                  int.parse(
                      DateFormat.H().format(slotList1[i].start.toLocal())),
                  int.parse(
                      DateFormat.m().format(slotList1[i].start.toLocal())),
                  int.parse(
                      DateFormat.s().format(slotList1[i].start.toLocal())))),
        );
        _schedd.add(sched1);
      }
      for (int i = 0; i < slotList2.length; i++) {
        var sched2 = BasicEvent(
          id: "slot2-$i",
          title: _icon,
          color: slotList2[i].status == 1 ? Colors.green : Colors.grey,
          start: LocalDate(
                  int.parse(
                      DateFormat.y().format(slotList2[i].start.toLocal())),
                  int.parse(
                      DateFormat.M().format(slotList2[i].start.toLocal())),
                  int.parse(
                      DateFormat.d().format(slotList2[i].start.toLocal())))
              .at(LocalTime(
                  int.parse(
                      DateFormat.H().format(slotList2[i].start.toLocal())),
                  int.parse(
                      DateFormat.m().format(slotList2[i].start.toLocal())),
                  int.parse(
                      DateFormat.s().format(slotList2[i].start.toLocal())))),
          end: LocalDate(
                  int.parse(
                      DateFormat.y().format(slotList2[i].start.toLocal())),
                  int.parse(
                      DateFormat.M().format(slotList2[i].start.toLocal())),
                  int.parse(
                      DateFormat.d().format(slotList2[i].start.toLocal())))
              .at(LocalTime(
                  int.parse(
                      DateFormat.H().format(slotList2[i].start.toLocal())),
                  int.parse(
                      DateFormat.m().format(slotList2[i].start.toLocal())),
                  int.parse(
                      DateFormat.s().format(slotList2[i].start.toLocal())))),
        );
        _schedd.add(sched2);
      }
      for (int i = 0; i < slotList3.length; i++) {
        var sched3 = BasicEvent(
          id: "slot3-$i",
          title: _icon,
          color: slotList3[i].status == 1 ? Colors.green : Colors.grey,
          start: LocalDate(
                  int.parse(
                      DateFormat.y().format(slotList3[i].start.toLocal())),
                  int.parse(
                      DateFormat.M().format(slotList3[i].start.toLocal())),
                  int.parse(
                      DateFormat.d().format(slotList3[i].start.toLocal())))
              .at(LocalTime(
                  int.parse(
                      DateFormat.H().format(slotList3[i].start.toLocal())),
                  int.parse(
                      DateFormat.m().format(slotList3[i].start.toLocal())),
                  int.parse(
                      DateFormat.s().format(slotList3[i].start.toLocal())))),
          end: LocalDate(
                  int.parse(
                      DateFormat.y().format(slotList3[i].start.toLocal())),
                  int.parse(
                      DateFormat.M().format(slotList3[i].start.toLocal())),
                  int.parse(
                      DateFormat.d().format(slotList3[i].start.toLocal())))
              .at(LocalTime(
                  int.parse(
                      DateFormat.H().format(slotList3[i].start.toLocal())),
                  int.parse(
                      DateFormat.m().format(slotList3[i].start.toLocal())),
                  int.parse(
                      DateFormat.s().format(slotList3[i].start.toLocal())))),
        );
        _schedd.add(sched3);
      }
      for (int i = 0; i < slotList4.length; i++) {
        var sched4 = BasicEvent(
          id: "slot4-$i",
          title: _icon,
          color: slotList4[i].status == 1 ? Colors.green : Colors.grey,
          start: LocalDate(
                  int.parse(
                      DateFormat.y().format(slotList4[i].start.toLocal())),
                  int.parse(
                      DateFormat.M().format(slotList4[i].start.toLocal())),
                  int.parse(
                      DateFormat.d().format(slotList4[i].start.toLocal())))
              .at(LocalTime(
                  int.parse(
                      DateFormat.H().format(slotList4[i].start.toLocal())),
                  int.parse(
                      DateFormat.m().format(slotList4[i].start.toLocal())),
                  int.parse(
                      DateFormat.s().format(slotList4[i].start.toLocal())))),
          end: LocalDate(
                  int.parse(
                      DateFormat.y().format(slotList4[i].start.toLocal())),
                  int.parse(
                      DateFormat.M().format(slotList4[i].start.toLocal())),
                  int.parse(
                      DateFormat.d().format(slotList4[i].start.toLocal())))
              .at(LocalTime(
                  int.parse(
                      DateFormat.H().format(slotList4[i].start.toLocal())),
                  int.parse(
                      DateFormat.m().format(slotList4[i].start.toLocal())),
                  int.parse(
                      DateFormat.s().format(slotList4[i].start.toLocal())))),
        );
        _schedd.add(sched4);
      }
      for (int i = 0; i < slotList5.length; i++) {
        var sched5 = BasicEvent(
          id: "slot5-$i",
          title: _icon,
          color: slotList5[i].status == 1 ? Colors.green : Colors.grey,
          start: LocalDate(
                  int.parse(
                      DateFormat.y().format(slotList5[i].start.toLocal())),
                  int.parse(
                      DateFormat.M().format(slotList5[i].start.toLocal())),
                  int.parse(
                      DateFormat.d().format(slotList5[i].start.toLocal())))
              .at(LocalTime(
                  int.parse(
                      DateFormat.H().format(slotList5[i].start.toLocal())),
                  int.parse(
                      DateFormat.m().format(slotList5[i].start.toLocal())),
                  int.parse(
                      DateFormat.s().format(slotList5[i].start.toLocal())))),
          end: LocalDate(
                  int.parse(
                      DateFormat.y().format(slotList5[i].start.toLocal())),
                  int.parse(
                      DateFormat.M().format(slotList5[i].start.toLocal())),
                  int.parse(
                      DateFormat.d().format(slotList5[i].start.toLocal())))
              .at(LocalTime(
                  int.parse(
                      DateFormat.H().format(slotList5[i].start.toLocal())),
                  int.parse(
                      DateFormat.m().format(slotList5[i].start.toLocal())),
                  int.parse(
                      DateFormat.s().format(slotList5[i].start.toLocal())))),
        );
        _schedd.add(sched5);
      }
      for (int i = 0; i < slotList6.length; i++) {
        var sched6 = BasicEvent(
          id: "slot6-$i",
          title: _icon,
          color: slotList6[i].status == 1 ? Colors.green : Colors.grey,
          start: LocalDate(
                  int.parse(
                      DateFormat.y().format(slotList6[i].start.toLocal())),
                  int.parse(
                      DateFormat.M().format(slotList6[i].start.toLocal())),
                  int.parse(
                      DateFormat.d().format(slotList6[i].start.toLocal())))
              .at(LocalTime(
                  int.parse(
                      DateFormat.H().format(slotList6[i].start.toLocal())),
                  int.parse(
                      DateFormat.m().format(slotList6[i].start.toLocal())),
                  int.parse(
                      DateFormat.s().format(slotList6[i].start.toLocal())))),
          end: LocalDate(
                  int.parse(
                      DateFormat.y().format(slotList6[i].start.toLocal())),
                  int.parse(
                      DateFormat.M().format(slotList6[i].start.toLocal())),
                  int.parse(
                      DateFormat.d().format(slotList6[i].start.toLocal())))
              .at(LocalTime(
                  int.parse(
                      DateFormat.H().format(slotList6[i].start.toLocal())),
                  int.parse(
                      DateFormat.m().format(slotList6[i].start.toLocal())),
                  int.parse(
                      DateFormat.s().format(slotList6[i].start.toLocal())))),
        );
        _schedd.add(sched6);
      }
      scheds.addAll(_schedd);
      notifyListeners();
    } else {
      print(response.statusCode);
    }
    return scheds;
  }

  void _setToNull() {
    slotList0 = [];
    slotList1 = [];
    slotList2 = [];
    slotList3 = [];
    slotList4 = [];
    slotList5 = [];
    slotList6 = [];
    _schedd = [];
    scheds = [];
    notifyListeners();
  }

  get setToNull => _setToNull();
}
