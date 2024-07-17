import 'package:flutter/material.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/mapview.dart';

class HereMapTest extends StatefulWidget {
  const HereMapTest({super.key});

  @override
  State<HereMapTest> createState() => _HereMapTestState();
}

class _HereMapTestState extends State<HereMapTest> {

  void _onMapCreated(HereMapController hereMapController) {
    hereMapController.mapScene.loadSceneForMapScheme(MapScheme.normalDay, (MapError? error) {
      if (error != null) {
        print('Map scene not loaded. MapError: ${error.toString()}');
        return;
      }

      const double distanceToEarthInMeters = 8000;
      MapMeasure mapMeasureZoom = MapMeasure(MapMeasureKind.distance, distanceToEarthInMeters);
      hereMapController.camera.lookAtPointWithMeasure(GeoCoordinates(52.530932, 13.384915), mapMeasureZoom);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return HereMap(onMapCreated: _onMapCreated);
  }
}