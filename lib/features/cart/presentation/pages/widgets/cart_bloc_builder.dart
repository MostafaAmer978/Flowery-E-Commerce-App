import 'package:flowers_ecommerce_app/core/di/di.dart';
import 'package:flowers_ecommerce_app/core/helpers/spacing.dart';
import 'package:flowers_ecommerce_app/core/l10n/translations/app_localizations.dart';
import 'package:flowers_ecommerce_app/features/cart/presentation/pages/widgets/cart_body.dart';
import 'package:flowers_ecommerce_app/features/cart/presentation/view_model/cubit/cart_cubit.dart';
import 'package:flowers_ecommerce_app/features/cart/presentation/view_model/cubit/cart_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBlocBuilder extends StatelessWidget {
  CartBlocBuilder({super.key});

  final viewModel = getIt.get<CartCubit>();

  @override
  Widget build(BuildContext context) {
    var trans = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (_) => viewModel..doIntent(const LoadUserCartEvent()),
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (state.errorMessage.isNotEmpty) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(trans.something_went_wrong),
                    verticalSpace(10),
                    Text(state.errorMessage),
                  ],
                ),
              ),
            );
          }
          if (state.isSuccess && state.userCart != null) {
            return CartBody(userCart: state.userCart!);
          }
          if (state.userCart == null) {
            return Scaffold(
              body: Center(child: Text(trans.your_cart_is_empty)),
            );
          }
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(trans.something_went_wrong)],
              ),
            ),
          );
        },
      ),
    );
  }
}
