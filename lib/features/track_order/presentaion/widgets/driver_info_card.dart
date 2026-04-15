import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowers_ecommerce_app/config/theme/colors.dart';
import 'package:flowers_ecommerce_app/core/helpers/spacing.dart';
import 'package:flowers_ecommerce_app/core/helpers/url_helper.dart';
import 'package:flowers_ecommerce_app/core/l10n/translations/app_localizations.dart';
import 'package:flowers_ecommerce_app/core/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DriverInfoCard extends StatelessWidget {
  final String driverName;
  final String driverPhone;
  final String driverPhoto;

  const DriverInfoCard({
    super.key,
    required this.driverName,
    required this.driverPhone,
    required this.driverPhoto,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tr = AppLocalizations.of(context)!;

    return Row(
      children: [
        Container(
          width: 50.w,
          height: 50.w,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          clipBehavior: Clip.antiAlias,
          child: CachedNetworkImage(
            imageUrl: driverPhoto,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) =>
                const Icon(Icons.person, color: AppColors.red),
          ),
        ),
        horizontalSpace(12.w),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                driverName,
                style: theme.textTheme.displayMedium?.copyWith(
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                tr.deliveryHeroForToday,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.white[80],
                ),
              ),
            ],
          ),
        ),

        Row(
          children: [
            GestureDetector(
              onTap: () {
                callNumber(driverPhone);
              },
              child: Tooltip(
                message: tr.callDriver,
                child: SvgPicture.asset(
                  AppImages.phoneIcon,
                  width: 24.sp,
                  height: 24.sp,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            GestureDetector(
              onTap: () {
                openWhatsApp(driverPhone);
              },
              child: Tooltip(
                message: tr.chatOnWhatsApp,
                child: SvgPicture.asset(
                  AppImages.whatsappIcon,
                  width: 24.sp,
                  height: 24.sp,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
