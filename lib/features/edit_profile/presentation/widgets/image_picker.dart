import 'dart:io';

import 'package:flowers_ecommerce_app/features/edit_profile/presentation/cubit/edit_profile_cubit.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/presentation/cubit/edit_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dialog_image.dart';

class ProfileImagePicker extends StatefulWidget {
  const ProfileImagePicker({super.key});

  @override
  State<ProfileImagePicker> createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      builder: (context, state) {
        var cubit = context.read<EditProfileCubit>();
        return Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 40.r,
              backgroundImage: state.pickedImage == null
                  ? NetworkImage(state.imageUrl!)
                  : FileImage(File(state.pickedImage!.path)),
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(15.r),
                    ),
                    child: DialogImage(cubit: cubit),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadiusGeometry.circular(5.r),
                  color: const Color(0xFFF9ECF0),
                ),
                child: const Icon(Icons.camera_alt_outlined, size: 20),
              ),
            ),
          ],
        );
      },
    );
  }
}
