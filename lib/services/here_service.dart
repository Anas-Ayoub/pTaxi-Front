import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:here_sdk/gestures.dart';
import 'package:here_sdk/mapview.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/search.dart';
import 'package:provider/provider.dart';
import 'package:taxi_app/constant/const.dart';
import 'package:taxi_app/providers/map_provider.dart';
import 'package:here_sdk/routing.dart' as here;
import 'package:here_sdk/animation.dart' as here;
import 'package:taxi_app/providers/progress_dialog_provider.dart';
import 'package:taxi_app/utils/utils.dart';
import 'package:timelines/timelines.dart';

Future<String?> getAddressForCoordinates(
    GeoCoordinates geoCoordinates, BuildContext context) async {
  SearchEngine _searchEngine = context.read<MapProvider>().searchEngine!;
  SearchOptions reverseGeocodingOptions = SearchOptions();
  reverseGeocodingOptions.languageCode = LanguageCode.enGb;
  reverseGeocodingOptions.maxItems = 1;
  List<Place>? list;
  _searchEngine.searchByCoordinates(geoCoordinates, reverseGeocodingOptions,
      (SearchError? searchError, List<Place>? list) async {
    if (searchError != null) {
      log("Reverse geocoding Error: " + searchError.toString());
      return;
    }

    // If error is null, list is guaranteed to be not empty.
    log("Reverse geocoded address: ${list!}");
    log(list!.toString());
    log(list!.first.toString());
    log(list!.first.address.toString());
    log(list!.first.address.addressText);
    list = list;
    // log("Reverse geocoded address:", list!.first.address.addressText);
  });
  return list!.first.address.addressText;
}

showRouteOnMap(here.Route route, BuildContext context) {
  log(context.read<MapProvider>().mapPolylines.length.toString());
  context.read<MapProvider>().clearMap();
  HereMapController controller = context.read<MapProvider>().mapController!;
  // Show route as polyline.
  GeoPolyline routeGeoPolyline = route.geometry;
  double widthInPixels = 20;
  Color polylineColor = primaryColor.withOpacity(0.75);
  MapPolyline routeMapPolyline;
  try {
    routeMapPolyline = MapPolyline.withRepresentation(
        routeGeoPolyline,
        MapPolylineSolidRepresentation(
            MapMeasureDependentRenderSize.withSingleSize(
                RenderSizeUnit.pixels, widthInPixels),
            polylineColor,
            LineCap.round));
    controller.mapScene.addMapPolyline(routeMapPolyline);
    context.read<MapProvider>().addMapPolyline(routeMapPolyline);
  } on MapPolylineRepresentationInstantiationException catch (e) {
    print("MapPolylineRepresentation Exception:" + e.error.name);
    return;
  } on MapMeasureDependentRenderSizeInstantiationException catch (e) {
    print("MapMeasureDependentRenderSize Exception:" + e.error.name);
    return;
  }
}

void animateToRoute(here.Route route, BuildContext context) {
  HereMapController controller = context.read<MapProvider>().mapController!;
  // The animation results in an untilted and unrotated map.
  double bearing = 0;
  double tilt = 0;
  // We want to show the route fitting in the map view with an additional padding of 50 pixels.
  double screenHeight = controller.viewportSize.height;
  double screenWidth = controller.viewportSize.width;
  double upperHalfHeight = screenHeight / 2;
  Point2D origin = Point2D(150, 150);
  Size2D sizeInPixels = Size2D(screenWidth - 300, upperHalfHeight - 300);
  Rectangle2D mapViewport = Rectangle2D(origin, sizeInPixels);

  // Animate to the route within a duration of 1 seconds.
  MapCameraUpdate update =
      MapCameraUpdateFactory.lookAtAreaWithGeoOrientationAndViewRectangle(
          route.boundingBox, GeoOrientationUpdate(bearing, tilt), mapViewport);

  MapCameraAnimation animation =
      MapCameraAnimationFactory.createAnimationFromUpdateWithEasing(
    update,
    const Duration(milliseconds: 800), //1000
    // here.Easing(here.EasingFunction.inCubic),
    here.Easing(here.EasingFunction.outBack),
  );
  controller.camera.startAnimation(animation);
}

void zoomCameraTo(BuildContext context, double distanceMeters) {
  MapProvider provider = context.read<MapProvider>();
  double distanceToEarthInMeters = distanceMeters;
  MapMeasure mapMeasureZoom =
      MapMeasure(MapMeasureKind.distance, distanceToEarthInMeters);
  provider.mapController!.camera.lookAtPointWithMeasure(
    provider.currentLocation!,
    mapMeasureZoom,
  );
}

void saveRouteDetails(here.Route route, BuildContext context) {
  // estimatedTravelTimeInSeconds includes traffic delay.
  int estimatedTravelTimeInMinutes = route.duration.inMinutes;
  int estimatedTrafficDelay = route.trafficDelay.inMinutes;
  int lengthInMeters = route.lengthInMeters;
  String lengthInKilometers = _formatLength(lengthInMeters);
  context
      .read<MapProvider>()
      .setTravelTimeInMinutes(estimatedTravelTimeInMinutes);
  context.read<MapProvider>().setTrafficDelay(estimatedTrafficDelay);
  context.read<MapProvider>().setLengthInKilometers(lengthInKilometers);
}

