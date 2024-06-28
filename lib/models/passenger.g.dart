// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passenger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Passenger _$PassengerFromJson(Map<String, dynamic> json) => Passenger(
      passengerId: (json['passengerId'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      rating: (json['rating'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      rides: (json['rides'] as List<dynamic>)
          .map((e) => Ride.fromJson(e as Map<String, dynamic>))
          .toList(),
      rideRequests: (json['rideRequests'] as List<dynamic>)
          .map((e) => RideRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PassengerToJson(Passenger instance) => <String, dynamic>{
      'passengerId': instance.passengerId,
      'userId': instance.userId,
      'rating': instance.rating,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'rides': instance.rides,
      'rideRequests': instance.rideRequests,
    };
