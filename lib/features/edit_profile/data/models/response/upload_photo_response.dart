import 'package:flowers_ecommerce_app/features/edit_profile/domain/entity/upload_photo_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'upload_photo_response.g.dart';

@JsonSerializable()
class UploadPhotoResponse {
  @JsonKey(name: "message")
  final String? message;

  UploadPhotoResponse({this.message});

  factory UploadPhotoResponse.fromJson(Map<String, dynamic> json) {
    return _$UploadPhotoResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UploadPhotoResponseToJson(this);
  }

  UploadPhotoEntity toEntity() {
    return UploadPhotoEntity(message: message ?? "");
  }
}
