import 'package:json_annotation/json_annotation.dart';

part 'vehicle.g.dart';

@JsonSerializable()
class Vehicle {
  int vehicleId;
  int driverId;
  String make;
  String model;
  int year;
  String licensePlate;
  String color;
  DateTime createdAt;
  DateTime updatedAt;
  // Driver? driver;

  Vehicle({
    required this.vehicleId,
    required this.driverId,
    required this.make,
    required this.model,
    required this.year,
    required this.licensePlate,
    required this.color,
    required this.createdAt,
    required this.updatedAt,
    // required this.driver,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) =>
      _$VehicleFromJson(json);
  Map<String, dynamic> toJson() => _$VehicleToJson(this);
}
