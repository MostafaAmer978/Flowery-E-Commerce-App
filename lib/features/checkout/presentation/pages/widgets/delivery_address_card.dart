// ignore_for_file: deprecated_member_use
import 'package:flowers_ecommerce_app/config/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeliveryAddressCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onEdit;
  final VoidCallback onSelect;

  const DeliveryAddressCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onEdit,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        height: 83.h,
        padding: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Radio(
                          value: true,
                          groupValue: isSelected,
                          onChanged: (_) => onSelect(),
                          activeColor: AppColors.pink,
                        ),
                        Text(
                          title,
                          style: Theme.of(context).textTheme.displayMedium!
                              .copyWith(
                                color: AppColors.black,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.darkGrey.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onEdit,
              icon: const Icon(Icons.edit, color: AppColors.black),
            ),
          ],
        ),
      ),
    );
  }
}
