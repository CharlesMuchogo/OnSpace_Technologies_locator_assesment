import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatelessWidget {
  const MapPage({required this.markers, super.key});
  final Set<Marker> markers;

  @override
  Widget build(BuildContext context) {
    return  GoogleMap(
      initialCameraPosition: const CameraPosition(
        target: LatLng(-1.2655367, 36.8104826),
        zoom: 17,
      ),
      markers: Set<Marker>.of(markers),
      myLocationEnabled: true,
      onMapCreated: (GoogleMapController controller) {},
    );
  }
}
