import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:here_sdk/routing.dart';
import 'package:here_sdk/search.dart';
import 'package:provider/provider.dart';
import 'package:taxi_app/constant/const.dart';
import 'package:taxi_app/providers/app_provider.dart';
import 'package:taxi_app/providers/map_provider.dart';
import 'package:taxi_app/providers/progress_dialog_provider.dart';
import 'package:taxi_app/ride_requests.dart';
import 'package:taxi_app/services/here_service.dart';
import 'package:taxi_app/ride_request_card.dart';
import 'package:taxi_app/utils/utils.dart';
import 'package:taxi_app/widgets/buttons/primary_button.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/mapview.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:taxi_app/widgets/geocoding_search_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:app_settings/app_settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late RoutingEngine _routingEngine;
  late SearchEngine _searchEngine;
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isLocatoinGranted = true;
  bool isLocationServiceEnabled = true;
  List<Color> bgColors = [
    Color.fromARGB(57, 0, 187, 212).withOpacity(0.7),
    Color.fromARGB(0, 54, 198, 255),
  ];
  bool _isCameraMoving = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    context.read<AppProvider>().setMainScreenContext(context);
    StreamSubscription<ServiceStatus> serviceStatusStream =
        Geolocator.getServiceStatusStream().listen((ServiceStatus status) {
      setState(() {
        log(status.name);
        if (status == ServiceStatus.enabled) {
          isLocationServiceEnabled = true;
          _setInitialPosition();
        } else {
          isLocationServiceEnabled = false;
        }
      });
    });
    _timer?.cancel();
    // _hereMapController?.camera?.removeCameraListener();
