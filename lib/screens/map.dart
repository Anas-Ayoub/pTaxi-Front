import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:provider/provider.dart';
import 'package:taxi_app/providers/map_provider.dart';
import 'package:flutter_map/flutter_map.dart';

class Map extends StatefulWidget {

  const Map({
    super.key,
  });

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  final String mapboxToken =
      'pk.eyJ1IjoicG9jbGFtIiwiYSI6ImNscG12aGJ0ZDBleWYyaXQzd2ttYmgxa2gifQ.SUnhhd7SdBF5J0reUg1OzA';

@override
  void initState() {
    super.initState();
    _acquireCurrentPosition().then((value) {
      context.read<MapProvider>().setCurrentLocation(value);
    },);
  }

  @override
  Widget build(BuildContext context) {
    final _mapProvider = Provider.of<MapProvider>(context, listen: false);
    MapboxMapController cont;

    

    return Scaffold(
      body: FutureBuilder<LatLng>(
          future: _acquireCurrentPosition(),
          builder: (context, snapshot) {
            log("message");
            if (snapshot.hasData){
            
            LatLng currentLocation = snapshot.data!;
            // _mapProvider.setCurrentLocation(currentLocation);
              return MapboxMap(
                    accessToken: mapboxToken,
                    minMaxZoomPreference: MinMaxZoomPreference(12, 18.0),
                    compassEnabled: false,
                    // initialCameraPosition: const CameraPosition(
                    //   target: LatLng(33.589886, -7.603869),
                    //   zoom: 15.0,
                    // ),
                    myLocationEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: currentLocation,
                      zoom: 15.0,
                    ),
                    trackCameraPosition: true,

                    onMapCreated: (controller) {
                      _mapProvider.setMapController(controller);
                      cont = controller;
                      
                    },
                    onMapClick: (point, coordinates) {
                      // log(cont!.cameraPosition!.target.toString());
                    },
                  );
            }
            else{
              return const Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 30),
                      child: CircularProgressIndicator(),
                    ),
                  );
            }
          }),
    );
  }

  Future<LatLng> _acquireCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return LatLng(position.latitude, position.longitude);
  }
}
