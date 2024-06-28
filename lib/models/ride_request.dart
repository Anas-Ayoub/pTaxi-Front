import 'package:json_annotation/json_annotation.dart';
import 'location.dart';

part 'ride_request.g.dart';

@JsonSerializable()
class RideRequest {
  int requestId;
  int passengerId;
  int startLocationId;
  int endLocationId;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  // Passenger passenger;
  Location startLocation;
  Location endLocation;

  RideRequest({
    required this.requestId,
    required this.passengerId,
    required this.startLocationId,
    required this.endLocationId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    // required this.passenger,
    required this.startLocation,
    required this.endLocation,
  });

  factory RideRequest.fromJson(Map<String, dynamic> json) =>
      _$RideRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RideRequestToJson(this);
}
