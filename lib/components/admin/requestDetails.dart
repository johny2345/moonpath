import 'package:flutter/material.dart';
import 'package:moonpath/widgets/widgetProperties.dart';
import 'package:moonpath/services/services.dart';

class ClientRequestDetailPage extends StatefulWidget {
  const ClientRequestDetailPage(
      {Key? key, this.details, this.scheduleFormatted, this.documentId})
      : super(key: key);
  final details;
  final documentId;
  final scheduleFormatted;

  @override
  _ClientRequestDetailPageState createState() => _ClientRequestDetailPageState(
      details: details,
      scheduleFormatted: scheduleFormatted,
      documentId: documentId);
}

class _ClientRequestDetailPageState extends State<ClientRequestDetailPage> {
  _ClientRequestDetailPageState(
      {Key? key, this.details, this.scheduleFormatted, this.documentId});

  bool? paymentStatusBool = false;
  bool? isLoading = true;

  @override
  initState() {
    super.initState();
    Apis().getDetails(details['requestId'].toString()).then((value) {
      setState(() {
        paymentStatus = value.data['status'];
        isLoading = false;
      });
    });
  }

  final details;
  final scheduleFormatted;
  final documentId;

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
      firebaseRequestId,
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
    debugPrint('again: $scheduleFormatted');
    setState(() {
      amount = details['amount'].toString();
      channel = details['channel'].toString();
      contact = details['contact'].toString();
      description = details['description'].toString();
      email = details['email'].toString();
      imageUrl = details['imageUrl'].toString();
      name = details['name'].toString();
      paymentUrl = details['paymentUrl'].toString();
      refCode = details['refCode'];
      requestId = details['requestId'].toString();
      schedule = details['schedule'].toDate();
      timestamp = details['timestamp'].toDate();
      isAccepted = details['isAccepted'];
      _instructions = '';
    });

    if (paymentStatus == "Paid") {
      setState(() {
        paymentStatusBool = true;
      });
    }

    if (isLoading == true) {
      return WidgetProperties().loadingProgress(context);
    } else {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Request Details'),
          ),
          body: displayAnimatedDialog(context),
        ),
      );
    }
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
              channel,
              paymentStatusBool,
              scheduleFormatted,
              paymentUrl,
              documentId),
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
}
