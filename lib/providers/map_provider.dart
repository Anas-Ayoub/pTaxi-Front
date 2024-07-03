import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_app/providers/progress_dialog_provider.dart';
import 'package:taxi_app/services/mapbox_service.dart';

class MapProvider extends ChangeNotifier {
  MapboxMapController? _mapboxMapController;
  MapboxMapController? get mapboxMapController => _mapboxMapController;
  MapboxMapController? getMapboxMapController(){
    return _mapboxMapController;
  }

  void setMapController(MapboxMapController con) {
    _mapboxMapController = con;
    notifyListeners();
  }

  //   MapboxMapController? _mapboxMapController2;
  // MapboxMapController? get mapboxMapController2 => _mapboxMapController2;
  // void setMapController2(MapboxMapController con) {
  //   _mapboxMapController2 = con;
  //   notifyListeners();
  // }

  bool _isPickingLocation = false;
  bool get isPickingLocation => _isPickingLocation;

  void setPickingLocation(bool val) {
    _isPickingLocation = val;
    notifyListeners();
  }

  LatLng? _toLocationLatLng;
  String _toLocationName = "";
  String get toLocationName => _toLocationName;
  LatLng? get toLocationLatLng => _toLocationLatLng;

  // void setLocationName(String name) {}
  void setToLocation(LatLng val) {
    
    _toLocationLatLng = val;
    getPlaceName(val).then((value) {
      _toLocationName = value;
      notifyListeners();
    });
    // notifyListeners();
  }

  //CURRENT LOCATION
  LatLng? _currentLocation;
  String get currentLocationName => _currentLocationName;

  String _currentLocationName = "";
  LatLng? get currentLocation => _currentLocation;

  // void setLocationName(String name) {}
  void setCurrentLocation(LatLng val) {
    _currentLocation = val;
    getPlaceName(val).then((value) {
      _currentLocationName = value;
      notifyListeners();
    });
    // notifyListeners();
  }
}
