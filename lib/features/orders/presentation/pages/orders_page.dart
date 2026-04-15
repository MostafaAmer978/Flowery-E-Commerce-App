import 'package:flowers_ecommerce_app/config/routing/app_routes.dart';
import 'package:flowers_ecommerce_app/config/routing/routing_extensions.dart';
import 'package:flowers_ecommerce_app/core/di/di.dart';
import 'package:flowers_ecommerce_app/core/l10n/translations/app_localizations.dart';
import 'package:flowers_ecommerce_app/features/orders/presentation/pages/widgets/orders_body.dart';
import 'package:flowers_ecommerce_app/features/orders/presentation/view_model/cubit/orders_cubit.dart';
import 'package:flowers_ecommerce_app/features/orders/presentation/view_model/cubit/orders_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersPage extends StatelessWidget {
  OrdersPage({super.key});

  final viewModel = getIt<OrdersCubit>();
  @override
  Widget build(BuildContext context) {
    var trans = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => viewModel..doIntent(GetOrdersEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(trans.my_orders),

          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
            onPressed: () {
              context.pushNamedAndRemoveUntil(
                AppRoutes.mainLayout,
                predicate: (_) => false,
              );
            },
          ),
        ),
        body: const OrdersBody(),
      ),
    );
  }
}
