import 'package:flowers_ecommerce_app/core/errors/api_results.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/domain/entity/edit_profile_request.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/domain/entity/edit_profile_response_entity.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/domain/repository/edti_profile.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditProfileUseCase {
  EditProfileRepositoryContract editProfileRepositoryContract;

  EditProfileUseCase({required this.editProfileRepositoryContract});

  Future<ApiResult<EditProfileResponseEntity>> call(
    EditProfileRequest editProfileRequest,
  ) async {
    var result = await editProfileRepositoryContract.editProfile(
      editProfileRequest,
    );
    return result;
  }
}
