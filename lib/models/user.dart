import 'package:json_annotation/json_annotation.dart';
import 'driver.dart';
import 'passenger.dart';
// import 'Feedback.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int userId;
  String firebaseAuthId;
  String email;
  String passwordHash;
  String name;
  String phoneNumber;
  String userType;
  DateTime createdAt;
  DateTime updatedAt;
  Passenger? passenger;
  // List<Feedback>? feedback;

  User({
    required this.userId,
    required this.firebaseAuthId,
    required this.email,
    required this.passwordHash,
    required this.name,
    required this.phoneNumber,
    required this.userType,
    required this.createdAt,
    required this.updatedAt,
    this.passenger,
    // this.feedback,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
