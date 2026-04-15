import 'package:flowers_ecommerce_app/config/routing/routing_extensions.dart';
import 'package:flowers_ecommerce_app/core/helpers/dialogue_utils.dart';
import 'package:flowers_ecommerce_app/core/l10n/translations/app_localizations.dart';
import 'package:flowers_ecommerce_app/features/address_details/presentation/manager/add_new_address_cubit/add_new_address_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/di.dart';
import '../manager/add_new_address_cubit/add_new_address_cubit.dart';
import '../manager/add_new_address_cubit/add_new_address_event.dart';
import '../widgets/address_details_text_form_fields.dart';
import '../widgets/map_widget.dart';

class AddressDetailsScreen extends StatelessWidget {
  const AddressDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    final AddressDetailsCubit addressDetailsViewModel =
        getIt<AddressDetailsCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.address),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Form(
          key: addressDetailsViewModel.key,
          child: Column(
            spacing: 24.h,
            children: [
              const MapWidget(),
              const AddressDetailsTextFormFields(),
              BlocListener<AddressDetailsCubit, AddressDetailsState>(
                listener: (context, state) {
                  if (state.isLoading) {
                    DialogueUtils.showLoading(
                      context: context,
                      message: localizations.loading,
                    );
                  } else if (state.errorMsg != null) {
                    DialogueUtils.hideLoading(context);
                    DialogueUtils.showMessage(
                      context: context,
                      message: state.errorMsg!,
                      posActionName: localizations.ok,
                    );
                  } else if (state.errorGetAreas != null ||
                      state.errorGetCities != null) {
                    DialogueUtils.hideLoading(context);
                    DialogueUtils.showMessage(
                      context: context,
                      message: localizations.error,
                      posActionName: localizations.ok,
                    );
                  } else if (state.isSuccess) {
                    DialogueUtils.hideLoading(context);
                    DialogueUtils.showMessage(
                      context: context,
                      message: localizations.saved_address_successfully,
                      posActionName: localizations.ok,
                      posAction: () => context.pop(),
                    );
                  }
                },
                child: ElevatedButton(
                  onPressed: () {
                    if (addressDetailsViewModel.key.currentState!.validate()) {
                      getIt<AddressDetailsCubit>().doIntent(
                        AddNewAddressEvent(),
                      );
                    }
                  },
                  child: Text(localizations.save_address),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
