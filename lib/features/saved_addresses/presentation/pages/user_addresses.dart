import 'package:flowers_ecommerce_app/config/routing/app_routes.dart';
import 'package:flowers_ecommerce_app/config/routing/routing_extensions.dart';
import 'package:flowers_ecommerce_app/core/helpers/spacing.dart';
import 'package:flowers_ecommerce_app/core/l10n/translations/app_localizations.dart';
import 'package:flowers_ecommerce_app/features/saved_addresses/presentation/manager/user_addresses_cubit.dart';
import 'package:flowers_ecommerce_app/features/saved_addresses/presentation/manager/user_addresses_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../manager/user_addresses_state.dart';
import '../widgets/saved_address_list_view_item.dart';

class UserAddressesScreen extends StatefulWidget {
  const UserAddressesScreen({super.key});

  @override
  State<UserAddressesScreen> createState() => _UserAddressesScreenState();
}

class _UserAddressesScreenState extends State<UserAddressesScreen> {
  @override
  void initState() {
    context.read<UserAddressesCubit>().doIntent(GetUserAddressesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(AppLocalizations.of(context)!.saved_addresses),
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          spacing: 15.h,
          children: [
            BlocBuilder<UserAddressesCubit, UserAddressesState>(
              builder: (context, state) {
                if (state.isLoadingGetAddresses) {
                  return SizedBox(
                    height: 350.h,
                    child: ListView.separated(
                      itemCount: 5,
                      separatorBuilder: (context, index) => verticalSpace(16),
                      itemBuilder: (context, index) =>
                          const AddressShimmerItem(),
                    ),
                  );
                }
                if (state.errorGetAddresses != null) {
                  return Expanded(
                    child: Center(child: Text(state.errorGetAddresses!)),
                  );
                }

                return state.addresses.isEmpty
                    ? Text(AppLocalizations.of(context)!.no_addresses_yet)
                    : BlocBuilder<UserAddressesCubit, UserAddressesState>(
                        builder: (context, state) {
                          return SizedBox(
                            height: 350.h,
                            child: ListView.separated(
                              itemCount: state.addresses.length,
                              separatorBuilder: (context, index) =>
                                  verticalSpace(16),
                              itemBuilder: (context, index) =>
                                  SavedAddressListViewItem(
                                    address: state.addresses[index],
                                    remove: () => context
                                        .read<UserAddressesCubit>()
                                        .doIntent(
                                          RemoveAddressEvent(
                                            state.addresses[index].id!,
                                          ),
                                        ),
                                  ),
                            ),
                          );
                        },
                      );
              },
            ),
            ElevatedButton(
              onPressed: () {
                context.pushNamed(AppRoutes.addressDetails);
              },
              child: Text(AppLocalizations.of(context)!.add_new_address),
            ),
          ],
        ),
      ),
    );
  }
}

class AddressShimmerItem extends StatelessWidget {
  const AddressShimmerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: 80.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }
}
