import 'package:flutter/material.dart';
import 'package:moonpath/api/apiProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moonpath/widgets/widgetProperties.dart';

class ClientRequestPage extends StatefulWidget {
  const ClientRequestPage({Key? key}) : super(key: key);

  @override
  _ClientRequestPageState createState() => _ClientRequestPageState();
}

class _ClientRequestPageState extends State<ClientRequestPage> {
  final Stream<QuerySnapshot> _bookRequestStream = FirebaseFirestore.instance
      .collection('bookRequests')
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
    String? month;

    return ListView(
      children: snapshot.data!.docs.map<Widget>((document) {
        DateTime? requestDate = document['schedule'].toDate();
        if (requestDate!.month == 1) {
          month = 'January';
        } else if (requestDate.month == 2) {
          month = 'February';
        } else if (requestDate.month == 3) {
          month = 'March';
        } else if (requestDate.month == 4) {
          month = 'April';
        } else if (requestDate.month == 5) {
          month = 'May';
        } else if (requestDate.month == 6) {
          month = 'June';
        } else if (requestDate.month == 7) {
          month = 'July';
        } else if (requestDate.month == 8) {
          month = 'August';
        } else if (requestDate.month == 9) {
          month = 'September';
        } else if (requestDate.month == 10) {
          month = 'October';
        } else if (requestDate.month == 11) {
          month = 'November';
        } else if (requestDate.month == 12) {
          month = 'December';
        }
        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        print(data);
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(3.0)),
            child: ListTile(
              leading: Icon(Icons.request_page_rounded),
              title: Text(data['name'].toString()),
              subtitle: Text(month.toString() +
                  ' ' +
                  requestDate.day.toString() +
                  ',' +
                  ' ' +
                  requestDate.year.toString()),
              onTap: () {
                print(data['description']);
              },
            ),
          ),
        );
      }).toList(),
    );
  }
}
