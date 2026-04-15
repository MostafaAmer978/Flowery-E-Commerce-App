import 'dart:io';
import 'package:flowers_ecommerce_app/config/routing/routing_extensions.dart';
import 'package:flowers_ecommerce_app/config/theme/colors.dart';
import 'package:flowers_ecommerce_app/core/di/di.dart';
import 'package:flowers_ecommerce_app/core/helpers/spacing.dart';
import 'package:flowers_ecommerce_app/core/helpers/validators.dart';
import 'package:flowers_ecommerce_app/core/l10n/translations/app_localizations.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/domain/entity/edit_profile_request.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/presentation/cubit/edit_profile_cubit.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/presentation/cubit/edit_profile_event.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/presentation/cubit/edit_profile_state.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/presentation/widgets/gender_selection.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/presentation/widgets/image_picker.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/presentation/widgets/success_dialog.dart';
import 'package:flowers_ecommerce_app/features/profile/domain/entities/user_entity.dart';
import 'package:flowers_ecommerce_app/features/profile/presentation/view_model/profile_setting_cubit.dart';
import 'package:flowers_ecommerce_app/features/profile/presentation/view_model/profile_setting_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.userEntity});
  final UserProfileEntity userEntity;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  EditProfileCubit editProfileCubit = getIt.get<EditProfileCubit>();
  ProfileSettingCubit profileSettingCubit = getIt.get<ProfileSettingCubit>();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? _selectedGender;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    firstNameController.text = widget.userEntity.firstName;
    lastNameController.text = widget.userEntity.lastName;
    emailController.text = widget.userEntity.email;
    phoneController.text = widget.userEntity.phone.substring(2);
    passwordController.text = '1111111111';
    editProfileCubit.state.imageUrl = widget.userEntity.photo;
    _selectedGender = widget.userEntity.gender;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => editProfileCubit),
        BlocProvider(create: (context) => profileSettingCubit),
      ],
      child: BlocConsumer<EditProfileCubit, EditProfileState>(
        listener: (context, state) {
          // firstNameController.text =  state.userProfileEntity?.firstName??'';
          // lastNameController.text =widget.userEntity.lastName;
          // emailController.text = widget.userEntity.email;
          // phoneController.text =
          //     widget.userEntity.phone.substring(2);
          // passwordController.text = '1111111111';
          // editProfileCubit.state.imageUrl =
          //     widget.userEntity.photo;
          // _selectedGender = state.userProfileEntity?.gender;
          if (state.isSuccess) {
            showDialog(
              context: context,
              builder: (context) {
                return const SuccessDialog();
              },
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(Icons.arrow_back),
              ),
              scrolledUnderElevation: 0,
              elevation: 0,
              title: Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.edit_profile,
                    style: Theme.of(
                      context,
                    ).textTheme.labelMedium!.copyWith(fontSize: 20.sp),
                  ),
                  const Spacer(),
                  Badge(child: Icon(Icons.notifications_none, size: 24.sp)),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const ProfileImagePicker(),
                      verticalSpace(24),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppLocalizations.of(
                                    context,
                                  )!.first_name_is_required;
                                }
                                return null;
                              },
                              controller: firstNameController,
                              decoration: InputDecoration(
                                label: Text(
                                  AppLocalizations.of(context)!.first_name,
                                ),
                              ),
                            ),
                          ),
                          horizontalSpace(17),
                          Expanded(
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppLocalizations.of(
                                    context,
                                  )!.last_name_is_required;
                                }
                                return null;
                              },
                              controller: lastNameController,
                              decoration: InputDecoration(
                                label: Text(
                                  AppLocalizations.of(context)!.last_name,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(24),
                      TextFormField(
                        validator: (value) {
                          return Validations.validateEmail(
                            emailController.text,
                          );
                        },
                        controller: emailController,
                        decoration: InputDecoration(
                          label: Text(AppLocalizations.of(context)!.email),
                        ),
                      ),
                      verticalSpace(24),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          return Validations.validatePhoneNumber(
                            phoneController.text,
                          );
                        },
                        controller: phoneController,
                        decoration: InputDecoration(
                          label: Text(
                            AppLocalizations.of(context)!.phone_number,
                          ),
                        ),
                      ),
                      verticalSpace(24),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        readOnly: true,
                        obscuringCharacter: "★",
                        decoration: InputDecoration(
                          suffixIcon: TextButton(
                            onPressed: () {
                              /// navigate to reset password screen
                            },
                            child: Text(AppLocalizations.of(context)!.change),
                          ),
                          label: Text(AppLocalizations.of(context)!.password),
                        ),
                      ),
                      verticalSpace(24),
                      GenderSelection(
                        selectedGender: _selectedGender,
                        onClicked: _onGenderChanged,
                      ),
                      verticalSpace(48),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Future.wait([
                              editProfileCubit.doIntent(
                                UpdateProfileEvent(
                                  editProfileRequest: EditProfileRequest(
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    email: emailController.text,
                                    phoneNumber: phoneController.text,
                                  ),
                                ),
                              ),
                              editProfileCubit.doIntent(
                                UploadPhotoEvent(
                                  file: state.pickedImage ?? File(""),
                                ),
                              ),
                            ]).then((_) {
                              profileSettingCubit.doIntent(
                                SumitProflieSettingEvent(),
                              );
                            });
                          }
                        },
                        child: state.isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.white,
                                ),
                              )
                            : Text(AppLocalizations.of(context)!.update),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onGenderChanged(String? value) {
    setState(() => _selectedGender = value);
  }
}
