// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      userId: (json['userId'] as num).toInt(),
      firebaseAuthId: json['firebaseAuthId'] as String,
      email: json['email'] as String,
      passwordHash: json['passwordHash'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      userType: json['userType'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      passenger: json['passenger'] == null
          ? null
          : Passenger.fromJson(json['passenger'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'firebaseAuthId': instance.firebaseAuthId,
      'email': instance.email,
      'passwordHash': instance.passwordHash,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'userType': instance.userType,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'passenger': instance.passenger,
    };
