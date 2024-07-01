import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mapbox_gl/mapbox_gl.dart';

const String mapboxToken =
    'pk.eyJ1IjoicG9jbGFtIiwiYSI6ImNscG12aGJ0ZDBleWYyaXQzd2ttYmgxa2gifQ.SUnhhd7SdBF5J0reUg1OzA';

Future<String> getPlaceName(LatLng node) async {
  String url =
      'https://api.mapbox.com/geocoding/v5/mapbox.places/${node.longitude},${node.latitude}.json?access_token=${mapboxToken}';

  final response = await http.get(Uri.parse(url));
  // log(response.body);
  if (response.statusCode == 200) {
    Map<String, dynamic> json = jsonDecode(response.body);
    log(json['features'][0]['place_name']);

    return json['features'][0]['place_name'];
  } else {
    throw Exception('Failed to load place name');
  }
}

Future<Map<String, dynamic>> getOptimizedRoute(LatLng start, LatLng end) async {
  String profile = 'mapbox/driving';
  String coordinates =
      '${start.longitude},${start.latitude};${end.longitude},${end.latitude}';
  String url =
      'https://api.mapbox.com/optimized-trips/v1/$profile/$coordinates?overview=full&steps=true&geometries=geojson&source=first&destination=last&roundtrip=false&access_token=${mapboxToken}';
  log(url);
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    Map<String, dynamic> json = jsonDecode(response.body);
    log(json.toString());

    return json;
  } else {
    throw Exception('Failed to load place name');
  }
}
