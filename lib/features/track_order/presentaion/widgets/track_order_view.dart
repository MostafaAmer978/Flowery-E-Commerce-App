import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowers_ecommerce_app/config/routing/app_routes.dart';
import 'package:flowers_ecommerce_app/config/theme/colors.dart';
import 'package:flowers_ecommerce_app/core/constants/constants.dart';
import 'package:flowers_ecommerce_app/core/helpers/dialogue_utils.dart';
import 'package:flowers_ecommerce_app/core/helpers/flutter_toast.dart';
import 'package:flowers_ecommerce_app/core/helpers/spacing.dart';
import 'package:flowers_ecommerce_app/core/l10n/translations/app_localizations.dart';
import 'package:flowers_ecommerce_app/core/utils/app_images.dart';
import 'package:flowers_ecommerce_app/core/utils/enums.dart';
import 'package:flowers_ecommerce_app/features/map/presentation/pages/maps_screen.dart';
import 'package:flowers_ecommerce_app/features/track_order/presentaion/models/tracking_step.dart';
import 'package:flowers_ecommerce_app/features/track_order/presentaion/view_model/track_order_cubit.dart';
import 'package:flowers_ecommerce_app/features/track_order/presentaion/view_model/track_order_event.dart';
import 'package:flowers_ecommerce_app/features/track_order/presentaion/view_model/track_order_state.dart';
import 'package:flowers_ecommerce_app/features/track_order/presentaion/widgets/driver_info_card.dart';
import 'package:flowers_ecommerce_app/features/track_order/presentaion/widgets/track_order_shimmer.dart';
import 'package:flowers_ecommerce_app/features/track_order/presentaion/widgets/tracking_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class TrackOrderView extends StatelessWidget {
  const TrackOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tr = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.black, size: 20.sp),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          tr.trackOrderTitle,
          style: theme.appBarTheme.titleTextStyle?.copyWith(fontSize: 18.sp),
        ),
      ),
      body: BlocBuilder<TrackOrderViewModel, TrackOrderState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const TrackOrderShimmer();
          }

          if (state.orderEntity == null) {
            return Center(child: Text(tr.noOrderDataFound));
          }

          final order = state.orderEntity!;
          final driver = order.driverData;
          final vehicle = state.vehicleEntity;
          final riderStatus = RiderOrderStatus.fromString(order.state);
          print("Order State: ${order.state}");

          final List<TrackingStep> steps = [
            TrackingStep(
              title: tr.orderReceived,
              timestamp: order.createdAt,
              isCompleted: riderStatus.statusStep >= 1,
            ),
            TrackingStep(
              title: tr.preparingOrder,
              timestamp: order.createdAt,
              isCompleted: riderStatus.statusStep >= 2,
            ),
            TrackingStep(
              title: tr.outForDelivery,
              timestamp: order.createdAt,
              isCompleted: riderStatus.statusStep >= 3,
            ),
            TrackingStep(
              title: tr.delivered,
              timestamp: order.createdAt,
              isCompleted: riderStatus.statusStep >= 4,
            ),
          ];

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(20.h),

                      Text(
                        tr.estimatedArrival,
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: AppColors.darkGrey,
                        ),
                      ),
                      verticalSpace(3.h),

                      Text(
                        DateFormat(
                          Constants.aboutUsDateFormat,
                        ).format(DateTime.now().add(const Duration(days: 2))),
                        style: theme.textTheme.displayMedium?.copyWith(
                          color: AppColors.black,
                        ),
                      ),

                      Divider(
                        color: AppColors.darkGrey,
                        thickness: 0.5,
                        indent: 8.w,
                        endIndent: 8.w,
                      ),

                      verticalSpace(20.h),

                      DriverInfoCard(
                        driverName: '${driver.firstName} ${driver.lastName}',
                        driverPhone: driver.phone,
                        driverPhoto: driver.photo,
                      ),

                      verticalSpace(22.h),

                      Center(
                        child: vehicle != null && vehicle.image.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: vehicle.image,
                                height: 83.h,
                                width: 213.w,
                                fit: BoxFit.contain,
                                errorWidget: (context, error, stackTrace) =>
                                    Icon(
                                      Icons.local_shipping,
                                      size: 60.sp,
                                      color: AppColors.pink,
                                    ),
                              )
                            : SvgPicture.asset(
                                AppImages.car,
                                height: 83.h,
                                width: 213.w,
                              ),
                      ),

                      verticalSpace(24.h),

                      TrackingTimeline(steps: steps),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: _buildActionButtons(
                  context: context,
                  state: state,
                  tr: tr,
                  theme: theme,
                  riderStatus: riderStatus,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildActionButtons({
    required BuildContext context,
    required TrackOrderState state,
    required AppLocalizations tr,
    required ThemeData theme,
    required RiderOrderStatus riderStatus,
  }) {
    final isDeliveredStep = riderStatus.statusStep >= 5;

    final buttons = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (isDeliveredStep)
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                DialogueUtils.showMessage(
                  context: context,
                  title: tr.confirmDelivery,
                  message: tr.confirmDeliveryMessage,
                  posActionName: tr.ok,
                  posAction: () {
                    context.read<TrackOrderViewModel>().doIntent(
                      UpdateOrderStatusEvent(
                        orderId: state.orderEntity?.id ?? "",
                        status: OrderStatus.completed,
                      ),
                    );
                  },
                  ngeActionName: tr.cancel,
                );
              },
              child: Text(
                tr.confirmDelivery,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: AppColors.white,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
        if (isDeliveredStep) SizedBox(width: 12.w),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // todo: show map
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DriverMapPage(orderId: state.orderEntity?.id ?? ""),
                ),
              );
            },
            child: Text(
              tr.showMap,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: theme.textTheme.titleMedium?.copyWith(
                color: AppColors.white,
                fontSize: 14.sp,
              ),
            ),
          ),
        ),
      ],
    );

    return isDeliveredStep
        ? BlocConsumer<TrackOrderViewModel, TrackOrderState>(
            listenWhen: (previous, current) =>
                previous.updateSuccess != current.updateSuccess ||
                previous.isUpdating != current.isUpdating ||
                previous.updateFailure != current.updateFailure,
            listener: (context, state) {
              if (state.updateSuccess && !state.isUpdating) {
                DialogueUtils.hideLoading(context);
                ToastMessage.toastMsg(
                  tr.orderMarkedAsDelivered,
                  backgroundColor: AppColors.pink,
                );
                Navigator.pushReplacementNamed(context, AppRoutes.mainLayout);
              } else if (state.isUpdating) {
                DialogueUtils.showLoading(
                  context: context,
                  message: tr.updating,
                );
              } else if (state.updateFailure != null) {
                DialogueUtils.hideLoading(context);
                DialogueUtils.showAlertDialog(
                  context,
                  state.updateFailure!.errorMessage,
                );
              }
            },
            builder: (context, state) => buttons,
          )
        : buttons;
  }
}
