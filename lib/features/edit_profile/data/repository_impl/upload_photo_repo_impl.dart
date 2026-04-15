import 'dart:io';

import 'package:flowers_ecommerce_app/core/errors/api_results.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/data/datasources/remote/upload_photo_remote_ds.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/domain/entity/upload_photo_entity.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/domain/repository/upload_photo_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: UploadPhotoRepoContract)
class UploadPhotoRepoImpl implements UploadPhotoRepoContract {
  final UploadPhotoRemoteDataSourceContract uploadPhotoRemoteDataSource;

  UploadPhotoRepoImpl({required this.uploadPhotoRemoteDataSource});

  @override
  Future<ApiResult<UploadPhotoEntity>> uploadPhoto(File file) async {
    ApiResult<UploadPhotoEntity> result = await uploadPhotoRemoteDataSource
        .uploadPhoto(file);
    return result;
  }
}
