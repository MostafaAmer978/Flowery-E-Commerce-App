import 'package:flowers_ecommerce_app/core/helpers/spacing.dart';
import 'package:flowers_ecommerce_app/core/l10n/translations/app_localizations.dart';
import 'package:flowers_ecommerce_app/features/checkout/presentation/pages/widgets/gift_section.dart';
import 'package:flowers_ecommerce_app/features/checkout/presentation/view_model/cubit/checkout/checkout_cubit.dart';
import 'package:flowers_ecommerce_app/features/checkout/presentation/view_model/cubit/checkout/checkout_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flowers_ecommerce_app/config/theme/colors.dart';
import 'package:flowers_ecommerce_app/core/di/di.dart';
import '../../../cart/domin/entities/user_cart.dart';
import 'widgets/delivery_address_section.dart';
import 'widgets/payment_method_section.dart';
import 'widgets/order_summary_section.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key, required this.userCart});
  final UserCart userCart;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<CheckoutCubit>()..doIntent(GetLoggedUserAddresses()),
      child: _CheckoutView(userCart),
    );
  }
}

class _CheckoutView extends StatelessWidget {
  const _CheckoutView(this.userCart);
  final UserCart userCart;

  @override
  Widget build(BuildContext context) {
    final trans = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(trans.checkout),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Text(
                  trans.delevery_time,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const Spacer(),
                Text(
                  trans.schedule,
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium!.copyWith(color: AppColors.pink),
                ),
              ],
            ),
          ),
          verticalSpace(16.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Icon(Icons.access_time_rounded, color: AppColors.black),
                Text(
                  "Instant,",
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
                Text(
                  "Arrive by 03 Sep 2024, 11:00 AM ",
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall!.copyWith(color: AppColors.green),
                ),
              ],
            ),
          ),
          verticalSpace(24.h),
          customDivider(),
          verticalSpace(24.h),
          const DeliveryAddressSection(),
          customDivider(),
          verticalSpace(24.h),
          const PaymentMethodSection(),
          verticalSpace(24.h),
          customDivider(),
          const GiftSection(),
          verticalSpace(24.h),
          customDivider(),
          verticalSpace(24.h),
          OrderSummarySection(userCart: userCart),
          verticalSpace(24.h),
        ],
      ),
    );
  }

  Widget customDivider() {
    return Container(
      height: 24.h,
      color: AppColors.darkGrey.withValues(alpha: 0.1),
    );
  }
}
