import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorData {
  final String location;
  final String name;
  final String phone;
  final String title;
  final String imageUrl;

  DoctorData(
      {required this.imageUrl,
      required this.name,
      required this.location,
      required this.phone,
      required this.title});

  factory DoctorData.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return DoctorData(
        imageUrl: documentSnapshot['imageUrl'],
        name: documentSnapshot['name'],
        location: documentSnapshot['location'],
        phone: documentSnapshot['phone'],
        title: documentSnapshot['title']);
  }
}


