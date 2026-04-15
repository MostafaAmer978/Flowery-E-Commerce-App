import 'package:dio/dio.dart';
import 'package:flowers_ecommerce_app/core/errors/api_results.dart';
import 'package:flowers_ecommerce_app/core/errors/failures.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/domain/entity/edit_profile_request.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/domain/entity/edit_profile_response_entity.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/domain/entity/user_dto_entity.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/domain/repository/edti_profile.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/domain/usecases/edit_profile_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'edit_profile_usecase_test.mocks.dart';

@GenerateMocks([EditProfileRepositoryContract])
void main() {
  late EditProfileUseCase editProfileUseCase;
  late EditProfileRequest editProfileRequest;
  late String message;
  late UserDtoEntity user;
  late EditProfileResponseEntity editProfileResponseEntity;
  late MockEditProfileRepositoryContract mockEditProfileRepositoryContract;

  setUp(() {
    message = "message";
    user = UserDtoEntity();
    editProfileRequest = EditProfileRequest(
      firstName: "firstName",
      email: "email",
      lastName: "lastName",
      phoneNumber: "phoneNumber",
    );
    mockEditProfileRepositoryContract = MockEditProfileRepositoryContract();
    editProfileResponseEntity = EditProfileResponseEntity(
      message: message,
      user: user,
    );
    editProfileUseCase = EditProfileUseCase(
      editProfileRepositoryContract: mockEditProfileRepositoryContract,
    );
  });

  group("Test editProfileUseCase in Presentation_Layer", () {
    /// Success
    test("success case for editProfile with ApiSuccessResult", () async {
      // Arrange

      var mockSuccessResult = ApiSuccessResult<EditProfileResponseEntity>(
        data: editProfileResponseEntity,
      );
      provideDummy<ApiResult<EditProfileResponseEntity>>(mockSuccessResult);

      when(
        mockEditProfileRepositoryContract.editProfile(editProfileRequest),
      ).thenAnswer((_) async => mockSuccessResult);

      // Act
      var result = await editProfileUseCase.call(editProfileRequest);
      // Assert

      expect(result, isA<ApiSuccessResult<EditProfileResponseEntity>>());
      ApiSuccessResult<EditProfileResponseEntity> successResult =
          result as ApiSuccessResult<EditProfileResponseEntity>;
      expect(
        successResult.data.user.id,
        equals(editProfileResponseEntity.user.id),
      );
      verify(
        mockEditProfileRepositoryContract.editProfile(editProfileRequest),
      ).called(1);
    });

    /// Error
    test("Error case for editProfile with ApiErrorResult", () async {
      const String errorMessage = "Error message";
      Failure failure = Failure(errorMessage: errorMessage);
      final dioException = DioException(
        requestOptions: RequestOptions(),
        message: errorMessage,
      );

      var mockErrorResult = ApiErrorResult<EditProfileResponseEntity>(
        failure: failure,
      );
      provideDummy<ApiResult<EditProfileResponseEntity>>(mockErrorResult);

      /// Arrange
      when(
        mockEditProfileRepositoryContract.editProfile(editProfileRequest),
      ).thenAnswer((_) async => mockErrorResult);

      /// Act
      var result = await mockEditProfileRepositoryContract.editProfile(
        editProfileRequest,
      );

      /// Assert
      expect(result, isA<ApiErrorResult<EditProfileResponseEntity>>());
      ApiErrorResult<EditProfileResponseEntity> errorResult =
          result as ApiErrorResult<EditProfileResponseEntity>;
      expect(errorResult.failure.errorMessage, equals(dioException.message));

      verify(
        mockEditProfileRepositoryContract.editProfile(editProfileRequest),
      ).called(1);
    });
  });
}
