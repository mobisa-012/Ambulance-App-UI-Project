import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class Ambulance {
  final String id;
  final Uint8List image;
  final double lat;
  final double lng;
  final String ambType;
  final String cost;

  Ambulance({
    required this.id,
    required this.ambType,
    required this.image,
    required this.lat,
    required this.lng,
    required this.cost
  });
  factory Ambulance.fromSnapshot(DocumentSnapshot documentSnapshot) {
    final data = documentSnapshot.data() as Map<String, dynamic>;
    final image = data['image'] as Uint8List;
    return Ambulance(
      id: documentSnapshot.id,
      ambType: data['ambType'] as String,
      image: image,
      lat: data['lat'] as double,
      lng: data['lng'] as double,
      cost: data['cost']
    );
  }
}
