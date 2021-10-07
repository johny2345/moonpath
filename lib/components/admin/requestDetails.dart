import 'package:flutter/material.dart';

class ClientRequestDetailPage extends StatefulWidget {
  const ClientRequestDetailPage({Key? key, this.details}) : super(key: key);
  final details;

  @override
  _ClientRequestDetailPageState createState() =>
      _ClientRequestDetailPageState(details: details);
}

class _ClientRequestDetailPageState extends State<ClientRequestDetailPage> {
  _ClientRequestDetailPageState({Key? key, this.details});
  final details;

  displaySnackBar(message) {
    final snackBar = new SnackBar(
      content: new Text(message),
      duration: new Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Request Details'),
        ),
        body: _displayClientDetails(context),
      ),
    );
  }

  _displayClientDetails(BuildContext context) {
    return SingleChildScrollView(
        child: Card(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Text(details['name'].toString()),
            Text(details['channel'].toString()),
            Text(details['description'].toString()),
            Text(details['contact'].toString()),
            Text(details['image_url'].toString()),
            Text(details['paymentStatus'].toString()),
            Text(details['isAccepted'].toString()),
          ],
        ),
      ),
    ));
  }
}
