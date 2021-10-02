import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class FirebaseDatabase {
  CollectionReference bookRequest =
      FirebaseFirestore.instance.collection('bookRequests');

  Future<void> addBookRequest(
      requestId,
      amount,
      description,
      channel,
      email,
      contact,
      name,
      selectedDate,
      refCode,
      imageUrl,
      paymentUrl,
      paymentStatus,
      paymentMethod) async {
    await bookRequest.add({
      'requestId': requestId,
      'amount': amount,
      'description': description,
      'channel': paymentMethod,
      'email': email,
      'contact': contact,
      'name': name,
      'schedule': selectedDate,
      'isAccepted': false,
      'refCode': refCode,
      'imageUrl': imageUrl,
      'paymentUrl': paymentUrl,
      'paymentStatus': paymentStatus,
      'timestamp': DateTime.now()
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
