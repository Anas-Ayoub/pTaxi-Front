import 'package:json_annotation/json_annotation.dart';

part 'car_pick.g.dart';

@JsonSerializable()
class CarPick {
  String brand;
  List<String> models;

  CarPick({required this.brand, required this.models});

  factory CarPick.fromJson(Map<String, dynamic> json) => _$CarPickFromJson(json);

  Map<String, dynamic> toJson() => _$CarPickToJson(this);
}