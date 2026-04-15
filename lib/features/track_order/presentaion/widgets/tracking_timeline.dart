import 'package:flowers_ecommerce_app/config/theme/colors.dart';
import 'package:flowers_ecommerce_app/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:flowers_ecommerce_app/features/track_order/presentaion/models/tracking_step.dart';

class TrackingTimeline extends StatelessWidget {
  final List<TrackingStep> steps;

  const TrackingTimeline({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: List.generate(steps.length, (index) {
        final step = steps[index];
        final isFirst = index == 0;
        final isLast = index == steps.length - 1;

        return TimelineTile(
          alignment: TimelineAlign.start,

          isFirst: isFirst,
          isLast: isLast,

          beforeLineStyle: LineStyle(
            color: index == 0
                ? Colors.transparent
                : (steps[index - 1].isCompleted
                      ? AppColors.pink
                      : AppColors.white[60]!),
            thickness: 2.w,
          ),
          afterLineStyle: LineStyle(
            color: isLast
                ? Colors.transparent
                : (step.isCompleted ? AppColors.pink : AppColors.white[60]!),
            thickness: 2.w,
          ),

          indicatorStyle: IndicatorStyle(
            width: 22.w,
            height: 22.w,
            indicatorXY: 0.3,
            indicator: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.pink, width: 1.5.w),
                color: step.isCompleted ? AppColors.white : AppColors.white,
              ),
              child: Center(
                child: Icon(
                  Icons.circle,
                  size: 14.sp,
                  color: step.isCompleted ? AppColors.pink : AppColors.white,
                ),
              ),
            ),
          ),
          endChild: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(step.title, style: theme.textTheme.titleSmall),
                verticalSpace(26.h),
                Text(
                  step.timestamp,
                  style: theme.textTheme.displaySmall?.copyWith(
                    color: AppColors.white[90],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
