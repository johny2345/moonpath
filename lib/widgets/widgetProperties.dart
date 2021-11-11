import 'package:moonpath/api/apiProvider.dart';
import 'package:moonpath/components/homePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class WidgetProperties {
  Future<void> _launchInWebViewOrVC(String url) async {
    if (await canLaunch(url)) {
      await launch(url,
          forceSafariVC: false,
          forceWebView: false,
          headers: <String, String>{'my_header_key': "my_header_value"});
    } else {
      throw 'Could not launch $url';
    }
  }

  final ButtonStyle bgRed = ElevatedButton.styleFrom(
    primary: Colors.red,
  );

  final ButtonStyle bgGreen = ElevatedButton.styleFrom(
    primary: Colors.green,
  );

  loadingProgress(BuildContext context) {
    return Material(
      child: Container(
          alignment: Alignment.center,
          child: SpinKitFoldingCube(
            color: Colors.teal[300],
            size: 50.00,
          )),
    );
  }

  contentBox(BuildContext context, name, selectedDate, description, email,
      contactNumber, amount, _instructions, paymentMethod, paymentUrl) {
    String? month;
    DateTime? requestDate = selectedDate;

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

    String? scheduleFormatted = month.toString() +
        ' ' +
        requestDate.day.toString() +
        ',' +
        ' ' +
        requestDate.year.toString();
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius + Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                name,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              Text(email),
              Text(contactNumber),
              SizedBox(
                height: 10,
              ),
              Text(
                'PHP $amount',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              Text(paymentMethod),
              SizedBox(
                height: 15,
              ),
              Divider(
                height: 1,
                color: Colors.grey,
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                color: Colors.grey[200],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      description,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      scheduleFormatted.toString(),
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                _instructions,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 22,
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                    onPressed: () {
                      // Navigator.pop(context);
                      _launchInWebViewOrVC(paymentUrl);
                    },
                    child: Text(
                      'Proceed payment',
                      style: TextStyle(fontSize: 15),
                    )),
              ),
            ],
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: ClipRRect(
                borderRadius:
                    BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                child: Image.asset("assets/brand/person/avatar.png")),
          ),
        ),
      ],
    );
  }

  displaySnackBar(BuildContext context, message) {
    final snackBar = new SnackBar(
      content: new Text(message),
      duration: new Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  adminRequesrCheckout(
      BuildContext context,
      name,
      selectedDate,
      description,
      email,
      contactNumber,
      amount,
      _instructions,
      paymentMethod,
      paymentStatus,
      scheduleFormatted,
      paymentUrl,
      documentId) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius + Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                name,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              Text(email, style: TextStyle(color: Colors.black54)),
              Text(contactNumber, style: TextStyle(color: Colors.black54)),
              SizedBox(
                height: 10,
              ),
              Text(
                'PHP $amount',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              Text(paymentMethod),
              SizedBox(
                height: 15,
              ),
              paymentStatus
                  ? RichText(
                      text: TextSpan(
                        text: 'Payment Status: ',
                        style: TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Paid',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green))
                        ],
                      ),
                    )
                  : RichText(
                      text: TextSpan(
                        text: 'Payment Status: ',
                        style: TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Pending',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red))
                        ],
                      ),
                    ),
              SizedBox(
                height: 15,
              ),
              Container(
                color: Colors.grey[200],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Text(description, textAlign: TextAlign.center),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      scheduleFormatted.toString(),
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              TextFormField(
                  enabled: false,
                  initialValue: paymentUrl,
                  decoration: InputDecoration(
                    counterText: '',
                    labelText: 'Payment Url',
                  ),
                  autofocus: true,
                  keyboardType: TextInputType.url,
                  maxLength: 30),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.purple,
                        textStyle: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    onPressed: () {
                      displaySnackBar(context, 'Copied!');
                      Clipboard.setData(ClipboardData(text: paymentUrl));
                    },
                    child: Text(
                      'Copy Payment Url',
                      style: TextStyle(fontSize: 15),
                    )),
              ),
              SizedBox(
                height: 25,
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                    onPressed: () {
                      ApiProvider()
                          .updateAcceptRequest(documentId)
                          .then((value) {
                        displaySnackBar(context, 'Request accepted!');
                      });
                    },
                    child: Text(
                      'Accept',
                      style: TextStyle(fontSize: 15),
                    )),
              ),
            ],
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: ClipRRect(
                borderRadius:
                    BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                child: Image.asset("assets/brand/person/avatar.png")),
          ),
        ),
      ],
    );
  }

  displayAnimatedDialog(BuildContext context, name, selectedDate, description,
      email, contactNumber, amount, _instructions, paymentMethod, paymentUrl) {
    return showAnimatedDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SimpleDialog(
          clipBehavior: Clip.hardEdge,
          backgroundColor: Colors.blue[100],
          title: const Text(
            'Checkout',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          children: <Widget>[
            Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Constants.padding),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: contentBox(
                  context,
                  name,
                  selectedDate,
                  description,
                  email,
                  contactNumber,
                  amount,
                  _instructions,
                  paymentMethod,
                  paymentUrl),
            ),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                  style: bgRed,
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Homepage()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: Text(
                    'Close',
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

  Future<void> invalidDialog(BuildContext context, title, message) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(title),
            content: new Text(message),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Center(
                      child: ElevatedButton(
                    // highlightedBorderColor: Colors.teal,
                    child: Text('OK'),
                    onPressed: () {
                      print(
                          '------------HAS CLICKED INVALID EMAIL/PASSWORD!--------');
                      Navigator.of(context).pop();
                    },
                  ))
                ],
              ),
            ],
          );
        });
  }

  Future<void> confirmationDialog(
      BuildContext context, title, message, documentId) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(title),
            content: new Text(message),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ElevatedButton(
                    style: bgRed,
                    child: Text('Confirm'),
                    onPressed: () {
                      print(documentId);
                      ApiProvider().deleteApptRequest(documentId).then((value) {
                        print("This valie upon deletion $value");
                        Navigator.of(context).pop();
                        displaySnackBar(context, 'Deleted successfully!');
                      });
                    },
                  ),
                  ElevatedButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          );
        });
  }
}

class Constants {
  Constants._();
  static const double padding = 5;
  static const double avatarRadius = 30;
}
