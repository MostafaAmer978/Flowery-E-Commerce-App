import 'package:json_annotation/json_annotation.dart';

part 'store_track_dto.g.dart';

@JsonSerializable()
class StoreTrackDto {
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "image")
  final String? image;
  @JsonKey(name: "address")
  final String? address;
  @JsonKey(name: "phoneNumber")
  final String? phoneNumber;
  @JsonKey(name: "latLong")
  final String? latLong;

  StoreTrackDto({
    this.name,
    this.image,
    this.address,
    this.phoneNumber,
    this.latLong,
  });

  factory StoreTrackDto.fromJson(Map<String, dynamic> json) {
    return _$StoreTrackDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StoreTrackDtoToJson(this);
  }
}
