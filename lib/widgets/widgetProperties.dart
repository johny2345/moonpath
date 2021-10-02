import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:moonpath/components/homePage.dart';

class WidgetProperties {
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

  displayAnimatedDialog(BuildContext context) {
    return showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select assignment'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Homepage()),
                    (Route<dynamic> route) => false);
              },
              child: const Text('Treasury department'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('State department'),
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
