import 'package:json_annotation/json_annotation.dart';
import 'ride.dart';
import 'ride_request.dart';

part 'passenger.g.dart';

@JsonSerializable()
class Passenger {
  int passengerId;
  int userId;
  double rating;
  DateTime createdAt;
  DateTime updatedAt;
  List<Ride> rides;
  List<RideRequest> rideRequests;

  Passenger({
    required this.passengerId,
    required this.userId,
    required this.rating,
    required this.createdAt,
    required this.updatedAt,
    required this.rides,
    required this.rideRequests,
  });

  factory Passenger.fromJson(Map<String, dynamic> json) =>
      _$PassengerFromJson(json);
  Map<String, dynamic> toJson() => _$PassengerToJson(this);
}
