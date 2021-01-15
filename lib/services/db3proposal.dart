import 'package:cloud_firestore/cloud_firestore.dart';
class DbProposal {
  Future<void> inputDataInfo(userData) async {
    Firestore.instance.collection("Proposal").add(userData).catchError((e) {
      print(e.toString());
    });
  }
}