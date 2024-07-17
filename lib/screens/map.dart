// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:mapbox_gl/mapbox_gl.dart';
// import 'package:provider/provider.dart';
// import 'package:taxi_app/providers/app_provider.dart';
// import 'package:taxi_app/providers/map_provider.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:taxi_app/utils/utils.dart';

// class Map extends StatefulWidget {
//   const Map({
//     super.key,
//   });

//   @override
//   State<Map> createState() => _MapState();
// }

// class _MapState extends State<Map> {
//   final String mapboxToken =
//       'pk.eyJ1IjoicG9jbGFtIiwiYSI6ImNscG12aGJ0ZDBleWYyaXQzd2ttYmgxa2gifQ.SUnhhd7SdBF5J0reUg1OzA';
//   MapboxMapController? cont;
//   @override
//   void initState() {
//     super.initState();
    
//     _acquireCurrentPosition().then(
//       (value) {
//         context.read<MapProvider>().setCurrentLocation(value);
//       },
//     );
//   }

//   @override
//   void dispose() {
//     if (cont != null) {
//       cont!.dispose();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _mapProvider = Provider.of<MapProvider>(context, listen: false);
//     final _appProvider = Provider.of<AppProvider>(context, listen: false);

//     return Scaffold(
//       body: FutureBuilder<LatLng>(
//           future: _acquireCurrentPosition(),
//           builder: (context, snapshot) {
//             log("message");
//             if (snapshot.hasData) {
//               LatLng currentLocation = snapshot.data!;
//               return MapboxMap(
//                 accessToken: mapboxToken,
//                 minMaxZoomPreference: MinMaxZoomPreference(12, 18.0),
//                 compassEnabled: false,
                
//                 // initialCameraPosition: const CameraPosition(
//                 //   target: LatLng(33.589886, -7.603869),
//                 //   zoom: 15.0,
//                 // ),
//                 // myLocationEnabled: true,
                
//                 initialCameraPosition: CameraPosition(
//                   target: currentLocation,
//                   zoom: 15.0,
//                 ),
//                 trackCameraPosition: true,

//                 onMapCreated: (controller) {
//                   _mapProvider.setMapController(controller);
//                   cont = controller;
//                   showPickingLocationSheet(context);

//                   cont!.addListener(() {
//                     _mapProvider.setIsDraging(cont!.isCameraMoving);
//                   },);
                  

//                 },

//                 onCameraTrackingChanged: (mode) {
                  
//                 },
//                 onMapClick: (point, coordinates) {
                  
//                   log('Picked location: $coordinates');
//                   LatLng node =
//                       _mapProvider.mapboxMapController!.cameraPosition!.target;
//                   log(node.toString());
//                   log(coordinates.toString());
//                   _mapProvider.setIsPickingLocation(false);
//                   _mapProvider.setToLocation(
//                     LatLng(coordinates.latitude, coordinates.longitude),
//                   );

//                   cont!.addSymbol(
//                     SymbolOptions(
//                       geometry: LatLng(
//                         coordinates.latitude,
//                         coordinates.longitude,
//                       ),
//                       iconImage: "assets/question.png",
//                     ),
//                   );
//                   cont!.addSymbol(
//                     SymbolOptions(
//                       geometry: LatLng(
//                         cont!.cameraPosition!.target.latitude,
//                         cont!.cameraPosition!.target.longitude,
//                       ),
//                       iconImage: "assets/history.png",
//                     ),
//                   );
//                 },
//               );
//             } else {
//               return const Center(
//                 child: Padding(
//                   padding: EdgeInsets.only(bottom: 30),
//                   child: CircularProgressIndicator(),
//                 ),
//               );
//             }
//           }),
//     );
//   }

//   Future<LatLng> _acquireCurrentPosition() async {
//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );
//     return LatLng(position.latitude, position.longitude);
//   }
// }
