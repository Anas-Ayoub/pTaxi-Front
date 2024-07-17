import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/routing.dart';
import 'package:provider/provider.dart';
import 'package:taxi_app/constant/const.dart';
import 'package:taxi_app/providers/map_provider.dart';
import 'package:here_sdk/routing.dart' as here;
import 'package:taxi_app/services/here_service.dart';
import 'package:taxi_app/utils/utils.dart';
import 'package:taxi_app/widgets/buttons/primary_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class PickLocationSheetContent extends StatefulWidget {
  const PickLocationSheetContent({Key? key}) : super(key: key);

  @override
  State<PickLocationSheetContent> createState() =>
      _PickLocationSheetContentState();
}

class _PickLocationSheetContentState extends State<PickLocationSheetContent> {


  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<MapProvider>(context, listen: true);
    TextEditingController toLocationName =
        TextEditingController(text: mapProvider.toLocationName);
    String currentLocationName = mapProvider.currentLocationName;
    int nbPassenger = mapProvider.nbPassenger;
    return ClipRRect(
      // borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 5),
                      leading: InkWell(
                        onTap: () {
                          animateToUserLocation(context);
                          // HereMapController? con =
                          //     mapProvider.mapController;
                          // Position? currentPos = mapProvider.currentLocation;
                          // if (con != null && currentPos != null) {
                          //   double currentZoom = con.cameraPosition!.zoom;
                          //   CameraPosition newCameraPosition = CameraPosition(
                          //     target: currentPos,
                          //     zoom: currentZoom + 1,
                          //   );
                          //   con.animateCamera(CameraUpdate.newCameraPosition(
                          //       newCameraPosition));
                          // }
                        },
                        child: Icon(
                          Icons.gps_fixed,
                          size: 30,
                          color: Colors.cyan,
                        ),
                      ),
                      title: Text(
                        AppLocalizations.of(context)!.thisYourAutomatedLocation,
                        style: getFontStyle(context)
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        currentLocationName,
                        style: getFontStyle(context)
                            .copyWith(color: Colors.black.withOpacity(0.5)),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Provider.of<AppProvider>(context, listen: false)
                        //     .addCardItem();
                        Navigator.pop(context);
                        mapProvider.setIsPickingLocation(true);
                      },
                      child: TextField(
                        
                        enabled: false,
                        style: getFontStyle(context).copyWith(
                            fontWeight: FontWeight.bold, fontSize: 15),
                        controller: toLocationName,
                        
                        decoration: InputDecoration(
                          
                          hintText: "Where would like to go ?",

                          disabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                          contentPadding: EdgeInsets.all(13),
                          prefixIcon: IconButton(
                            iconSize: 40,
                            onPressed: () {
                              Navigator.pop(context);
                              mapProvider.setIsPickingLocation(true);
                            },
                            icon: Icon(
                              Icons.location_on,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            iconSize: 40,
                            onPressed: () {
                              mapProvider.decreaseNbPassenger();
                            },
                            icon: Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                            style: IconButton.styleFrom(
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                nbPassenger.toString(),
                                style: getFontStyle(context).copyWith(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(AppLocalizations.of(context)!.passengerS),
                            ],
                          ),
                          IconButton(
                            iconSize: 40,
                            onPressed: () {
                              // _audioPlayer.play(_audioPlayer.source??AssetSource('sounds/pop3.mp3'));
                              // rideRequestNotify(player);
                              // Vibration.vibrate(duration: 200);
                              // rideRequestNotify();
                              mapProvider.increaseNbPassenger();
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            style: IconButton.styleFrom(
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    PrimaryButton(
                      text: AppLocalizations.of(context)!.next,
                      onPressed: () {
                        GeoCoordinates? source =
                            context.read<MapProvider>().currentLocation;
                        GeoCoordinates? destination =
                            context.read<MapProvider>().toLocationLatLng;

                        if (source != null && destination != null) {
                          log("READY TO DRAW");
                          Waypoint startWaypoint =
                              Waypoint.withDefaults(source);
                          Waypoint destinationWaypoint =
                              Waypoint.withDefaults(destination);
                          List<Waypoint> waypoints = [
                            startWaypoint,
                            destinationWaypoint
                          ];
                          CarOptions carOptions = CarOptions();
                          context
                              .read<MapProvider>()
                              .routingEngine!
                              .calculateCarRoute(
                            waypoints,
                            carOptions,
                            (routingError, routeList) async {
                              if (routingError == null) {
                                here.Route route = routeList!.first;
                                mapProvider.setCurrentRoute(route);
                                showRouteOnMap(route, context);
                                animateToRoute(route, context);
                                saveRouteDetails(route, context);
                                showTripOverviewSheet(context);
                              } else {
                                var error = routingError.toString();
                                log('Error while calculating a route: $error');
                              }
                            },
                          );
                          //GETTING ROUTE FROM API
                          // getOptimizedRoute(source, destination).then(
                          //   (response) async {
                          //     Map<String, dynamic> geo =
                          //         response['trips'][0]['geometry'];

                          //     Object fills = {
                          //       "type": "FeatureCollection",
                          //       "features": [
                          //         {
                          //           "type": "Feature",
                          //           "id": 0,
                          //           "properties": <String, dynamic>{},
                          //           "geometry": geo,
                          //         },
                          //       ],
                          //     };

                          //     //DRAWING ROUTE PATH
                          //     await mapProvider.mapboxMapController!
                          //         .removeLayer("lines");
                          //     await mapProvider.mapboxMapController!
                          //         .removeSource("fills");

                          //     await mapProvider.mapboxMapController!.addSource(
                          //       "fills",
                          //       GeojsonSourceProperties(data: fills),
                          //     );
                          //     await mapProvider.mapboxMapController!
                          //         .addLineLayer(
                          //       "fills",
                          //       "lines",
                          //       const LineLayerProperties(
                          //         lineColor: '#007AFF',
                          //         lineCap: "round",
                          //         lineJoin: "round",
                          //         lineWidth: 4,
                          //       ),
                          //     );

                          //     showTripOverviewSheet(context);
                          //     //FOCUSING ON DRAWN ROUTE
                          //     focusCameraOnBounds(context, source, destination);
                          //   },
                          // );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
