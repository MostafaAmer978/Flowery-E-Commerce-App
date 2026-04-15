import 'package:dio/dio.dart';
import 'package:flowers_ecommerce_app/core/errors/api_results.dart';
import 'package:flowers_ecommerce_app/core/errors/failures.dart';
import 'package:flowers_ecommerce_app/core/network/api_services.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/data/datasources/remote/edit_profile_remote_ds_imp.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/data/models/response/edit_profile_response.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/data/models/user_dto.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/domain/entity/edit_profile_request.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/domain/entity/edit_profile_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../feature/forget_password/data/email_verify_remote_datasource_impl_test.mocks.dart';

@GenerateMocks([ApiServices])
void main() {
  late String errorMessage;
  late Map<String, dynamic> body;
  late MockApiServices mockApiServices;
  late EditProfileRequest editProfileRequest;
  late EditProfileResponse editProfileResponse;
  late EditProfileResponseEntity editProfileResponseEntity;
  late EditProfileRemoteDataSourceImpl editProfileRemoteDataSourceImpl;

  setUp(() {
    errorMessage = "Error";
    editProfileRequest = EditProfileRequest(
      firstName: "firstName",
      lastName: "lastName",
      email: "email",
      phoneNumber: "phoneNumber",
    );
    body = {
      "firstName": editProfileRequest.firstName,
      "lastName": editProfileRequest.lastName,
      "email": editProfileRequest.email,
      "phone": "+2${editProfileRequest.phoneNumber}",
    };
    mockApiServices = MockApiServices();
    editProfileRemoteDataSourceImpl = EditProfileRemoteDataSourceImpl(
      apiServices: mockApiServices,
    );
  });

  group("Test editProfileRemoteDataSourceImpl in Data_Layer", () {
    /// Success
    test("success case for editProfile with ApiSuccessResult", () async {
      // Arrange
      String message = "success";
      UserDto user = UserDto();
      editProfileResponse = EditProfileResponse(message: message, user: user);
      editProfileResponseEntity = editProfileResponse.toEntity();
      when(
        mockApiServices.editProfile(body),
      ).thenAnswer((_) async => editProfileResponse);
      // Act
      var result = await editProfileRemoteDataSourceImpl.editProfile(
        editProfileRequest,
      );
      // Assert
      expect(result, isA<ApiSuccessResult<EditProfileResponseEntity>>());
      ApiSuccessResult<EditProfileResponseEntity> successResult =
          result as ApiSuccessResult<EditProfileResponseEntity>;
      expect(
        successResult.data.user.id,
        equals(editProfileResponseEntity.user.id),
      );
      verify(mockApiServices.editProfile(body)).called(1);
    });

    /// ErrorDioException
    test(
      "ErrorDioException case for editProfile with ApiErrorResult",
      () async {
        const String errorMessage = "Error message";
        final dioException = DioException(
          requestOptions: RequestOptions(),
          message: errorMessage,
        );

        /// Arrange
        when(mockApiServices.editProfile(body)).thenThrow(dioException);

        /// Act
        var result = await editProfileRemoteDataSourceImpl.editProfile(
          editProfileRequest,
        );

        /// Assert
        expect(result, isA<ApiErrorResult<EditProfileResponseEntity>>());
        ApiErrorResult<EditProfileResponseEntity> errorResult =
            result as ApiErrorResult<EditProfileResponseEntity>;
        expect(errorResult.failure.errorMessage, equals(dioException.message));

        verify(mockApiServices.editProfile(body)).called(1);
      },
    );

    /// Error
    test("Error case for editProfile with ApiErrorResult", () async {
      Failure failure = Failure(
        errorMessage: Exception(errorMessage).toString(),
      );

      // Arrange
      when(
        mockApiServices.editProfile(body),
      ).thenThrow(Exception(errorMessage));

      // Act
      var result = await editProfileRemoteDataSourceImpl.editProfile(
        editProfileRequest,
      );

      // Assert
      expect(result, isA<ApiErrorResult<EditProfileResponseEntity>>());
      ApiErrorResult<EditProfileResponseEntity> errorResult =
          result as ApiErrorResult<EditProfileResponseEntity>;
      expect(errorResult.failure.errorMessage, equals(failure.errorMessage));

      verify(mockApiServices.editProfile(body)).called(1);
    });
  });
}
