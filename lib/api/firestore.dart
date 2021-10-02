import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class FirebaseDatabase {
  CollectionReference bookRequest =
      FirebaseFirestore.instance.collection('bookRequests');
  Future<void> addBookRequest() async {
    await bookRequest.add({
      'requestId': '',
      'amount': '',
      'description': '',
      'channel': '',
      'email': '',
      'contact': '',
      'name': '',
      'schedule': '',
      'isAccepted': '',
      'refCode': '',
      'imageUrl': '',
      'paymentUrl': '',
      'paymentStatus': '',
    }).then((value) {
      print('Request added');
      print(value);
      return true;
    }).catchError((err) {
      print('Failed: $err');
      return false;
    });
  }

  Future<dynamic> getSchedules() async {
    return bookRequest.orderBy('schedule').snapshots();
  }
}
