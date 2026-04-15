import 'package:flowers_ecommerce_app/features/orders/domin/entites/order.dart';
import 'package:flowers_ecommerce_app/features/orders/presentation/pages/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersListView extends StatelessWidget {
  const OrdersListView({super.key, required this.orders});

  final List<OrderEntity> orders;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 22.w),
          child: OrderCard(orderItem: orders[index]),
        ),
        itemCount: orders.length,
      ),
    );
  }
}
