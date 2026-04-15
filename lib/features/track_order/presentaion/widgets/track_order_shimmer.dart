import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:flowers_ecommerce_app/config/theme/colors.dart';

class TrackOrderShimmer extends StatelessWidget {
  const TrackOrderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: const Duration(seconds: 2),
      interval: const Duration(seconds: 1),
      // ignore: deprecated_member_use
      color: AppColors.darkGrey.withOpacity(0.3),
      colorOpacity: 0.3,
      enabled: true,
      direction: const ShimmerDirection.fromLTRB(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 120.w,
              height: 16.h,
              decoration: BoxDecoration(
                color: AppColors.white[60],
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              width: 160.w,
              height: 20.h,
              decoration: BoxDecoration(
                color: AppColors.white[60],
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),

            SizedBox(height: 24.h),
            Divider(color: Colors.grey[400]),

            SizedBox(height: 20.h),
            Row(
              children: [
                Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    color: AppColors.white[60],
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 140.w,
                        height: 16.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        width: 100.w,
                        height: 14.h,
                        decoration: BoxDecoration(
                          color: AppColors.white[60],
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 30.h),
            Center(
              child: Container(
                width: 213.w,
                height: 83.h,
                decoration: BoxDecoration(
                  color: AppColors.white[60],
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),

            SizedBox(height: 40.h),

            Column(
              children: List.generate(
                4,
                (index) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Row(
                    children: [
                      Container(
                        width: 20.w,
                        height: 20.w,
                        decoration: BoxDecoration(
                          color: AppColors.white[60],
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Container(
                          height: 14.h,
                          decoration: BoxDecoration(
                            color: AppColors.white[60],
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
