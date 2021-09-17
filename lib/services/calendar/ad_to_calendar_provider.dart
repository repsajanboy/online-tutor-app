import 'dart:developer';
import 'dart:io';

import "package:googleapis_auth/auth_io.dart";
import 'package:googleapis/calendar/v3.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:justlearn/services/dashboardDetails.dart/dash_details_provider.dart';
// import 'package:provider/provider.dart';

class AddToCalendar {
  static const _scopes = const [CalendarApi.CalendarScope];
  

  insert(name, duration, title, startTime, timezone, note) {
    var _clientID;
    if (Platform.isAndroid){
      _clientID = new ClientId("196010083038-lp2di6ndf04ksaa1clipb924a6qbis98.apps.googleusercontent.com", "");
    } else if(Platform.isIOS) {
      _clientID = new ClientId("196010083038-hkrfplpl4tl9pl8fem5p991u8h0sda0a.apps.googleusercontent.com", "");
    }
    clientViaUserConsent(_clientID, _scopes, prompt).then((AuthClient client) {
      var calendar = CalendarApi(client);
      calendar.calendarList.list().then((value) => print("VAL________$value"));

      String calendarId = "primary";
      Event event = Event(); // Create object of event

      event.summary = 'Justlearn lesson with ' + name;
      event.description = title + '\n' + 'Duration: ' + duration + ' Minutes lesson' + '\n' + note;
      

      

      EventDateTime start = new EventDateTime();
      start.dateTime = startTime;
      start.timeZone = timezone;
      event.start = start;

      EventDateTime end = new EventDateTime();
      end.dateTime = startTime;
      end.timeZone = timezone;
      event.end = start;
      try {
        calendar.events.insert(event, calendarId).then((value) {
          print("ADDEDDD_________________${value.status}");
          if (value.status == "confirmed") {
            log('Event added in google calendar');
          } else {
            log("Unable to add event in google calendar");
          }
        });
      } catch (e) {
        log('Error creating event $e');
      }
    });
  }

  void prompt(String url) async {
    print("Please go to the following URL and grant access:");
    print("  => $url");
    print("");

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}