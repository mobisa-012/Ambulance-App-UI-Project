import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Ambulance {
  final String plateNo;
  final String image;
  final LatLng location;
  final String ambType;
  final String cost;

  Ambulance(
      {required this.plateNo,
      required this.ambType,
      required this.image,
      required this.location,
      required this.cost});
  factory Ambulance.fromSnapshot(DocumentSnapshot documentSnapshot) {
    final data = documentSnapshot.data() as Map<String, dynamic>;
    return Ambulance(
        plateNo: data['plateNo'],
        ambType: data['ambType'] as String,
        image: data['image'],
        location: data['location'],
        cost: data['cost']);
  }
}
