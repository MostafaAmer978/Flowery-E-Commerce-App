import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowers_ecommerce_app/config/theme/colors.dart';
import 'package:flowers_ecommerce_app/core/helpers/flutter_toast.dart';
import 'package:flowers_ecommerce_app/core/l10n/translations/app_localizations.dart';
import 'package:flowers_ecommerce_app/features/add_to_cart/presentation/view_model/add_to_cart_cubit.dart';
import 'package:flowers_ecommerce_app/features/add_to_cart/presentation/view_model/add_to_cart_event.dart';
import 'package:flowers_ecommerce_app/features/add_to_cart/presentation/view_model/add_to_cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final num price;
  final num priceAfterDiscount;
  final String id;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.priceAfterDiscount,
    required this.id,
    this.onTap,
  });

  String _editTitle(String title) {
    final words = title.split(' ');
    if (words.length <= 2) return title;
    return "${words.sublist(0, 2).join(' ')}..";
  }

  String _calculateDiscount(num price, num discountPrice) {
    if (price == 0) return "0%";
    final discount = ((price - discountPrice) / price) * 100;
    return "${discount.toStringAsFixed(0)}%";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 240.h,
        width: 165.w,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.white[70]!),
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: REdgeInsets.all(8),
        child: Column(
          spacing: 8.h,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ✅ CachedNetworkImage instead of Image.network
            ClipRRect(
              borderRadius: BorderRadius.circular(6.r),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 147.w,
                height: 131.h,
                fit: BoxFit.fill,
                placeholder: (context, url) => Container(
                  width: 147.w,
                  height: 131.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.white[40],
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: const CircularProgressIndicator(strokeWidth: 2),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 147.w,
                  height: 131.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: const Icon(Icons.broken_image, color: Colors.grey),
                ),
              ),
            ),

            Flexible(
              child: Padding(
                padding: REdgeInsets.only(left: 13.5),
                child: Column(
                  spacing: 4.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _editTitle(title),
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall,
                    ),

                    Row(
                      spacing: 5.w,
                      children: [
                        Flexible(
                          child: Text(
                            AppLocalizations.of(context)!.egp,
                            style: theme.textTheme.titleSmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            price.toString(),
                            style: theme.textTheme.titleSmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            priceAfterDiscount.toString(),
                            style: theme.textTheme.bodySmall!.copyWith(
                              color: AppColors.darkGrey,
                              decoration: TextDecoration.lineThrough,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            _calculateDiscount(price, priceAfterDiscount),
                            style: theme.textTheme.bodySmall!.copyWith(
                              color: AppColors.green,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            BlocConsumer<AddToCartCubit, AddToCartState>(
              listener: (context, state) {
                if (state.isSucsses) {
                  ToastMessage.toastMsg(
                    AppLocalizations.of(context)!.order_placed_success,
                    backgroundColor: AppColors.green,
                  );
                } else if (!state.isSucsses && state.errorMsg.isNotEmpty) {
                  ToastMessage.toastMsg(
                    state.errorMsg,
                    backgroundColor: AppColors.red,
                  );
                }
              },
              builder: (context, state) {
                final isThisProductLoading =
                    state.isLoading && state.loadingProductId == id;

                return ElevatedButton(
                  onPressed: isThisProductLoading
                      ? null
                      : () async {
                          final cubit = context.read<AddToCartCubit>();
                          await cubit.doIntent(AddProductToCart(id));
                        },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(150.w, 30.h),
                  ),
                  child: isThisProductLoading
                      ? SizedBox(
                          width: 20.w,
                          height: 20.h,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Row(
                          spacing: 5.w,
                          children: [
                            const Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.white,
                            ),
                            Flexible(
                              child: Text(
                                AppLocalizations.of(context)!.add_to_cart,
                                style: theme.textTheme.bodyMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
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
