import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:moonpath/widgets/widgetProperties.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class ApiProvider {
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

  Future<dynamic> _getQuery() async {
    var listOfSchedules =
        await FirebaseFirestore.instance.collection('bookRequests').snapshots();

    return listOfSchedules;
  }

  getSchedules() async {
    var listOfRequest = await bookRequest.get();

    print(listOfRequest);
    return listOfRequest;
  }

  Future<void> logout() async {
    return await FirebaseAuth.instance.signOut();
  }

  Future<void> updateAcceptRequest(documentId) {
    return bookRequest.doc(documentId).update({'isAccepted': true});
  }

  Future<dynamic> deleteApptRequest(documentId) {
    var toDeleteRequest = bookRequest.doc(documentId).delete();
    print('---------------------------');
    print(toDeleteRequest);
    print('--------------------------------');
    return toDeleteRequest;
  }
}
