// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_pick.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarPick _$CarPickFromJson(Map<String, dynamic> json) => CarPick(
      brand: json['brand'] as String,
      models:
          (json['models'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CarPickToJson(CarPick instance) => <String, dynamic>{
      'brand': instance.brand,
      'models': instance.models,
    };
