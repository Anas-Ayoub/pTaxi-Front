// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ride _$RideFromJson(Map<String, dynamic> json) => Ride(
      rideId: (json['rideId'] as num).toInt(),
      passengerId: (json['passengerId'] as num).toInt(),
      driverId: (json['driverId'] as num).toInt(),
      startLocationId: (json['startLocationId'] as num).toInt(),
      endLocationId: (json['endLocationId'] as num).toInt(),
      status: json['status'] as String,
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      fare: (json['fare'] as num?)?.toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      startLocation:
          Location.fromJson(json['startLocation'] as Map<String, dynamic>),
      endLocation:
          Location.fromJson(json['endLocation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RideToJson(Ride instance) => <String, dynamic>{
      'rideId': instance.rideId,
      'passengerId': instance.passengerId,
      'driverId': instance.driverId,
      'startLocationId': instance.startLocationId,
      'endLocationId': instance.endLocationId,
      'status': instance.status,
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'fare': instance.fare,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'startLocation': instance.startLocation,
      'endLocation': instance.endLocation,
    };
