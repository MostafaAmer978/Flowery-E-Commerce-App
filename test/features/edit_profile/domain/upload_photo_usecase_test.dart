import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flowers_ecommerce_app/core/errors/api_results.dart';
import 'package:flowers_ecommerce_app/core/errors/failures.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/domain/entity/upload_photo_entity.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/domain/repository/upload_photo_repo_contract.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/domain/usecases/upload_photo_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'upload_photo_usecase_test.mocks.dart';

@GenerateMocks([UploadPhotoRepoContract])
void main() {
  late UploadPhotoUseCase uploadPhotoUseCase;
  late String message;
  late File file;
  late UploadPhotoEntity uploadPhotoEntity;
  late MockUploadPhotoRepoContract mockUploadPhotoRepoContract;

  setUp(() {
    message = "message";
    file = File("file");
    mockUploadPhotoRepoContract = MockUploadPhotoRepoContract();
    uploadPhotoEntity = UploadPhotoEntity(message: message);
    uploadPhotoUseCase = UploadPhotoUseCase(
      uploadPhotoRepoContract: mockUploadPhotoRepoContract,
    );
  });

  group("Test uploadPhotoUseCase in Domain_Layer", () {
    /// Success
    test("success case for uploadPhoto with ApiSuccessResult", () async {
      // Arrange

      var mockSuccessResult = ApiSuccessResult<UploadPhotoEntity>(
        data: uploadPhotoEntity,
      );
      provideDummy<ApiResult<UploadPhotoEntity>>(mockSuccessResult);

      when(
        mockUploadPhotoRepoContract.uploadPhoto(file),
      ).thenAnswer((_) async => mockSuccessResult);

      // Act
      var result = await uploadPhotoUseCase.call(file);
      // Assert

      expect(result, isA<ApiSuccessResult<UploadPhotoEntity>>());
      ApiSuccessResult<UploadPhotoEntity> successResult =
          result as ApiSuccessResult<UploadPhotoEntity>;
      expect(successResult.data.message, equals(uploadPhotoEntity.message));
      verify(mockUploadPhotoRepoContract.uploadPhoto(file)).called(1);
    });

    /// Error
    test("Error case for uploadPhoto with ApiErrorResult", () async {
      const String errorMessage = "Error message";
      Failure failure = Failure(errorMessage: errorMessage);
      final dioException = DioException(
        requestOptions: RequestOptions(),
        message: errorMessage,
      );

      var mockErrorResult = ApiErrorResult<UploadPhotoEntity>(failure: failure);
      provideDummy<ApiResult<UploadPhotoEntity>>(mockErrorResult);

      /// Arrange
      when(
        mockUploadPhotoRepoContract.uploadPhoto(file),
      ).thenAnswer((_) async => mockErrorResult);

      /// Act
      var result = await mockUploadPhotoRepoContract.uploadPhoto(file);

      /// Assert
      expect(result, isA<ApiErrorResult<UploadPhotoEntity>>());
      ApiErrorResult<UploadPhotoEntity> errorResult =
          result as ApiErrorResult<UploadPhotoEntity>;
      expect(errorResult.failure.errorMessage, equals(dioException.message));

      verify(mockUploadPhotoRepoContract.uploadPhoto(file)).called(1);
    });
  });
}
