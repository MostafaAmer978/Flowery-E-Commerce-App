import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flowers_ecommerce_app/core/errors/api_results.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/domain/entity/edit_profile_request.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/domain/entity/edit_profile_response_entity.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/domain/usecases/edit_profile_usecase.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/domain/usecases/upload_photo_usecase.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/presentation/cubit/edit_profile_event.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/presentation/cubit/edit_profile_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileUseCase editProfileUseCase;
  UploadPhotoUseCase uploadPhotoUseCase;

  EditProfileCubit({
    required this.editProfileUseCase,
    required this.uploadPhotoUseCase,
  }) : super(EditProfileState.initial());

  Future<void> doIntent(EditProfileEvent event) async {
    switch (event) {
      case UpdateProfileEvent():
        await _editProfile(event.editProfileRequest);
        break;
      case UploadPhotoEvent():
        await _uploadPhoto(event.file);
        break;
      case CameraPickerEvent():
        await _cameraPicker();
        break;
      case GalleryPickerEvent():
        await _galleryPicker();
        break;
    }
  }

  Future<void> _editProfile(EditProfileRequest editProfileRequest) async {
    emit(state.copyWith(isLoading: true, isError: false, isSuccess: false));
    var result = await editProfileUseCase.call(editProfileRequest);
    switch (result) {
      case ApiSuccessResult<EditProfileResponseEntity>():
        emit(state.copyWith(isLoading: false, isSuccess: true));
      case ApiErrorResult<EditProfileResponseEntity>():
        emit(state.copyWith(isLoading: false, isError: true));
    }
  }

  Future<void> _uploadPhoto(File file) async {
    await uploadPhotoUseCase.call(state.pickedImage ?? File(""));
  }

  Future<void> _galleryPicker() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      emit(state.copyWith(pickedImage: File(image.path)));
    } else {
      emit(state.copyWith(pickedImage: null));
    }
  }

  Future<void> _cameraPicker() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      emit(state.copyWith(pickedImage: File(image.path)));
    } else {
      emit(state.copyWith(pickedImage: null));
    }
  }
}
