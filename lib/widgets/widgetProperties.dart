import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:moonpath/components/homePage.dart';

class WidgetProperties {
  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    textStyle: TextStyle(
      fontSize: 10.0,
    ),
    primary: Colors.red,
  );
  loadingProgress(BuildContext context) {
    return Material(
      child: Container(
        alignment: Alignment.center,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  contentBox(BuildContext context, name, selectedDate, description, email,
      contactNumber, amount, _instructions, paymentMethod) {
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
              SizedBox(
                height: 15,
              ),
              Text(description),
              Text(selectedDate.toString(),
                  style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic)),
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
                      Navigator.pop(context);
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

  displayAnimatedDialog(BuildContext context, name, selectedDate, description,
      email, contactNumber, amount, _instructions, paymentMethod) {
    return showAnimatedDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: Colors.blue[100],
          insetPadding: EdgeInsets.all(10.0),
          title: const Text('Proceed with payment'),
          children: <Widget>[
            Dialog(
              insetPadding: EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Constants.padding),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: contentBox(context, name, selectedDate, description, email,
                  contactNumber, amount, _instructions, paymentMethod),
            ),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                  style: buttonStyle,
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
}

class Constants {
  Constants._();
  static const double padding = 5;
  static const double avatarRadius = 30;
}
