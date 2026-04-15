import 'package:flowers_ecommerce_app/config/routing/app_routes.dart';
import 'package:flowers_ecommerce_app/config/routing/routing_extensions.dart';
import 'package:flowers_ecommerce_app/core/utils/product_card.dart';
import 'package:flowers_ecommerce_app/features/occasions/domain/entities/products_entity.dart';
import 'package:flutter/material.dart';

class ProductsGridview extends StatelessWidget {
  const ProductsGridview({super.key, required this.products});
  final List<ProductsEntity> products;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.94 / 3,
        crossAxisSpacing: 17,
        mainAxisSpacing: 17,
      ),
      itemBuilder: (context, index) => GestureDetector(
        onTap: () => context.pushNamed(
          AppRoutes.productDetails,
          arguments: products[index].id,
        ),
        child: ProductCard(
          id: products[index].id ?? '',
          title: products[index].title ?? '',
          imageUrl: products[index].imgCover ?? '',
          price: products[index].price ?? 0,
          priceAfterDiscount: products[index].priceAfterDiscount ?? 0,
        ),
      ),
    );
  }
}
