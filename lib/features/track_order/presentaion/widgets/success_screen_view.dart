import 'package:flowers_ecommerce_app/features/track_order/presentaion/page/track_order_screen.dart';
import 'package:flowers_ecommerce_app/features/track_order/presentaion/view_model/track_order_cubit.dart';
import 'package:flowers_ecommerce_app/features/track_order/presentaion/view_model/track_order_state.dart';
import 'package:flutter/material.dart';
import 'package:flowers_ecommerce_app/config/routing/app_routes.dart';
import 'package:flowers_ecommerce_app/config/routing/routing_extensions.dart';
import 'package:flowers_ecommerce_app/config/theme/colors.dart';
import 'package:flowers_ecommerce_app/core/helpers/spacing.dart';
import 'package:flowers_ecommerce_app/core/l10n/translations/app_localizations.dart';
import 'package:flowers_ecommerce_app/core/utils/app_images.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class SuccessScreenView extends StatelessWidget {
  const SuccessScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              AppImages.successlotti,
              repeat: true,
              reverse: false,
              animate: true,
            ),
            Text(
              tr.your_oredr_placed,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              tr.successfully,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            verticalSpace(30.h),

            BlocBuilder<TrackOrderViewModel, TrackOrderState>(
              builder: (context, state) {
                final hasData = state.orderEntity != null;

                return ElevatedButton(
                  onPressed: () {
                    final currentCubit = context.read<TrackOrderViewModel>();

                    if (hasData) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: currentCubit,
                            child: TrackOrderScreen(),
                          ),
                        ),
                      );
                    } else {
                      context.pushNamedAndRemoveUntil(
                        AppRoutes.orders,
                        predicate: (_) => false,
                      );
                    }
                  },
                  child: Text(
                    hasData ? tr.track_order : tr.wait_until_shipping,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
