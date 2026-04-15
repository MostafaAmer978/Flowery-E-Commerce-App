import 'package:flowers_ecommerce_app/config/theme/colors.dart';
import 'package:flowers_ecommerce_app/features/occasions/presentation/manager/occasions_cubit.dart';
import 'package:flowers_ecommerce_app/features/occasions/presentation/manager/occasions_state.dart';
import 'package:flowers_ecommerce_app/features/occasions/presentation/widgets/products_gridview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../manager/occasions_event.dart';

class TabBarViewBlocBuilder extends StatefulWidget {
  const TabBarViewBlocBuilder({
    super.key,
    required this.tabs,
    required this.ids,
    required this.controller,
    required this.startedIndex,
  });

  final List<String> tabs;
  final List<String> ids;
  final TabController controller;
  final int startedIndex;

  @override
  State<TabBarViewBlocBuilder> createState() => _TabBarViewBlocBuilderState();
}

class _TabBarViewBlocBuilderState extends State<TabBarViewBlocBuilder>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    context.read<OccasionsCubit>().doIntent(
      LoadOccasionsEvent(),
      widget.startedIndex.toString(),
    );

    widget.controller.addListener(() {
      final id = widget.ids[widget.controller.index];
      context.read<OccasionsCubit>().doIntent(LoadOccasionsEvent(), id);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final theme = Theme.of(context);

    return BlocBuilder<OccasionsCubit, OccasionsState>(
      builder: (context, state) {
        if (state.isLoadingGetOccasion) {
          return Expanded(
            child: const Center(child: CircularProgressIndicator()),
          );
        } else if (state.errorGetOccasion != null) {
          return Center(
            child: Text(
              state.errorGetOccasion!,
              style: theme.textTheme.bodyLarge!.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
          );
        } else if (state.products.isEmpty) {
          return Expanded(
            child: Center(
              child: Icon(
                Icons.shopping_bag_outlined,
                size: 80.sp,
                color: AppColors.pink,
              ),
            ),
          );
        } else {
          return Expanded(
            child: TabBarView(
              controller: widget.controller,
              children: List.generate(widget.tabs.length, (index) {
                final products =
                    context
                        .read<OccasionsCubit>()
                        .cachedOccasions[widget.ids[index]] ??
                    [];
                return ProductsGridview(products: products);
              }),
            ),
          );
        }
      },
    );
  }
}
