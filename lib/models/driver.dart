import 'package:json_annotation/json_annotation.dart';
import 'user.dart';
import 'vehicle.dart';
import 'ride.dart';

part 'driver.g.dart';

@JsonSerializable()
class Driver {
  int driverId;
  int vehicleId;
  String licenseNumber;
  double rating;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  Vehicle vehicle;
  User user;
  List<Ride> rides;

  Driver({
    required this.driverId,
    required this.vehicleId,
    required this.licenseNumber,
    required this.rating,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.vehicle,
    required this.user,
    required this.rides,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => _$DriverFromJson(json);
  Map<String, dynamic> toJson() => _$DriverToJson(this);
}
