import 'package:flutter/material.dart';

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
