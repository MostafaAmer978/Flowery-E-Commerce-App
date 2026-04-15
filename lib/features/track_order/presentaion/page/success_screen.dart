import 'package:flowers_ecommerce_app/core/di/di.dart';
import 'package:flowers_ecommerce_app/features/track_order/presentaion/view_model/track_order_cubit.dart';
import 'package:flowers_ecommerce_app/features/track_order/presentaion/view_model/track_order_event.dart';
import 'package:flowers_ecommerce_app/features/track_order/presentaion/widgets/success_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flowers_ecommerce_app/features/track_order/presentaion/view_model/track_order_state.dart';

// ignore: must_be_immutable
class PaymentSuccessScreen extends StatelessWidget {
  String? orderId;
  PaymentSuccessScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = getIt.get<TrackOrderViewModel>();
        if (orderId != null && orderId!.isNotEmpty) {
          cubit.doIntent(GetOrderByIdEvent(orderId: orderId!));
        }
        return cubit;
      },
      child: BlocListener<TrackOrderViewModel, TrackOrderState>(
        listenWhen: (previous, current) =>
            previous.orderEntity != current.orderEntity &&
            current.orderEntity != null,
        listener: (context, state) {
          if (state.orderEntity != null) {
            final vehicleTypeId = state.orderEntity!.driverData.vehicleType;
            context.read<TrackOrderViewModel>().doIntent(
              GetVehicleByIdEvent(vehicleId: vehicleTypeId),
            );
          }
        },
        child: SuccessScreenView(),
      ),
    );
  }
}
