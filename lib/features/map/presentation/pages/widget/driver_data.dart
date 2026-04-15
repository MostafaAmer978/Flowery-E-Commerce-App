import 'package:flowers_ecommerce_app/config/theme/colors.dart';
import 'package:flowers_ecommerce_app/core/l10n/translations/app_localizations.dart';
import 'package:flowers_ecommerce_app/core/utils/app_images.dart';
import 'package:flowers_ecommerce_app/features/map/presentation/view_model/tracking_bloc.dart';
import 'package:flowers_ecommerce_app/features/map/presentation/view_model/tracking_event.dart';
import 'package:flutter/material.dart';

class DriverData extends StatelessWidget {
  const DriverData({
    super.key,
    required this.trackingViewModel,
    required this.phoneNumber,
    required this.driverName,
    required this.date,
    required this.onTap,
  });
  final TrackingViewModel trackingViewModel;
  final String phoneNumber;
  final String driverName;
  final String date;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Material(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.3,
          color: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.estimated_arrival,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      date,
                      style: Theme.of(context).textTheme.displayMedium!
                          .copyWith(color: AppColors.black),
                    ),
                  ),

                  const Divider(),
                  ListTile(
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.call,
                            color: AppColors.pink,
                            size: 20,
                          ),
                          onPressed: () {
                            trackingViewModel.doIntent(
                              CallDriverEvent(phoneNumber),
                            );
                          },
                        ),
                        GestureDetector(
                          onTap: () => trackingViewModel.doIntent(
                            WatsappDriverEvent(phoneNumber),
                          ),
                          child: Image.asset(AppImages.whatsappIcon),
                        ),
                      ],
                    ),

                    leading: Image.asset(AppImages.logoBoy),
                    title: Text(
                      driverName,
                      style: Theme.of(context).textTheme.displayMedium!
                          .copyWith(color: AppColors.black),
                    ),
                    subtitle: Text(
                      AppLocalizations.of(
                        context,
                      )!.is_your_delivery_hero_for_today,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: onTap,
                      child: Text(AppLocalizations.of(context)!.order_details),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
