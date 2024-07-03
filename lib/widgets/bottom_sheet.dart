import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:provider/provider.dart';
import 'package:taxi_app/constant/const.dart';
import 'package:taxi_app/providers/app_provider.dart';
import 'package:taxi_app/providers/map_provider.dart';
import 'package:taxi_app/services/authentication_service.dart';
import 'package:taxi_app/services/mapbox_service.dart';
import 'package:taxi_app/utils/utils.dart';
import 'package:taxi_app/widgets/phone_text_field.dart';
import 'package:taxi_app/widgets/primary_button.dart';
import 'package:taxi_app/widgets/primary_textfield.dart';
import 'package:taxi_app/widgets/test.dart';

class DraggableBottomSheet extends StatefulWidget {
  // final double maxHeight;
  // final Widget content;
  const DraggableBottomSheet({
    super.key,
    // this.maxHeight = 0.5,
  });

  @override
  State<DraggableBottomSheet> createState() => _DraggableBottomSheetState();
}

class _DraggableBottomSheetState extends State<DraggableBottomSheet> {
  late DraggableScrollableController _bottomSheetController;
  final double _minHeight = 0.04;
  final double _maxHeight = 0.4;
  bool _canDrag = true;
  int nbPassenges = 1;
  @override
  void initState() {
    super.initState();
    _bottomSheetController = DraggableScrollableController();
  }

  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<MapProvider>(context, listen: true);
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.setBottomSheetController(_bottomSheetController);
    appProvider.setMinMaxHeight(_minHeight, _maxHeight);
    TextEditingController toLocation =
        TextEditingController(text: mapProvider.toLocationName);

    return DraggableScrollableSheet(
      controller: _bottomSheetController,
      snap: true,
      snapSizes: [],
      initialChildSize: _maxHeight,
      minChildSize: _minHeight,
      maxChildSize: _maxHeight,
      builder: (_, controller) => ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
        child: Container(
          padding: const EdgeInsets.only(
            left: 0,
            right: 0,
          ),
          color: Colors.white,
          child: SingleChildScrollView(
            controller: controller,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    if (_bottomSheetController.size == _maxHeight) {
                      _bottomSheetController.animateTo(
                        _minHeight,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      if (_canDrag) {
                        _bottomSheetController.animateTo(
                          _maxHeight,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                        );
                      }
                    }
                  },
                  child: Container(
                    // color: Color.fromARGB(12, 0, 0, 0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 25,

                      // decoration:
                      //     BoxDecoration(border: Border.all(width: 3)),
                      child: Center(
                        child: Container(
                          width: 75,
                          height: 5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromARGB(133, 0, 0, 0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                //widget.content,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 5),
                        leading: InkWell(
                          onTap: () {
                            MapboxMapController? con =
                                mapProvider.mapboxMapController;
                            LatLng? currentPos = mapProvider.currentLocation;
                            if (con != null && currentPos != null) {
                              double currentZoom = con.cameraPosition!.zoom;
                              CameraPosition newCameraPosition = CameraPosition(
                                target: currentPos,
                                zoom: currentZoom + 1,
                              );
                              con.animateCamera(CameraUpdate.newCameraPosition(
                                  newCameraPosition));
                            }
                          },
                          child: Icon(
                            Icons.gps_fixed,
                            size: 30,
                            color: Colors.cyan,
                          ),
                        ),
                        title: Text(
                          "This your automated location",
                          style: getFontStyle(context)
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(mapProvider.currentLocationName,
                            style: getFontStyle(context).copyWith(
                                color: Colors.black.withOpacity(0.5))),
                      ),
                      TextField(
                        style: getFontStyle(context).copyWith(
                            fontWeight: FontWeight.bold, fontSize: 18),
                        controller: toLocation,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(13),
                          prefixIcon: IconButton(
                            iconSize: 40,
                            onPressed: () {
                              appProvider.hideSheet();
                              _canDrag = false;
                              mapProvider.setPickingLocation(true);
                            },
                            icon: Icon(
                              Icons.location_on,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              iconSize: 40,
                              onPressed: () {
                                if (nbPassenges > 1) {
                                  setState(() {
                                    nbPassenges = nbPassenges - 1;
                                  });
                                }
                              },
                              icon: Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
                              style: IconButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            Text(
                              nbPassenges.toString(),
                              style: getFontStyle(context).copyWith(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              iconSize: 40,
                              onPressed: () {
                                if (nbPassenges < 4) {
                                  setState(() {
                                    nbPassenges = nbPassenges + 1;
                                  });
                                }
                              },
                              icon: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              style: IconButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      PrimaryButton(
                        text: "Find Driver",
                        onPressed: () {
                          LatLng? source =
                              context.read<MapProvider>().currentLocation;
                          LatLng? destination =
                              context.read<MapProvider>().toLocationLatLng;

                          if (source != null && destination != null) {
                            getOptimizedRoute(source, destination).then(
                              (response) async {
                                Map<String, dynamic> geo =
                                    response['trips'][0]['geometry'];

                                Object _fills = {
                                  "type": "FeatureCollection",
                                  "features": [
                                    {
                                      "type": "Feature",
                                      "id": 0,
                                      "properties": <String, dynamic>{},
                                      "geometry": geo,
                                    },
                                  ],
                                };

                                await mapProvider.mapboxMapController!
                                    .removeLayer("lines");
                                await mapProvider.mapboxMapController!
                                    .removeSource("fills");

                                await mapProvider.mapboxMapController!
                                    .addSource("fills",
                                        GeojsonSourceProperties(data: _fills));
                                await mapProvider.mapboxMapController!
                                    .addLineLayer(
                                  "fills",
                                  "lines",
                                  const LineLayerProperties(
                                    lineColor: '#007AFF',
                                    lineCap: "round",
                                    lineJoin: "round",
                                    lineWidth: 4,
                                  ),
                                );
                                LatLngBounds bounds = LatLngBounds(
                                  southwest: LatLng(
                                    source.latitude < destination.latitude
                                        ? source.latitude
                                        : destination.latitude,
                                    source.longitude < destination.longitude
                                        ? source.longitude
                                        : destination.longitude,
                                  ),
                                  northeast: LatLng(
                                    source.latitude > destination.latitude
                                        ? source.latitude
                                        : destination.latitude,
                                    source.longitude > destination.longitude
                                        ? source.longitude
                                        : destination.longitude,
                                  ),
                                );
                                CameraUpdate cameraUpdate =
                                    CameraUpdate.newLatLngBounds(bounds,
                                        top: 100,
                                        bottom: getScreenHeight(context) * 0.5,
                                        right: 100,
                                        left: 100);
                                log("sdfafsfd");
                                await mapProvider.mapboxMapController!
                                    .animateCamera(cameraUpdate)
                                    .then(
                                  (value) {
                                    log("Animated");
                                    mapProvider.mapboxMapController!
                                        .getVisibleRegion()
                                        .then(
                                      (value) {
                                        mapProvider.mapboxMapController!
                                            .animateCamera(
                                                CameraUpdate.newLatLngBounds(
                                                    value));
                                      },
                                    );
                                  },
                                );
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      //onStateChanged: (val) => setState(() => _currentHeight = val * widget.maxHeight),
    );
  }
}
