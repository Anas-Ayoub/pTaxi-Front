// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Driver _$DriverFromJson(Map<String, dynamic> json) => Driver(
      driverId: (json['driverId'] as num).toInt(),
      vehicleId: (json['vehicleId'] as num).toInt(),
      licenseNumber: json['licenseNumber'] as String,
      rating: (json['rating'] as num).toDouble(),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      vehicle: Vehicle.fromJson(json['vehicle'] as Map<String, dynamic>),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      rides: (json['rides'] as List<dynamic>)
          .map((e) => Ride.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DriverToJson(Driver instance) => <String, dynamic>{
      'driverId': instance.driverId,
      'vehicleId': instance.vehicleId,
      'licenseNumber': instance.licenseNumber,
      'rating': instance.rating,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'vehicle': instance.vehicle,
      'user': instance.user,
      'rides': instance.rides,
    };
