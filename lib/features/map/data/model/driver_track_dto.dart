import 'package:json_annotation/json_annotation.dart';

part 'driver_track_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class DriverTrackDto {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "country")
  final String? country;
  @JsonKey(name: "firstName")
  final String? firstName;
  @JsonKey(name: "lastName")
  final String? lastName;
  @JsonKey(name: "vehicleType")
  final String? vehicleType;
  @JsonKey(name: "vehicleNumber")
  final String? vehicleNumber;
  @JsonKey(name: "vehicleLicense")
  final String? vehicleLicense;
  @JsonKey(name: "NID")
  final String? nId;
  @JsonKey(name: "NIDImg")
  final String? nIDImg;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "gender")
  final String? gender;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "photo")
  final String? photo;
  @JsonKey(name: "role")
  final String? role;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "passwordChangedAt")
  final String? passwordChangedAt;

  DriverTrackDto({
    this.id,
    this.country,
    this.firstName,
    this.lastName,
    this.vehicleType,
    this.vehicleNumber,
    this.vehicleLicense,
    this.nId,
    this.nIDImg,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.role,
    this.createdAt,
    this.passwordChangedAt,
  });

  factory DriverTrackDto.fromJson(Map<String, dynamic> json) {
    return _$DriverTrackDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DriverTrackDtoToJson(this);
  }
}
