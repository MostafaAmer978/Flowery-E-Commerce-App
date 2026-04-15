import 'package:flowers_ecommerce_app/config/routing/app_routes.dart';
import 'package:flowers_ecommerce_app/config/routing/routing_extensions.dart';
import 'package:flowers_ecommerce_app/config/theme/colors.dart';
import 'package:flowers_ecommerce_app/core/helpers/spacing.dart';
import 'package:flowers_ecommerce_app/core/l10n/translations/app_localizations.dart';
import 'package:flowers_ecommerce_app/features/orders/domin/entites/order.dart';
import 'package:flowers_ecommerce_app/features/track_order/presentaion/page/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.orderItem});

  final OrderEntity orderItem;

  @override
  Widget build(BuildContext context) {
    var trans = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      // REMOVE height: 130.h,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 1.h),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start, // add this
          children: [
            Container(
              height: 109.h,
              width: 127.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                image: DecorationImage(
                  image: NetworkImage(
                    orderItem.orderItems![0].product!.imgCover!,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // add this to shrink vertically
                children: [
                  verticalSpace(4.h),
                  Text(
                    orderItem.orderItems![0].product!.title!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  verticalSpace(4.h),
                  Text(
                    '${trans.egp}: ${orderItem.totalPrice}',
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    orderItem.state == "completed"
                        ? '${trans.delivered_on} ${orderItem.updatedAt!.day}/${orderItem.updatedAt!.month}/${orderItem.updatedAt!.year}'
                        : '${trans.order_number}:${orderItem.orderNumber!}',
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  verticalSpace(10.h),
                  SizedBox(
                    width: double.infinity,
                    height: 30.h,
                    child: ElevatedButton(
                      onPressed: () {
                        if (orderItem.state == "completed") {
                          context.pushNamed(
                            AppRoutes.productDetails,
                            arguments: orderItem.orderItems!.first.product!.id,
                          );
                        } else if (orderItem.state == "pending") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentSuccessScreen(
                                orderId: orderItem.id ?? "",
                              ),
                            ),
                          );
                        }
                      },
                      child: Text(
                        orderItem.state == "pending"
                            ? trans.track_order
                            : trans.reorder,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
