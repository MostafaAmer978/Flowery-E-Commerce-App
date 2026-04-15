import 'package:flowers_ecommerce_app/config/routing/app_routes.dart';
import 'package:flowers_ecommerce_app/config/routing/routing_extensions.dart';
import 'package:flowers_ecommerce_app/core/constants/constants.dart';
import 'package:flowers_ecommerce_app/core/di/di.dart';
import 'package:flowers_ecommerce_app/core/l10n/translations/app_localizations.dart';
import 'package:flowers_ecommerce_app/core/services/token_service.dart';
import 'package:flowers_ecommerce_app/features/profile/presentation/view_model/profile_setting_cubit.dart';
import 'package:flowers_ecommerce_app/features/profile/presentation/view_model/profile_setting_event.dart';
import 'package:flowers_ecommerce_app/features/profile/presentation/view_model/profile_setting_state.dart';
import 'package:flowers_ecommerce_app/features/profile/presentation/widget/custom_buttom_sheet.dart';
import 'package:flowers_ecommerce_app/features/profile/presentation/widget/custom_notification_switch.dart';
import 'package:flowers_ecommerce_app/features/profile/presentation/widget/custom_row.dart';
import 'package:flowers_ecommerce_app/features/profile/presentation/widget/profile_bar.dart';
import 'package:flowers_ecommerce_app/features/profile/presentation/widget/section_data_user.dart';
import 'package:flowers_ecommerce_app/features/profile/presentation/widget/version_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../auth/logout/presentation/pages/logout_screen.dart';

class ProfileSettingScreen extends StatefulWidget {
  const ProfileSettingScreen({super.key});

  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  @override
  void initState() {
    context.read<ProfileSettingCubit>().doIntent(SumitProflieSettingEvent());

    super.initState();
  }

  bool enabled = getIt<TokenService>().isTokenSaved;

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context)!;
    var cubit = context.read<ProfileSettingCubit>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<ProfileSettingCubit, ProfileSettingState>(
          builder: (context, state) {
            if (state.errorMessage.isNotEmpty) {
              return Center(child: Text(state.errorMessage));
            }
            return Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ProfileBar(numberNoti: 0),
                  SectionDataUser(
                    email: state.userProfileEntity?.email ?? '',
                    imageUrl: state.userProfileEntity?.photo ?? '',
                    userName: state.userProfileEntity?.firstName ?? '',
                    editTap: () {
                      context
                          .pushNamed(
                            AppRoutes.editProfile,
                            arguments: state.userProfileEntity,
                          )
                          .then((_) {
                            cubit.doIntent(SumitProflieSettingEvent());
                          });
                    },
                  ),
                  const Divider(),
                  CustomNotificationSwitch(
                    onChanged: (value) {
                      context.read<ProfileSettingCubit>().doIntent(
                        ToggleNotificationEvent(value),
                      );
                    },
                    title: lang.notification,
                    valueNoti: state.enableNotification,
                    onPressed: () {},
                  ),
                  const Divider(),
                  CustomRow(
                    firstIcon: const Icon(Icons.translate),
                    title: lang.language,
                    lastWidget: Text(
                      state.localizationCode == Constants.arKey
                          ? lang.arabic
                          : lang.english,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) => BlocProvider.value(
                          value: context.read<ProfileSettingCubit>(),
                          child: const CustomButtomSheet(),
                        ),
                      );
                    },
                  ),
                  CustomRow(
                    firstIcon: null,
                    title: lang.about_us,
                    onPressed: () {
                      context.pushNamed(
                        AppRoutes.aboutUs,
                        arguments: state.aboutUsList,
                      );
                    },
                  ),
                  CustomRow(
                    firstIcon: null,
                    title: lang.terms_conditions,
                    onPressed: () {
                      context.pushNamed(
                        AppRoutes.terms,
                        arguments: state.terms,
                      );
                    },
                  ),
                  const Divider(),
                  ?enabled ? const LogoutScreen() : null,
                  const Spacer(),
                  VersionWidget(
                    buildNumber: state.buildNumber,
                    version: state.version,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
