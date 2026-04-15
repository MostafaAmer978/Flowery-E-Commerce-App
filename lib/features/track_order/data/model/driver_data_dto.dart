import 'package:json_annotation/json_annotation.dart';
part 'driver_data_dto.g.dart';

@JsonSerializable()
class DriverDataDto {
  @JsonKey(name: 'NID')
  final String? nid;
  @JsonKey(name: 'NIDImg')
  final String? nidImg;
  @JsonKey(name: '_id')
  final String? id;
  final String? country;
  final String? createdAt;
  final String? email;
  final String? firstName;
  final String? gender;
  final String? lastName;
  final String? passwordChangedAt;
  final String? phone;
  final String? photo;
  final String? role;
  final String? vehicleLicense;
  final String? vehicleNumber;
  final String? vehicleType;
  final Map<String, dynamic>? driverLocation;

  DriverDataDto({
    required this.nid,
    required this.nidImg,
    required this.id,
    required this.country,
    this.createdAt,
    required this.email,
    required this.firstName,
    required this.gender,
    required this.lastName,
    this.passwordChangedAt,
    required this.phone,
    required this.photo,
    this.role,
    this.vehicleLicense,
    this.vehicleNumber,
    required this.vehicleType,
    this.driverLocation,
  });

  factory DriverDataDto.fromJson(Map<String, dynamic> json) =>
      _$DriverDataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DriverDataDtoToJson(this);
}