String _formatLength(int meters) {
  int kilometers = meters ~/ 1000;
  int remainingMeters_3nbs = meters % 1000;
  int remainingMeters_2nbs = remainingMeters_3nbs ~/ 100;

  return '$kilometers.$remainingMeters_2nbs';
}

void flyToUserLocation(BuildContext context) {
  MapProvider provider = context.read<MapProvider>();
  log("flyed to user location, CURRENT = ${provider.currentLocation!.latitude}");

  double distanceToEarthInMeters = 4000;
  MapMeasure mapMeasureZoom =
      MapMeasure(MapMeasureKind.distance, distanceToEarthInMeters);

  provider.mapController!.camera.lookAtPointWithMeasure(
    GeoCoordinates(33.58876, -7.4985328),
    mapMeasureZoom,
  );
}

void animateToUserLocation(BuildContext context) {
  MapProvider provider = context.read<MapProvider>();
  double latitude = provider.currentLocation!.latitude;
  double longitude = provider.currentLocation!.longitude;
  MapCameraUpdate update = MapCameraUpdateFactory.lookAtPoint(
      GeoCoordinatesUpdate(latitude, longitude));
  MapCameraAnimation animation =
      MapCameraAnimationFactory.createAnimationFromUpdateWithEasing(
          update,
          const Duration(milliseconds: 1000),
          here.Easing(here.EasingFunction.inCubic));
  provider.mapController!.camera.startAnimation(animation);
}

void animateToLocation(BuildContext context, GeoCoordinates location) {
  MapProvider provider = context.read<MapProvider>();
  double latitude = location.latitude;
  double longitude = location.longitude;
  MapCameraUpdate update = MapCameraUpdateFactory.lookAtPoint(
      GeoCoordinatesUpdate(latitude, longitude));
  MapCameraAnimation animation =
      MapCameraAnimationFactory.createAnimationFromUpdateWithEasing(
          update,
          const Duration(milliseconds: 1000),
          here.Easing(here.EasingFunction.inCubic));

  provider.mapController!.camera.startAnimation(animation);
}

void addLocationIndicator(BuildContext context) {
  MapProvider provider = context.read<MapProvider>();
  LocationIndicator locationIndicator = LocationIndicator();
  locationIndicator.locationIndicatorStyle =
      LocationIndicatorIndicatorStyle.pedestrian;

  // A LocationIndicator is intended to mark the user's current location,
  // including a bearing direction.
  Location location = Location.withCoordinates(provider.currentLocation!);
  location.time = DateTime.now();
  // location.bearingInDegrees = _getRandom(0, 360);

  locationIndicator.updateLocation(location);

  // Show the indicator on the map view.
  locationIndicator.enable(provider.mapController!);

  provider.addLocationIndicator(locationIndicator);
}

void loadMapStyle(BuildContext context) {
  HereMapController controller = context.read<MapProvider>().mapController!;
  controller.mapScene.loadSceneForMapScheme(MapScheme.normalDay,
      (MapError? error) {
    if (error == null) {
      addLocationIndicator(context);
      flyToUserLocation(context);
    } else {
      log("Original Map scene not loaded. MapError: " + error.toString());
    }
  });
  // File file = File("assets/pTaxi.json");
  // String filePath = file.path;
  // controller.mapScene.loadSceneFromConfigurationFile(filePath,
  //     (MapError? error) {
  //   if (error == null) {
  //     addLocationIndicator(context);
  //     flyToUserLocation(context);
  //   } else {
  //     print(
  //         "Custom Styled Map scene not loaded. MapError: " + error.toString());
  //     controller.mapScene.loadSceneForMapScheme(MapScheme.normalDay,
  //         (MapError? error) {
  //       if (error == null) {
  //         addLocationIndicator(context);
  //         flyToUserLocation(context);
  //       } else {
  //         log("Original Map scene not loaded. MapError: " + error.toString());
  //       }
  //     });
  //   }
  // });
}

void disableGesture(BuildContext context) {
  HereMapController controller = context.read<MapProvider>().mapController!;
  controller.gestures.disableDefaultAction(GestureType.pan);
  controller.gestures.disableDefaultAction(GestureType.pinchRotate);
  controller.gestures.disableDefaultAction(GestureType.twoFingerPan);
  controller.gestures.disableDefaultAction(GestureType.twoFingerTap);
  controller.gestures.disableDefaultAction(GestureType.doubleTap);
}

void enableGesture(BuildContext context) {
  HereMapController controller = context.read<MapProvider>().mapController!;
  controller.gestures.enableDefaultAction(GestureType.pan);
  controller.gestures.enableDefaultAction(GestureType.pinchRotate);
  controller.gestures.enableDefaultAction(GestureType.twoFingerPan);
  controller.gestures.enableDefaultAction(GestureType.twoFingerTap);
  controller.gestures.enableDefaultAction(GestureType.doubleTap);
}
