import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class BookPage extends StatefulWidget {
  const BookPage({Key? key}) : super(key: key);

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book now'),
        centerTitle: true,
      ),
      body: _userInputDetailsForm(context),
    );
  }

  Widget _userInputDetailsForm(BuildContext context) {
    return Container(
      child: Text('Test'),
    );
  }
}
