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
      requestId;
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
    amount = details['amount'].toString();
    channel = details['channel'].toString();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Request Details'),
        ),
        body: _displayClientDetails(context),
      ),
    );
  }

  displayAnimatedDialog(BuildContext context, name, selectedDate, description,
      email, contactNumber, amount, _instructions, paymentMethod) {
    return showAnimatedDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SimpleDialog(
          clipBehavior: Clip.hardEdge,
          backgroundColor: Colors.blue[100],
          insetPadding: EdgeInsets.all(10.0),
          title: const Text(
            'Checkout',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          children: <Widget>[
            Dialog(
              insetPadding: EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Constants.padding),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: WidgetProperties().contentBox(
                  context,
                  name,
                  selectedDate,
                  description,
                  email,
                  contactNumber,
                  amount,
                  _instructions,
                  paymentMethod),
            ),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                  style: WidgetProperties().buttonStyle,
                  onPressed: () {},
                  child: Text(
                    'Accept',
                    style: TextStyle(fontSize: 18),
                  )),
            ),
          ],
        );
      },
      animationType: DialogTransitionType.slideFromTop,
      curve: Curves.fastOutSlowIn,
      duration: Duration(seconds: 1),
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
