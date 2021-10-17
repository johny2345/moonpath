import 'package:flutter/material.dart';
import 'package:moonpath/api/apiProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moonpath/widgets/widgetProperties.dart';
import 'package:moonpath/components/admin/requestDetails.dart';

class ClientRequestPage extends StatefulWidget {
  const ClientRequestPage({Key? key}) : super(key: key);

  @override
  _ClientRequestPageState createState() => _ClientRequestPageState();
}

class _ClientRequestPageState extends State<ClientRequestPage> {
  String? scheduleFormatted;

  final Stream<QuerySnapshot> _bookRequestStream = FirebaseFirestore.instance
      .collection('bookRequests')
      .orderBy('schedule')
      .snapshots(includeMetadataChanges: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Request'),
      ),
      body: _buildRequestList(context),
    );
  }

  _buildRequestList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _bookRequestStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something Went missing');
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return WidgetProperties().loadingProgress(context);
        }
        return _displayRequestList(context, snapshot);
      },
    );
  }

  _displayRequestList(BuildContext context, AsyncSnapshot snapshot) {
    print('get list of request------------------------');
    String? month;

    return ListView(
      children: snapshot.data!.docs.map<Widget>((document) {
        DateTime? requestDate = document['schedule'].toDate().toUtc();
        var dateScheds = DateTime.utc(requestDate!.year, requestDate.month,
                requestDate.day, requestDate.hour)
            .add(Duration(hours: 8));
        print('-------------------------------------------------');
        print('dateScheds: ' + dateScheds.toString());
        print('requestDAte: ' + requestDate.toString());
        if (requestDate.month == 1) {
          month = 'January';
        }
        if (requestDate.month == 2) {
          month = 'February';
        }
        if (requestDate.month == 3) {
          month = 'March';
        }
        if (requestDate.month == 4) {
          month = 'April';
        }
        if (requestDate.month == 5) {
          month = 'May';
        }
        if (requestDate.month == 6) {
          month = 'June';
        }
        if (requestDate.month == 7) {
          month = 'July';
        }
        if (requestDate.month == 8) {
          month = 'August';
        }
        if (requestDate.month == 9) {
          month = 'September';
        }
        if (requestDate.month == 10) {
          month = 'October';
        }
        if (requestDate.month == 11) {
          month = 'November';
        }
        if (requestDate.month == 12) {
          month = 'December';
        }

        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        // print(data);
        String? displayCal = month.toString() +
            ' ' +
            requestDate.day.toString() +
            ',' +
            ' ' +
            requestDate.year.toString();
        debugPrint(data['name'] + ' ' + data['schedule'].toDate().toString());
        print('---------------GET DOCUMENT ID---------------------');
        print(document.id);
        String? documentId = document.id;
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(3.0)),
            child: ListTile(
              leading: Icon(Icons.request_page_rounded),
              title: Text(data['name'].toString()),
              subtitle: Text(displayCal),
              onTap: () {
                setState(() {
                  scheduleFormatted = displayCal;
                });
                debugPrint(scheduleFormatted);
                debugPrint(data['name'] + ' ' + data['timestamp'].toString());
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ClientRequestDetailPage(
                        details: data,
                        scheduleFormatted: scheduleFormatted,
                        documentId: documentId)));
              },
            ),
          ),
        );
      }).toList(),
    );
  }
}
