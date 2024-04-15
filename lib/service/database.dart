import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  // CREATE
  Future addVisitorDetails(
      Map<String, dynamic> visitorInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Visitor")
        .doc(id)
        .set(visitorInfoMap);
  }

  // READ
  Future<Stream<QuerySnapshot>> getVisitorDetails() async {
    return await FirebaseFirestore.instance.collection("Visitor").snapshots();
  }

  // UPDATE
  Future updateVisitorDetails(
      String id, Map<String, dynamic> updateInfo) async {
    return await FirebaseFirestore.instance
        .collection("Visitor")
        .doc(id)
        .update(updateInfo);
  }

  // DELETE
  Future deleteVisitorDetails(String id) async {
    return await FirebaseFirestore.instance
        .collection("Visitor")
        .doc(id)
        .delete();
  }
}
