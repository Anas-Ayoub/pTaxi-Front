// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RideRequest _$RideRequestFromJson(Map<String, dynamic> json) => RideRequest(
      requestId: (json['requestId'] as num).toInt(),
      passengerId: (json['passengerId'] as num).toInt(),
      startLocationId: (json['startLocationId'] as num).toInt(),
      endLocationId: (json['endLocationId'] as num).toInt(),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      startLocation:
          Location.fromJson(json['startLocation'] as Map<String, dynamic>),
      endLocation:
          Location.fromJson(json['endLocation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RideRequestToJson(RideRequest instance) =>
    <String, dynamic>{
      'requestId': instance.requestId,
      'passengerId': instance.passengerId,
      'startLocationId': instance.startLocationId,
      'endLocationId': instance.endLocationId,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'startLocation': instance.startLocation,
      'endLocation': instance.endLocation,
    };
