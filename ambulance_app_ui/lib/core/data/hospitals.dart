import 'package:cloud_firestore/cloud_firestore.dart';

class Hospitals {
  final String id;
  final String name;
  final double lat;
  final double lng;

  Hospitals(
      {required this.id,
      required this.lat,
      required this.lng,
      required this.name});
  factory Hospitals.fromSnapshot(DocumentSnapshot documentSnapshot) {
    final hdata = documentSnapshot.data() as Map<String, dynamic>;
    return Hospitals(
      id: hdata['id'], 
      lat: hdata['lat'], 
      lng: hdata['lng'], 
      name: hdata['name']);
  }
}
