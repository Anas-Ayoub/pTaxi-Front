// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      locationId: (json['locationId'] as num).toInt(),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      address: json['address'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      rideStart: (json['rideStart'] as List<dynamic>?)
          ?.map((e) => Ride.fromJson(e as Map<String, dynamic>))
          .toList(),
      rideEnd: (json['rideEnd'] as List<dynamic>?)
          ?.map((e) => Ride.fromJson(e as Map<String, dynamic>))
          .toList(),
      rideRequestStart: (json['rideRequestStart'] as List<dynamic>?)
          ?.map((e) => RideRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      rideRequestEnd: (json['rideRequestEnd'] as List<dynamic>?)
          ?.map((e) => RideRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'locationId': instance.locationId,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'rideStart': instance.rideStart?.map((e) => e.toJson()).toList(),
      'rideEnd': instance.rideEnd?.map((e) => e.toJson()).toList(),
      'rideRequestStart':
          instance.rideRequestStart?.map((e) => e.toJson()).toList(),
      'rideRequestEnd':
          instance.rideRequestEnd?.map((e) => e.toJson()).toList(),
    };
