import 'dart:io';

import 'package:flowers_ecommerce_app/features/profile/domain/entities/user_entity.dart';

class EditProfileState {
  bool isLoading;
  bool isSuccess;
  bool isError;
  File? pickedImage;
  String? imageUrl;
  UserProfileEntity? userProfileEntity;

  EditProfileState({
    required this.userProfileEntity,
    required this.imageUrl,
    required this.isLoading,
    required this.isError,
    required this.isSuccess,
    required this.pickedImage,
  });

  factory EditProfileState.initial() {
    return EditProfileState(
      userProfileEntity: null,
      imageUrl: '',
      isLoading: false,
      isError: false,
      isSuccess: false,
      pickedImage: null,
    );
  }

  EditProfileState copyWith({
    UserProfileEntity? userProfileEntity,
    String? imageUrl,
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    File? pickedImage,
  }) {
    return EditProfileState(
      imageUrl: imageUrl ?? this.imageUrl,
      userProfileEntity: userProfileEntity ?? this.userProfileEntity,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
      pickedImage: pickedImage ?? this.pickedImage,
    );
  }
}