//Fade Animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _animation = Tween<double>(begin: 0.3, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves
            .easeInOutCirc, //Curves.easeInOutCirc, Curves.easeInOutQuint, Curves.fastOutSlowIn, Curves.easeInOut
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final _mapProvider = Provider.of<MapProvider>(context, listen: true);
    final _appProvider = Provider.of<AppProvider>(context, listen: true);
    _isCameraMoving = _mapProvider.isDraging;
    return Scaffold(
        backgroundColor: Colors.grey,
        body: Stack(
          children: [
            HereMap(
              onMapCreated: (mapController) {
                mapController.camera.addListener(MapCameraListener(
                  (p0) {
                    _onCameraMove();
                  },
                ));
                _initializeEngines();
                context.read<MapProvider>().setMapController(mapController);
                _setInitialPosition();
              },
            ),
            Center(
              child: Visibility(
                visible: _mapProvider.isFindingTaxi,
                child: RippleAnimation(
                  color: Colors.cyan,
                  delay: const Duration(milliseconds: 1000),
                  repeat: true,
                  minRadius: 50,
                  ripplesCount: 3,
                  duration: const Duration(milliseconds: 3000),
                  child: Container(),
                ),
              ),
            ),
            Visibility(
              visible:
                  _mapProvider.isFindingTaxi && _appProvider.cards.isNotEmpty,
              child: Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
            ),
            // Positioned(top: 450,left: 100, child: Text(_appProvider.cards.length.toString(), style: TextStyle(fontSize: 50),)),
            Visibility(
              visible: true,
              child: const RideRequests(),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Visibility(
                    visible: !isLocationServiceEnabled,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/locationService.png",
                              width: 45,
                              color: Colors.black.withOpacity(0.2),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              AppLocalizations.of(context)!
                                  .pleaseEnableLocationService,
                              textAlign: TextAlign.center,
                              style: getFontStyle(context).copyWith(
                                  fontSize: 19, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            FilledButton(
                              onPressed: _setInitialPosition,
                              style: FilledButton.styleFrom(
                                  backgroundColor: primaryColor),
                              child: Text(
                                  AppLocalizations.of(context)!.grantAccess),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: !isLocatoinGranted,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/bored.png",
                              width: 50,
                              color: Colors.black.withOpacity(0.2),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              AppLocalizations.of(context)!
                                  .weNeedLocationPermissionToContinue,
                              textAlign: TextAlign.center,
                              style: getFontStyle(context).copyWith(
                                  fontSize: 19, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            FilledButton(
                              onPressed: _setInitialPosition,
                              style: FilledButton.styleFrom(
                                  backgroundColor: primaryColor),
                              child: Text(
                                  AppLocalizations.of(context)!.grantAccess),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: _mapProvider.isPickingLocation,
              child: const Positioned(
                top: 40,
                right: 5,
                left: 5,
                child: GeocodingSearchBar(),
              ),
            ),

            Visibility(
              visible: _mapProvider.isPickingLocation,
              child: _isCameraMoving
                  ? Center(
                      child: Image.asset(
                        "assets/pinUp.png",
                        width: 100,
                      ),
                    )
                  : Center(
                      child: Image.asset(
                        "assets/pinDown.png",
                        width: 100,
                      ),
                    ),
            ),
            Visibility(
              visible: _mapProvider.isPickingLocation,
              child: Positioned(
                bottom: 30,
                right: 10,
                left: 10,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: PrimaryButton(
                        elevation: 20,
                        text: AppLocalizations.of(context)!.cancel,
                        onPressed: () {
                          showPickingLocationSheet(context);
                          _mapProvider.setIsPickingLocation(false);
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
                        text: AppLocalizations.of(context)!.confirm,
                        onPressed: () {
                          showPickingLocationSheet(context);
                          GeoCoordinates node = context
                              .read<MapProvider>()
                              .mapController!
                              .camera
                              .state
                              .targetCoordinates;
                          log('Picked location: $node');
                          // _appProvider.showSheet();

                          _mapProvider.setIsPickingLocation(false);

                          _mapProvider.setToLocation(node, context);
                          MapMarker pinMarker = MapMarker(
                            node,
                            MapImage.withFilePathAndWidthAndHeight(
                                "assets/pinDown.png", 250, 250),
                          );
                          _mapProvider.mapController!.mapScene
                              .addMapMarker(pinMarker);
                          _mapProvider.mapMarkers.add(pinMarker);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // const DraggableBottomSheet(),
          ],
        ));
  }

  Future<Position?> _setInitialPosition() async {
    log("in _setInitialPosition");
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    log("serviceEnabled  = $serviceEnabled");

    if (!serviceEnabled) {
      // Location services are not enabled, don't continue.
      AppSettings.openAppSettings(type: AppSettingsType.location);
      setState(() {
        isLocationServiceEnabled = false;
      });
      return null;
    }

    permission = await Geolocator.checkPermission();

    log(permission.name);
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      log(permission.name);

      if (permission == LocationPermission.denied) {
        // Permissions are denied, don't continue.

        log("Permissions are denied");

        setState(() {
          isLocatoinGranted = false;
        });
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        isLocatoinGranted = false;
      });
      // Permissions are denied forever, don't continue.
      Geolocator.openAppSettings();
      log("Permissions are denied forever");
      return null;
    }

    // When permissions are granted, get the current position.

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      isLocatoinGranted = true;
    });
    log("permissions are granted,  current position = ${position}");
    MapProvider provider = context.read<MapProvider>();
    provider.setCurrentLocation(
        GeoCoordinates(position.latitude, position.longitude), context);
    loadMapStyle(context);
    showPickingLocationSheet(context);
    return position;
  }

  void _initializeEngines() {
    try {
      _routingEngine = RoutingEngine();
      _searchEngine = SearchEngine();
      log('Engines initialized successfully.');
    } catch (e) {
      log('Error initializing engines: $e');
    }
    context.read<MapProvider>().setRoutingEngine(_routingEngine);
    context.read<MapProvider>().setSearchEngine(_searchEngine);
  }

  void _onCameraMove() {
    if (_timer != null) {
      _timer!.cancel();
    }

    // setState(() {
    //   // _isCameraMoving = true;
    // });
    context.read<MapProvider>().setIsDraging(true);
    _timer = Timer(Duration(milliseconds: 200), () {
      // _isCameraMoving = false;
      context.read<MapProvider>().setIsDraging(false);
      // setState(() {

      // });
    });
  }
}
