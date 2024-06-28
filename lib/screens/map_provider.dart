import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:mapbox_gl/mapbox_gl.dart';

class MapProvider extends StatelessWidget {
  final String mapboxToken =
      'pk.eyJ1IjoicG9jbGFtIiwiYSI6ImNscG12aGJ0ZDBleWYyaXQzd2ttYmgxa2gifQ.SUnhhd7SdBF5J0reUg1OzA';

  @override
  Widget build(BuildContext context) {
    return Placeholder();
    // return Scaffold(
    //   body: FutureBuilder(
    //     future: _acquireCurrentPosition(),
    //     builder: (BuildContext context, AsyncSnapshot snapshot) =>
    //         snapshot.hasData
    //             ? MapboxMap(
    //                 accessToken: mapboxToken,
    //                 minMaxZoomPreference: MinMaxZoomPreference.unbounded,
    //                 compassEnabled: false,
    //                 initialCameraPosition: const CameraPosition(
    //                   target: LatLng(33.589886, -7.603869),
    //                 ),
    //               )
    //             : Center(
    //                 child: CircularProgressIndicator(),
    //               ),
    //   ),
    // );
  }

  // Future<LatLng> _acquireCurrentPosition() async {
  //   Position position = await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.high,
  //   );
  //   return LatLng(position.latitude, position.longitude);
  // }
}
