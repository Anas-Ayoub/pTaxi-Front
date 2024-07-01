import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:provider/provider.dart';
import 'package:taxi_app/constant/const.dart';
import 'package:taxi_app/providers/app_provider.dart';
import 'package:taxi_app/providers/map_provider.dart';
import 'package:taxi_app/providers/progress_dialog_provider.dart';
import 'package:taxi_app/screens/map.dart';
import 'package:taxi_app/utils/utils.dart';
import 'package:taxi_app/widgets/bottom_sheet.dart';
import 'package:taxi_app/widgets/primary_button.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Widget sheetContent = DraggableBottomSheet(content: Padding(
  //   padding: const EdgeInsets.all(8.0),
  //   child:
  // ),);
  @override
  Widget build(BuildContext context) {
    final _mapProvider = Provider.of<MapProvider>(context, listen: true);
    final _appProvider = Provider.of<AppProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Stack(
        children: [
          // TextButton(
          //   onPressed: () {
          //     setState(
          //       () {
          //         sheetContent = DraggableBottomSheet(
          //           maxHeight: 0.5,
          //         );
          //       },
          //     );
          //   },
          //   child: Center(
          //     child: Text("child"),
          //   ),
          // ),
          Map(),
          Visibility(
            visible: _mapProvider.isPickingLocation,
            child: Center(
              child: Icon(
                Icons.location_on,
                size: 50,
                color: Colors.red,
              ),
            ),
          ),
          Visibility(
            visible: _mapProvider.isPickingLocation,
            child: Positioned(
              bottom: 50,
              right: 10,
              left: 10,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: PrimaryButton(
                      elevation: 20,
                      text: "Cancel",
                      onPressed: () {},
                      color: errorColor,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 3,
                    child: PrimaryButton(
                      elevation: 20,
                      text: "Confirme",
                      onPressed: () {

                        LatLng node = _mapProvider
                            .mapboxMapController!.cameraPosition!.target;
                        log('Picked location: $node');
                        _appProvider.showSheet();
                        
                        _mapProvider.setPickingLocation(false);
                        
                        _mapProvider.setToLocation(LatLng(node.latitude, node.longitude));

                        
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const DraggableBottomSheet(),
        ],
      ),
    );
  }
}
