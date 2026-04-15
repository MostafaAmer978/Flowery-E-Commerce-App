import 'dart:io';

import 'package:flowers_ecommerce_app/core/errors/api_results.dart';
import 'package:flowers_ecommerce_app/core/errors/failures.dart';
import 'package:flowers_ecommerce_app/core/network/api_services.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/data/datasources/remote/upload_photo_remote_ds.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/data/models/response/upload_photo_response.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/domain/entity/upload_photo_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: UploadPhotoRemoteDataSourceContract)
class UploadPhotoRemoteDataSourceImpl
    implements UploadPhotoRemoteDataSourceContract {
  ApiServices apiServices;

  UploadPhotoRemoteDataSourceImpl({required this.apiServices});

  @override
  Future<ApiResult<UploadPhotoEntity>> uploadPhoto(File file) async {
    try {
      UploadPhotoResponse response = await apiServices.uploadPhoto(file);
      UploadPhotoEntity finalResponse = response.toEntity();
      return ApiSuccessResult<UploadPhotoEntity>(data: finalResponse);
    } catch (e) {
      return ApiErrorResult<UploadPhotoEntity>(
        failure: Failure(errorMessage: e.toString()),
      );
    }
  }
}
