import 'package:flowers_ecommerce_app/config/routing/app_routes.dart';
import 'package:flowers_ecommerce_app/config/routing/routing_extensions.dart';
import 'package:flowers_ecommerce_app/config/theme/colors.dart';
import 'package:flowers_ecommerce_app/core/di/di.dart';
import 'package:flowers_ecommerce_app/core/helpers/spacing.dart';
import 'package:flowers_ecommerce_app/core/l10n/translations/app_localizations.dart';
import 'package:flowers_ecommerce_app/core/utils/product_card.dart';
import 'package:flowers_ecommerce_app/features/categories/presentation/cubit/category_cubit.dart';
import 'package:flowers_ecommerce_app/features/categories/presentation/cubit/category_event.dart';
import 'package:flowers_ecommerce_app/features/categories/presentation/cubit/category_state.dart';
import 'package:flowers_ecommerce_app/features/categories/presentation/widgets/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesScreen extends StatefulWidget {
  final int? selectedIndex;
  const CategoriesScreen({super.key, this.selectedIndex});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final CategoryCubit categoryCubit = getIt.get<CategoryCubit>();
  late int? selectedIndexCurrent;

  @override
  Widget build(BuildContext context) {
    selectedIndexCurrent = widget.selectedIndex;
    return BlocProvider(
      create: (context) {
        final cubit = categoryCubit;
        cubit.doIntent(GetAllCategoryEvent()).then((_) async {
          await cubit.doIntent(GetAllProductsEvent());
          final index = selectedIndexCurrent ?? 0;
          if (cubit.state.listCategoryModel.isNotEmpty) {
            final firstCategoryId = cubit.state.listCategoryModel[index].id;

            cubit.doIntent(ProductsByCategoryId(categoryId: firstCategoryId));
          }
        });

        return cubit;
      },
      child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: FloatingActionButton.extended(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(50),
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) {
                      final cubit = context.read<CategoryCubit>();
                      return BlocProvider.value(
                        value: cubit,
                        child: CustomBottomSheet(
                          onFilterPressed: (selectedFilter) {
                            selectedIndexCurrent = 0;
                            if (selectedFilter != null) {
                              cubit.doIntent(
                                GetAllProductsEvent(sortBy: selectedFilter),
                              );
                            }
                          },
                        ),
                      );
                    },
                  );
                },
                label: Row(
                  children: [
                    const Icon(Icons.tune),
                    horizontalSpace(12),
                    Text(AppLocalizations.of(context)!.filter),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: TextField(
                            readOnly: true,
                            onTap: () {
                              context.pushNamed(AppRoutes.searchScreen);
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.search),
                              hintText: AppLocalizations.of(context)!.search,
                            ),
                          ),
                        ),
                        horizontalSpace(8),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadiusGeometry.circular(8),
                                border: Border.all(width: 1),
                              ),
                              height: 48.h,
                              child: const Icon(Icons.sort),
                            ),
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(16),
                    Expanded(
                      child: BlocBuilder<CategoryCubit, CategoryState>(
                        builder: (context, state) {
                          if (state.isLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Column(
                            children: [
                              DefaultTabController(
                                initialIndex: selectedIndexCurrent ?? 0,
                                length: state.listCategoryModel.length,
                                child: TabBar(
                                  onTap: (value) {
                                    final categoryId =
                                        state.listCategoryModel[value].id;
                                    categoryCubit.doIntent(
                                      ProductsByCategoryId(
                                        categoryId: categoryId,
                                      ),
                                    );
                                  },
                                  dividerColor: Colors.transparent,
                                  tabAlignment: TabAlignment.start,
                                  isScrollable: true,
                                  tabs: state.listCategoryModel
                                      .map(
                                        (e) => Tab(
                                          child: Text(
                                            e.name,
                                            style: Theme.of(
                                              context,
                                            ).textTheme.displayMedium,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                              verticalSpace(32),
                              Expanded(
                                child: state.isLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : state.filteredProducts.isEmpty &&
                                          state.dataLoading
                                    ? Expanded(
                                        child: Center(
                                          child: Icon(
                                            Icons.shopping_bag_outlined,
                                            size: 80.sp,
                                            color: AppColors.pink,
                                          ),
                                        ),
                                      )
                                    : GridView.builder(
                                        itemCount:
                                            state.filteredProducts.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio: 1.94 / 3,
                                              crossAxisSpacing: 17,
                                              mainAxisSpacing: 17,
                                            ),
                                        itemBuilder: (context, index) {
                                          final product =
                                              state.filteredProducts[index];
                                          return ProductCard(
                                            id: product.id ?? '',
                                            title: product.title ?? '',
                                            imageUrl: product.imgCover ?? '',
                                            price: product.price ?? 0,
                                            priceAfterDiscount:
                                                product.priceAfterDiscount ?? 0,
                                            onTap: () => context.pushNamed(
                                              AppRoutes.productDetails,
                                              arguments: product.id,
                                            ),
                                          );
                                        },
                                      ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    categoryCubit.lastSelectedFilter = null;
    super.dispose();
  }
}
