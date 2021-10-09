import 'package:flutter/material.dart';
import 'package:moonpath/widgets/widgetProperties.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

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

  String? channel,
      amount,
      contact,
      description,
      email,
      imageUrl,
      name,
      paymentStatus,
      paymentUrl,
      refCode,
      requestId,
      _instructions;
  DateTime? schedule, timestamp;
  bool? isAccepted;

  displaySnackBar(message) {
    final snackBar = new SnackBar(
      content: new Text(message),
      duration: new Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      amount = details['amount'].toString();
      channel = details['channel'].toString();
      contact = details['description'].toString();
      description = details['description'].toString();
      email = details['email'].toString();
      imageUrl = details['imageUrl'].toString();
      name = details['name'].toString();
      paymentStatus = details['paymentStatus'].toString();
      paymentUrl = details['paymentUrl'].toString();
      refCode = details['refCode'];
      requestId = details['requestId'].toString();
      schedule = details['schedule'].toDate();
      timestamp = details['timestamp'].toDate();
      isAccepted = details['isAccepted'];
      _instructions = '';
    });

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Request Details'),
        ),
        body: displayAnimatedDialog(context),
      ),
    );
  }

  displayAnimatedDialog(BuildContext context) {
    return SimpleDialog(
      clipBehavior: Clip.hardEdge,
      backgroundColor: Colors.blue[100],
      insetPadding: EdgeInsets.all(10.0),
      children: <Widget>[
        Dialog(
          insetPadding: EdgeInsets.all(10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.padding),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: WidgetProperties().adminRequesrCheckout(
              context,
              name,
              schedule,
              description,
              email,
              contact,
              amount,
              _instructions,
              channel),
        ),
        // Align(
        //   alignment: Alignment.center,
        //   child: ElevatedButton(
        //       style: WidgetProperties().buttonStyle,
        //       onPressed: () {},
        //       child: Text(
        //         'Accept',
        //         style: TextStyle(fontSize: 18),
        //       )),
        // ),
      ],
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
            // Text(details['imageUrl'].toString()),
            Text(details['paymentStatus'].toString()),
            Text(details['isAccepted'].toString()),
          ],
        ),
      ),
    ));
  }
}
