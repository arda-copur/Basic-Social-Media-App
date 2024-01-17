import 'package:cloud_firestore/cloud_firestore.dart';

class Status {
  String id;
  String status;
  String image;
  String personName;
  Status({
    required this.id,
    required this.status,
    required this.image,
    required this.personName,
  });

  factory Status.fromSnapshot(DocumentSnapshot snapshot) {
    return Status(
        id: snapshot.id,
        status: snapshot['status'],
        image: snapshot['image'],
        personName: snapshot['personName']);
  }
}
