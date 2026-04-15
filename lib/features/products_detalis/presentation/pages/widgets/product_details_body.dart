import 'package:flowers_ecommerce_app/config/theme/colors.dart';
import 'package:flowers_ecommerce_app/core/helpers/spacing.dart';
import 'package:flowers_ecommerce_app/core/l10n/translations/app_localizations.dart';
import 'package:flowers_ecommerce_app/features/add_to_cart/presentation/view_model/add_to_cart_cubit.dart';
import 'package:flowers_ecommerce_app/features/products_detalis/domin/entites/product_entity.dart';
import 'package:flowers_ecommerce_app/features/products_detalis/presentation/pages/widgets/image_and_dots_indecator_builder.dart';
import 'package:flowers_ecommerce_app/features/products_detalis/presentation/pages/widgets/products_details_and_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helpers/flutter_toast.dart';
import '../../../../add_to_cart/presentation/view_model/add_to_cart_event.dart';

class ProductDetailsBody extends StatefulWidget {
  const ProductDetailsBody({super.key, required this.product});
  final ProductEntity product;

  @override
  State<ProductDetailsBody> createState() => _ProductDetailsBodyState();
}

class _ProductDetailsBodyState extends State<ProductDetailsBody> {
  @override
  Widget build(BuildContext context) {
    var trans = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.50,
          child: ImageAndDotsIndecatorBuilder(images: widget.product.images!),
        ),
        verticalSpace(16),
        ProductsDetailsAndDescription(product: widget.product),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ElevatedButton(
            onPressed: () async {
              final cubit = context.read<AddToCartCubit>();

              await cubit.doIntent(AddProductToCart(widget.product.id!));

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
            child: Text(trans.add_to_cart),
          ),
        ),
        verticalSpace(31),
      ],
    );
  }
}
