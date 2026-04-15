import 'package:json_annotation/json_annotation.dart';
part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  @JsonKey(name: '_id')
  final String? id;
  final String? email;
  final String? firstName;
  final String? gender;
  final String? lastName;
  final String? phone;
  final String? photo;

  UserDto({
    required this.id,
    required this.email,
    required this.firstName,
    required this.gender,
    required this.lastName,
    required this.phone,
    required this.photo,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
