import 'dart:io';
import 'package:flowers_ecommerce_app/core/errors/api_results.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/domain/entity/upload_photo_entity.dart';

abstract class UploadPhotoRepoContract {
  Future<ApiResult<UploadPhotoEntity>> uploadPhoto(File file);
}
