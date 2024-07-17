import 'dart:developer';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/mapview.dart';
import 'package:here_sdk/routing.dart';
import 'package:here_sdk/search.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_app/providers/progress_dialog_provider.dart';
import 'package:taxi_app/services/here_service.dart';
import 'package:taxi_app/services/mapbox_service.dart';
import 'package:here_sdk/routing.dart' as here;
class MapProvider extends ChangeNotifier {
  //MAP ROUTE
  here.Route? _currentRoute;
  here.Route? get currentRoute => _currentRoute;
  void setCurrentRoute(here.Route route){
    _currentRoute = route;
    notifyListeners();
  }
  //MAP POLYLINES
  List<MapPolyline> _mapPolylines = [];
  List<MapPolyline> get mapPolylines => _mapPolylines;
  void addMapPolyline(MapPolyline mapPolyline) {
    _mapPolylines.add(mapPolyline);
  }

  //LOCATION INDICATORS
  List<LocationIndicator> _locationIndicatorList = [];
  List<LocationIndicator> get locationIndicatorList => _locationIndicatorList;
  void addLocationIndicator(LocationIndicator indicator) {
    _locationIndicatorList.add(indicator);
  }

  //MAP MARKRES
  List<MapMarker> _mapMarkers = [];
  List<MapMarker> get mapMarkers => _mapMarkers;
  void addMapMarker(MapMarker mapMarker) {
    _mapMarkers.add(mapMarker);
  }

  void clearMap() {
    for (var mapPolyline in _mapPolylines) {
      _mapController!.mapScene.removeMapPolyline(mapPolyline);
    }
    // _mapPolylines.clear();
    //     for (var mapMarker in _mapMarkers) {
    //   _mapController!.mapScene.removeMapMarker(mapMarker);
    // }
    // _mapMarkers.clear();
  }

  //HERE ENGINES
  RoutingEngine? _routingEngine;
  RoutingEngine? get routingEngine => _routingEngine;

  void setRoutingEngine(RoutingEngine val) {
    _routingEngine = val;
    notifyListeners();
  }

  SearchEngine? _searchEngine;
  SearchEngine? get searchEngine => _searchEngine;

  void setSearchEngine(SearchEngine val) {
    _searchEngine = val;
    notifyListeners();
  }

  bool _isDraging = false;
  bool get isDraging => _isDraging;

  void setIsDraging(bool val) {
    _isDraging = val;
    notifyListeners();
  }

  HereMapController? _mapController;
  HereMapController? get mapController => _mapController;
  HereMapController? getMapController() {
    return _mapController;
  }

  void setMapController(HereMapController con) {
    _mapController = con;
    log("Controlled initialized");
    notifyListeners();
  }

  bool _isFindingTaxi = false;
  bool get isFindingTaxi => _isFindingTaxi;

  void setIsFindingTaxi(bool val) {
    _isFindingTaxi = val;
    notifyListeners();
  }

  bool _isPickingLocation = false;
  bool get isPickingLocation => _isPickingLocation;

  void setIsPickingLocation(bool val) {
    _isPickingLocation = val;
    notifyListeners();
  }

  GeoCoordinates? _toLocationLatLng;
  String _toLocationName = "";
  String get toLocationName => _toLocationName;
  GeoCoordinates? get toLocationLatLng => _toLocationLatLng;

  void setToLocation(GeoCoordinates val, BuildContext context) {
    _toLocationLatLng = val;
    SearchOptions reverseGeocodingOptions = SearchOptions();
    reverseGeocodingOptions.languageCode = LanguageCode.enGb;
    reverseGeocodingOptions.maxItems = 1;
    log("Current provider location : ${val.latitude}");
    _searchEngine!.searchByCoordinates(
        GeoCoordinates(val.latitude, val.longitude), reverseGeocodingOptions,
        (SearchError? searchError, List<Place>? list) async {
      if (searchError != null) {
        log("Reverse geocodingError: " + searchError.toString());
        return;
      }
      log("Current Provider locaiton Name : ${list!.first.address.addressText}");
      // If error is null, list is guaranteed to be not empty.
      _toLocationName = list!.first.address.addressText;
      notifyListeners();

      // log("Reverse geocoded address:"+ list!.first.address.addressText);
    });
  }

  //CURRENT LOCATION
  GeoCoordinates? _currentLocation;
  String get currentLocationName => _currentLocationName;

  String _currentLocationName = "";
  GeoCoordinates? get currentLocation => _currentLocation;

  void setCurrentLocation(GeoCoordinates val, BuildContext context) {
    _currentLocation = val;
    SearchOptions reverseGeocodingOptions = SearchOptions();
    reverseGeocodingOptions.languageCode = LanguageCode.enGb;
    reverseGeocodingOptions.maxItems = 1;
    log("Current provider location : ${val.latitude}");
    _searchEngine!.searchByCoordinates(
        GeoCoordinates(val.latitude, val.longitude), reverseGeocodingOptions,
        (SearchError? searchError, List<Place>? list) async {
      if (searchError != null) {
        log("Reverse geocodingError: " + searchError.toString());
        return;
      }
      log("Current Provider locaiton Name : ${list!.first.address.addressText}");
      // If error is null, list is guaranteed to be not empty.
      _currentLocationName = list!.first.address.addressText;
      notifyListeners();

      // log("Reverse geocoded address:"+ list!.first.address.addressText);
    });

    notifyListeners();
  }

  int _nbPassenger = 1;
  int get nbPassenger => _nbPassenger;
  static const maxPassenger = 4;

  void increaseNbPassenger() {
    if (_nbPassenger < maxPassenger) {
      _nbPassenger = _nbPassenger + 1;
      notifyListeners();
    }
  }

  void decreaseNbPassenger() {
    if (_nbPassenger > 1) {
      _nbPassenger = _nbPassenger - 1;
      notifyListeners();
    }
  }

  //ROUTE DETAIL
  int _estimatedTravelTimeInMinutes = 0;
  int _trafficDelay = 0;
  String _lengthInKilometers = "";
  int get estimatedTravelTimeInMinutes => _estimatedTravelTimeInMinutes;
  int get trafficDelay => _trafficDelay;
  String get lengthInKilometers => _lengthInKilometers;
  void setTravelTimeInMinutes(int val) {
    _estimatedTravelTimeInMinutes = val;
  }

  void setTrafficDelay(int val) {
    _trafficDelay = val;
  }

  void setLengthInKilometers(String val) {
    _lengthInKilometers = val;
  }
}
