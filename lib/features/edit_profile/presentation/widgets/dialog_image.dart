import 'package:flowers_ecommerce_app/config/theme/colors.dart';
import 'package:flowers_ecommerce_app/core/helpers/spacing.dart';
import 'package:flowers_ecommerce_app/core/l10n/translations/app_localizations.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/presentation/cubit/edit_profile_cubit.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/presentation/cubit/edit_profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogImage extends StatelessWidget {
  final EditProfileCubit cubit;
  const DialogImage({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  /// camera picker
                  cubit.doIntent(CameraPickerEvent());
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.camera_alt_outlined,
                  size: 35.sp,
                  color: AppColors.pink,
                ),
              ),
              horizontalSpace(5),
              Text(
                AppLocalizations.of(context)!.camera,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  /// gallery picker
                  cubit.doIntent(GalleryPickerEvent());
                  Navigator.pop(context);
                },
                icon: Icon(Icons.photo, size: 35.sp, color: AppColors.pink),
              ),
              horizontalSpace(5),
              Text(
                AppLocalizations.of(context)!.gallery,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
