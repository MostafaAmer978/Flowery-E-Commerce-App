import 'package:json_annotation/json_annotation.dart';

part 'user_track_dto.g.dart';

@JsonSerializable()
class UserTrackDto {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "firstName")
  final String? firstName;
  @JsonKey(name: "lastName")
  final String? lastName;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "gender")
  final String? gender;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "photo")
  final String? photo;

  UserTrackDto({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phone,
    this.photo,
  });

  factory UserTrackDto.fromJson(Map<String, dynamic> json) {
    return _$UserTrackDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserTrackDtoToJson(this);
  }
}
