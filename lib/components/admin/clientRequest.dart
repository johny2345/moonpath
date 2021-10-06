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
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            print(data);
            return ListTile(
              title: Text(data['name'].toString()),
              subtitle: Text(data['schedule'].toString()),
              onTap: () {
                print(data['description']);
              },
            );
          }).toList(),
        );
      },
    );
  }
}
