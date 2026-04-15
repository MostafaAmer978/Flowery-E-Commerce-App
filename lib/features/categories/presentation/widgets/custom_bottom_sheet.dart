import 'package:flowers_ecommerce_app/config/routing/routing_extensions.dart';
import 'package:flowers_ecommerce_app/config/theme/colors.dart';
import 'package:flowers_ecommerce_app/core/helpers/spacing.dart';
import 'package:flowers_ecommerce_app/core/l10n/translations/app_localizations.dart';
import 'package:flowers_ecommerce_app/core/utils/font_weight.dart';
import 'package:flowers_ecommerce_app/features/categories/presentation/cubit/category_cubit.dart';
import 'package:flowers_ecommerce_app/features/categories/presentation/cubit/category_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomSheet extends StatefulWidget {
  final Function(String?)? onFilterPressed;
  final String? selectedFilter;

  const CustomBottomSheet({
    super.key,
    this.onFilterPressed,
    this.selectedFilter,
  });

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  @override
  Widget build(BuildContext context) {
    Map<String, String> filterMap = {
      '${AppLocalizations.of(context)?.lowest_price}':
          'priceAfterDiscount', // price (from low ==> high)
      '${AppLocalizations.of(context)?.highest_price}':
          '-priceAfterDiscount', // -price (from high ==> low)
      '${AppLocalizations.of(context)?.biggest_discount}':
          '-price', // -priceAfterDiscount (from high ==> low)
      '${AppLocalizations.of(context)?.smallest_discount}':
          'price', // priceAfterDiscount (from low ==> high)
      '${AppLocalizations.of(context)?.lowest_price}':
          '-createdAt', // -priceAfterDiscount (from new ==> old)
      '${AppLocalizations.of(context)?.newest_first}':
          'createdAt', // priceAfterDiscount (from old ==> new)
    };
    late List<String> filterList;
    filterList = filterMap.keys.toList();

    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        final cubit = context.read<CategoryCubit>();
        String? selected = cubit.lastSelectedFilter != null
            ? filterMap.entries
                  .firstWhere(
                    (e) => e.value == cubit.lastSelectedFilter,
                    orElse: () => const MapEntry('', ''),
                  )
                  .key
            : null;
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusGeometry.circular(10),
                    color: AppColors.darkGrey,
                  ),
                  width: 80.w,
                  height: 4.h,
                ),
              ),
              verticalSpace(16),
              Text(
                AppLocalizations.of(context)!.sort_by,
                style: TextStyle(
                  color: AppColors.pink,
                  fontSize: 20.sp,
                  fontWeight: AppFontWeight.bold,
                ),
              ),
              verticalSpace(16),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return verticalSpace(16);
                  },
                  itemCount: filterList.length,
                  itemBuilder: (context, index) {
                    return RadioGroup(
                      groupValue: selected,
                      onChanged: (value) {
                        setState(() {
                          cubit.setLastSelectedFilter(filterMap[value]);
                          if (widget.onFilterPressed != null) {
                            widget.onFilterPressed!(filterMap[value]);
                          }
                          context.pop();
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: AppColors.darkGrey.withAlpha(100),
                              ),
                              borderRadius: BorderRadiusGeometry.circular(8),
                            ),
                            width: double.infinity,
                            child: RadioListTile(
                              controlAffinity: ListTileControlAffinity.trailing,
                              value: filterList[index],
                              title: Text(
                                filterList[index],
                                style: Theme.of(context).textTheme.displayMedium
                                    ?.copyWith(color: AppColors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              verticalSpace(16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.tune),
                    horizontalSpace(10),
                    Text(AppLocalizations.of(context)!.filter),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
