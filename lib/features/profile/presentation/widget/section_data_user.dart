import 'package:flowers_ecommerce_app/config/routing/app_routes.dart';
import 'package:flowers_ecommerce_app/config/routing/routing_extensions.dart';
import 'package:flowers_ecommerce_app/config/theme/colors.dart';
import 'package:flowers_ecommerce_app/core/constants/constants.dart';
import 'package:flowers_ecommerce_app/core/di/di.dart';
import 'package:flowers_ecommerce_app/core/helpers/shared_pref.dart';
import 'package:flowers_ecommerce_app/core/l10n/translations/app_localizations.dart';
import 'package:flowers_ecommerce_app/core/utils/app_constants.dart';
import 'package:flowers_ecommerce_app/core/utils/app_images.dart';
import 'package:flowers_ecommerce_app/features/profile/presentation/widget/custom_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SectionDataUser extends StatelessWidget {
  const SectionDataUser({
    super.key,
    required this.email,
    required this.imageUrl,
    required this.userName,
    required this.editTap,
  });

  final String? imageUrl;
  final String? userName;
  final String? email;
  final void Function() editTap;

  @override
  Widget build(BuildContext context) {
    bool enable =
        getIt<SharedPrefHelper>().getData(key: AppConstants.isTokenSaved)
            as bool;
    return Column(
      children: [
        CircleAvatar(
          radius: 40.r,
          backgroundImage:
              enable == true && imageUrl != null && imageUrl!.isNotEmpty
              ? NetworkImage(imageUrl!)
              : null,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              enable == true ? userName! : Constants.nameGest,

              style: Theme.of(context).textTheme.labelMedium,
            ),
            IconButton(
              onPressed: enable == false ? null : editTap,
              icon: const Icon(Icons.edit_outlined),
            ),
          ],
        ),
        Text(
          enable == true ? email! : Constants.emailGest,
          style: Theme.of(
            context,
          ).textTheme.labelMedium!.copyWith(color: AppColors.darkGrey),
        ),
        CustomRow(
          firstIcon: SvgPicture.asset(
            AppImages.orderIcon,
            height: 20.h,
            width: 20.w,
          ),
          title: AppLocalizations.of(context)!.my_order,
          onPressed: () {
            context.pushNamed(AppRoutes.orders);
          },
        ),
        CustomRow(
          firstIcon: const Icon(Icons.location_on_outlined),
          title: AppLocalizations.of(context)!.saved_address,
          onPressed: () {
            context.pushNamed(AppRoutes.savedAddresses);
          },
        ),
      ],
    );
  }
}
