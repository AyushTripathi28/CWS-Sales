import 'package:cloud_firestore/cloud_firestore.dart';
class DbMethod {
  Future<void> inputDataInfo(userData) async {
    Firestore.instance.collection("List").add(userData).catchError((e) {
      print(e.toString());
    });
  }
}