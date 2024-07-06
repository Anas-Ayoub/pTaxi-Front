import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:provider/provider.dart';
import 'package:taxi_app/constant/const.dart';
import 'package:taxi_app/providers/app_provider.dart';
import 'package:taxi_app/providers/map_provider.dart';
import 'package:taxi_app/providers/progress_dialog_provider.dart';
import 'package:taxi_app/widgets/pickLocation_sheetContent.dart';
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
    bool _isDraging = _mapProvider.isDraging;
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Stack(
        children: [
          const Map(),
          // Visibility(
          //   visible: true,
          //   child: SearchAnchor(builder: (context, controller) {
            
          // }, suggestionsBuilder: (context, controller) {
            
          // },)),
          Visibility(
            visible: _mapProvider.isPickingLocation,
            child: _isDraging ? Center(
              child: Image.asset("assets/pinUp.png", width: 100,),
            ) : Center(
              child: Image.asset("assets/pinDown.png", width: 100,),
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
                      onPressed: () {
                        showFindDriverSheet(context);
                        _mapProvider.setPickingLocation(false);
                      },
                      color: errorColor,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 3,
                    child: PrimaryButton(
                      elevation: 20,
                      text: "Confirme",
                      onPressed: () {
                        showFindDriverSheet(context);
                        LatLng node = context
                            .read<MapProvider>()
                            .mapboxMapController!
                            .cameraPosition!
                            .target;
                        log('Picked location: $node');
                        // _appProvider.showSheet();

                        _mapProvider.setPickingLocation(false);

                        _mapProvider.setToLocation(
                            LatLng(node.latitude, node.longitude));

                        _mapProvider.mapboxMapController!.addSymbol(
                          SymbolOptions(
                            geometry: LatLng(
                              node.latitude,
                              node.longitude,
                            ),
                            iconImage: "assets/pinDown.png",
                            iconSize: 1.5,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          // const DraggableBottomSheet(),
        ],
      ),
    );
  }
}
