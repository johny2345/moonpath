import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moonpath/widgets/widgetProperties.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:flutter_clean_calendar/clean_calendar_event.dart';

class CalendarScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CalendarScreenState();
  }
}

Map<DateTime, List<CleanCalendarEvent>> _events = {};

class _CalendarScreenState extends State<CalendarScreen> {
  _getQuery() async {
    FirebaseFirestore.instance
        .collection('bookRequests')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc["schedule"].toDate());
        print(doc["schedule"].toDate().year);
        setState(() {
          _events = {
            DateTime(doc["schedule"].toDate().year,
                doc["schedule"].toDate().month, doc["schedule"].toDate().day): [
              CleanCalendarEvent(doc["name"],
                  startTime: DateTime(DateTime.now().year, DateTime.now().month,
                      DateTime.now().day, 8, 0),
                  endTime: DateTime(DateTime.now().year, DateTime.now().month,
                      DateTime.now().day, 8, 0),
                  description: 'For Birthday celebration',
                  color: Colors.yellow),
            ],
          };
        });
      });
    });
  }

  DateTime? getSchedule;
  String? name;

  // @override
  // void initState() {
  //   super.initState();
  //   // Force selection of today on first load, so that the list of today's events gets shown.
  //   _handleNewDate(DateTime(
  //       DateTime.now().year, DateTime.now().month, DateTime.now().day));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Calendar'),
      ),
      body: _buildRequestList(context),
    );
  }

  _buildRequestList(BuildContext context) {
    return _displayCalendar(context);
  }

  void _handleNewDate(date) {
    print('Date selected: $date');
  }

  _displayCalendar(BuildContext context) {
    print('-get query func------------------------');
    _getQuery();
    print('-get query func------------------------');

    return SafeArea(
      child: Calendar(
        startOnMonday: true,
        weekDays: ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'],
        events: _events,
        isExpandable: true,
        eventDoneColor: Colors.green,
        selectedColor: Colors.pink,
        todayColor: Colors.blue,
        eventColor: Colors.grey,
        locale: 'en_US',
        todayButtonText: 'Today',
        isExpanded: true,
        expandableDateFormat: 'EEEE, dd. MMMM yyyy',
        dayOfWeekStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w800, fontSize: 11),
      ),
    );
  }
}

List<ParseJson> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<ParseJson>((json) => ParseJson.fromJson(json)).toList();
}

class ParseJson {
  final String? name;
  final DateTime? schedule;

  const ParseJson({this.name, this.schedule});

  factory ParseJson.fromJson(Map<String, dynamic> json) {
    return ParseJson(
      name: json['name'] as String,
      schedule: json['schedule'].toDate() as DateTime,
    );
  }
}
