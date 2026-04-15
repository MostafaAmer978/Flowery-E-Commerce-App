import 'package:flowers_ecommerce_app/config/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomMarker extends StatelessWidget {
  const CustomMarker({super.key, required this.title, required this.imagePath});
  final String title;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: AppColors.pink,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 10,
                backgroundColor: AppColors.white,
                child: SvgPicture.asset(
                  imagePath,
                  colorFilter: const ColorFilter.mode(
                    AppColors.pink,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(color: AppColors.white),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        const Icon(Icons.location_on_outlined, color: AppColors.pink, size: 40),
      ],
    );
  }
}
