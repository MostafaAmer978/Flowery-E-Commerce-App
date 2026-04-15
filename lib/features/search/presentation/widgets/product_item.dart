import 'package:flowers_ecommerce_app/config/theme/colors.dart';
import 'package:flowers_ecommerce_app/core/helpers/spacing.dart';
import 'package:flowers_ecommerce_app/core/l10n/translations/app_localizations.dart';
import 'package:flowers_ecommerce_app/features/search/presentation/cubit/search_cubit.dart';
import 'package:flowers_ecommerce_app/features/search/presentation/cubit/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/flutter_toast.dart';
import '../../../add_to_cart/presentation/view_model/add_to_cart_cubit.dart';
import '../../../add_to_cart/presentation/view_model/add_to_cart_event.dart';

class ProductItem extends StatelessWidget {
  final int index;

  const ProductItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    var trans = AppLocalizations.of(context)!;
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: BorderRadiusGeometry.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  state.productsDtoEntity[index].imgCover ?? "",
                  width: 147.w,
                  height: 131.h,
                  fit: BoxFit.fill,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return SizedBox(
                      height: 131.h,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return SizedBox(
                      height: 131.h,
                      child: const Icon(
                        Icons.error,
                        size: 50,
                        color: Colors.red,
                      ),
                    );
                  },
                ),
              ),
              verticalSpace(8),
              Text(
                state.productsDtoEntity[index].title ?? "",
                style: Theme.of(context).textTheme.labelSmall,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              verticalSpace(4),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "EGP ${state.productsDtoEntity[index].priceAfterDiscount ?? ""}  ",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    TextSpan(
                      text: "${state.productsDtoEntity[index].price ?? ""}",
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    TextSpan(
                      text:
                          "  ${getDiscountPercentage(state.productsDtoEntity[index].price, state.productsDtoEntity[index].priceAfterDiscount)}",
                      style: Theme.of(
                        context,
                      ).textTheme.labelSmall?.copyWith(color: AppColors.green),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 30.h,
                child: ElevatedButton(
                  onPressed: () async {
                    final cubit = context.read<AddToCartCubit>();

                    await cubit.doIntent(
                      AddProductToCart(state.productsDtoEntity[index].id!),
                    );

                    final isSuccess = cubit.state.isSucsses;
                    if (isSuccess) {
                      ToastMessage.toastMsg(
                        trans.order_placed_success,
                        backgroundColor: AppColors.green,
                      );
                    } else {
                      ToastMessage.toastMsg(
                        cubit.state.errorMsg,
                        backgroundColor: AppColors.red,
                      );
                    }
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.shopping_cart_outlined),
                      horizontalSpace(8),
                      Text(trans.add_to_Cart),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String getDiscountPercentage(num? price, num? priceAfterDiscount) {
    if (price == null || priceAfterDiscount == null) return "";
    if (price <= 0 || priceAfterDiscount >= price) {
      return "";
    }
    final discount = ((price - priceAfterDiscount) / price) * 100;
    return "${discount.round()}%";
  }
}
