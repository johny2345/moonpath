import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:moonpath/components/homePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

const bool USE_EMULATOR = false;

Future _connectToFirebaseEmulator() async {
  final localHostString = Platform.isAndroid ? '10.0.2.2' : 'localhost';

  FirebaseFirestore.instance.settings = Settings(
    host: '$localHostString:8080',
    sslEnabled: false,
    persistenceEnabled: false,
  );

  await FirebaseAuth.instance.useAuthEmulator('http://$localHostString', 9099);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // if (USE_EMULATOR) {
  //   await _connectToFirebaseEmulator();
  // }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yacht Booking App',
      theme: ThemeData(
        // brightness: Brightness.,
        fontFamily: 'Sansation',
        primaryTextTheme: Typography.whiteCupertino,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,

        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
          bodyText1: TextStyle(
            fontSize: 15.0,
          ),
        ),
      ),
      home: Homepage(),
    );
  }
}
