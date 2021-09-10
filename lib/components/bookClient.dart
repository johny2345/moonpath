import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:moonpath/widgets/widgetProperties.dart';

class BookPage extends StatefulWidget {
  const BookPage({Key? key}) : super(key: key);

  @override
  _BookPageState createState() => _BookPageState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

bool? isLoading = false;

class _BookPageState extends State<BookPage> {
  @override
  Widget build(BuildContext context) {
    if (isLoading == true) {
      return WidgetProperties().loadingProgress(context);
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Book now'),
          centerTitle: true,
        ),
        body: _userInputDetailsForm(context),
      );
    }
  }

  Widget _userInputDetailsForm(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(20.0),
            ),
          ),
        );
      },
    );
  }
}
