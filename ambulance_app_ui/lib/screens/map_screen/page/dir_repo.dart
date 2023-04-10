import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/directions.dart';

class DirectionsRepository {
  late GoogleMapsDirections directions;

  DirectionsRepository() {
    directions =
        GoogleMapsDirections(apiKey: 'AIzaSyB4QwU_ICnLEmJsvmVYz0KtzX-cDFtDSeQ');
  }
  Future<DirectionsResponse> getDirections(
      LatLng origin, LatLng destination) async {
    return await directions.directionsWithLocation(
        Location(origin.latitude, destination.longitude),
        Location(destination.latitude, destination.longitude),
        travelMode: TravelMode.driving);
  }
}
