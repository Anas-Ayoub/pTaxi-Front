import 'package:json_annotation/json_annotation.dart';
import 'ride.dart';
import 'ride_request.dart';

part 'location.g.dart';

@JsonSerializable(explicitToJson: true)
class Location {
  int locationId;
  double latitude;
  double longitude;
  String? address;
  DateTime createdAt;
  DateTime updatedAt;

  @JsonKey(name: 'rideStart')
  List<Ride>? rideStart;

  @JsonKey(name: 'rideEnd')
  List<Ride>? rideEnd;

  @JsonKey(name: 'rideRequestStart')
  List<RideRequest>? rideRequestStart;

  @JsonKey(name: 'rideRequestEnd')
  List<RideRequest>? rideRequestEnd;

  Location({
    required this.locationId,
    required this.latitude,
    required this.longitude,
    this.address,
    required this.createdAt,
    required this.updatedAt,
    this.rideStart,
    this.rideEnd,
    this.rideRequestStart,
    this.rideRequestEnd,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
