import 'package:flutter/material.dart';
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
  bool? isLoading = true;

  _getQuery() async {
    await FirebaseFirestore.instance
        .collection('bookRequests')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        String? desc = (doc['description']);
        if (desc!.length >= 30) {
          setState(() {
            desc = desc!.substring(0, 35) + '...';
          });
        }
        print(doc["schedule"].toDate().toLocal());
        setState(() {
          _events.addAll({
            DateTime(doc["schedule"].toDate().toLocal().year,
                doc["schedule"].toDate().month, doc["schedule"].toDate().day): [
              CleanCalendarEvent(doc["name"],
                  startTime: DateTime(DateTime.now().year, DateTime.now().month,
                      DateTime.now().day, doc['schedule'].toDate().hour, 0),
                  endTime: DateTime(DateTime.now().year, DateTime.now().month,
                      DateTime.now().day, 0, 0),
                  description: desc.toString(),
                  isAllDay: true,
                  color: Colors.indigo),
            ]
          });
        });
      });
    });
    setState(() {
      isLoading = false;
    });
  }

  DateTime? getSchedule;
  String? name;

  @override
  void initState() {
    super.initState();
    // Force selection of today on first load, so that the list of today's events gets shown.
    _events = {};
    print('-get query func------------------------');
    _getQuery();
    print('-get query func------------------------');
    _handleNewDate(DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day));
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading == true) {
      return WidgetProperties().loadingProgress(context);
    } else {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Calendar'),
        ),
        body: _buildRequestList(context),
      );
    }
  }

  _buildRequestList(BuildContext context) {
    return _displayCalendar(context);
  }

  void _handleNewDate(date) {
    print('Date selected: $date');
  }

  _displayCalendar(BuildContext context) {
    return SafeArea(
      child: Calendar(
        startOnMonday: false,
        weekDays: ['Mo', 'Tu', 'Wed', 'Thu', 'Fr', 'Sa', 'Su'],
        events: _events,
        isExpandable: true,
        isExpanded: true,
        eventColor: Colors.teal,
        eventDoneColor: Colors.green,
        selectedColor: Colors.pink,
        hideBottomBar: true,
        todayColor: Colors.blue,
        locale: 'en_US',
        todayButtonText: 'Today',
        expandableDateFormat: 'EEEE, dd. MMMM yyyy',
        dayOfWeekStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w800, fontSize: 11),
      ),
    );
  }
}
