import 'package:flowers_ecommerce_app/config/routing/app_routes.dart';
import 'package:flowers_ecommerce_app/config/routing/routing_extensions.dart';
import 'package:flowers_ecommerce_app/config/theme/colors.dart';
import 'package:flowers_ecommerce_app/core/helpers/spacing.dart';
import 'package:flowers_ecommerce_app/core/l10n/translations/app_localizations.dart';
import 'package:flowers_ecommerce_app/features/checkout/presentation/view_model/cubit/checkout/checkout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'delivery_address_card.dart';

class DeliveryAddressSection extends StatelessWidget {
  const DeliveryAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CheckoutCubit>();
    final trans = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            trans.delivery_address,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ),
          SizedBox(height: 16.h),
          BlocBuilder<CheckoutCubit, CheckoutState>(
            builder: (context, state) {
              if (state.isLoading) {
                return SizedBox(
                  height: 50.h,
                  child: const Center(child: CircularProgressIndicator()),
                );
              }

              if (state.addresses.isEmpty) {
                return Center(
                  child: Column(
                    children: [
                      Text(
                        trans.no_addresses_found,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.darkGrey,
                        ),
                      ),
                      verticalSpace(16.h),
                      AddAddressWidget(trans: trans),
                      verticalSpace(8.h),
                    ],
                  ),
                );
              }

              return Column(
                children: [
                  for (final address in state.addresses) ...[
                    DeliveryAddressCard(
                      title: address.street!,
                      subtitle: address.city!,
                      isSelected: state.selectedAddress == address,
                      onEdit: () {},
                      onSelect: () => cubit.selectAddress(address),
                    ),
                    SizedBox(height: 16.h),
                  ],
                  AddAddressWidget(trans: trans),
                  verticalSpace(16.h),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class AddAddressWidget extends StatelessWidget {
  const AddAddressWidget({super.key, required this.trans});

  final AppLocalizations trans;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(AppRoutes.addressDetails);
      },
      child: Container(
        height: 36.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColors.darkGrey.withValues(alpha: 0.5)),
          color: AppColors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add, color: AppColors.pink),
            SizedBox(width: 8.w),
            Text(
              trans.add_new,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.pink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
