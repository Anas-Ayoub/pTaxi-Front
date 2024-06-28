import 'package:json_annotation/json_annotation.dart';
import 'location.dart';
// import 'Payment.dart';
// import 'Feedback.dart';

part 'ride.g.dart';

@JsonSerializable()
class Ride {
  int rideId;
  int passengerId;
  int driverId;
  int startLocationId;
  int endLocationId;
  String status;
  DateTime? startTime;
  DateTime? endTime;
  double? fare;
  DateTime createdAt;
  DateTime updatedAt;
  Location startLocation;
  Location endLocation;
  // List<Payment> payments;
  // List<Feedback> feedback;

  Ride({
    required this.rideId,
    required this.passengerId,
    required this.driverId,
    required this.startLocationId,
    required this.endLocationId,
    required this.status,
    this.startTime,
    this.endTime,
    this.fare,
    required this.createdAt,
    required this.updatedAt,
    required this.startLocation,
    required this.endLocation,
  });

  factory Ride.fromJson(Map<String, dynamic> json) => _$RideFromJson(json);
  Map<String, dynamic> toJson() => _$RideToJson(this);
}
