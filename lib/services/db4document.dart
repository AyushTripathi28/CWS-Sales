import 'package:cloud_firestore/cloud_firestore.dart';
class DbDocument {
  Future<void> inputDataInfo(userData) async {
    Firestore.instance.collection("Document").add(userData).catchError((e) {
      print(e.toString());
    });
  }
}