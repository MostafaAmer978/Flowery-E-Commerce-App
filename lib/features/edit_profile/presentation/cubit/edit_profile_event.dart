import 'dart:io';

import 'package:flowers_ecommerce_app/features/edit_profile/domain/entity/edit_profile_request.dart';

abstract class EditProfileEvent {}

class UpdateProfileEvent extends EditProfileEvent {
  EditProfileRequest editProfileRequest;

  UpdateProfileEvent({required this.editProfileRequest});
}

class UploadPhotoEvent extends EditProfileEvent {
  File file;

  UploadPhotoEvent({required this.file});
}

class CameraPickerEvent extends EditProfileEvent {}

class GalleryPickerEvent extends EditProfileEvent {}

class GetUserInfo extends EditProfileEvent {}
