import 'package:flowers_ecommerce_app/core/l10n/translations/app_localizations.dart';
import 'package:flowers_ecommerce_app/features/notification/presentation/widget/notification_card.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text(AppLocalizations.of(context)!.notification),
        automaticallyImplyLeading: true,
      ),
      // static data for UI testing only.
      // Will be replaced later with Firebase dynamic data.
      body: ListView.separated(
        itemBuilder: (context, index) {
          return NotificationCard(
            title: 'New Order',
            description:
                'Lorem ipsum dolor sit amet consectetur. Tristique et mauris sem congue in felis id nec. Amet sed morbi bibendum vestibulum',
            onTap: () {},
          );
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: 9,
      ),
    );
  }
}
