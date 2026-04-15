import 'package:firebase_core/firebase_core.dart';
import 'package:flowers_ecommerce_app/config/routing/app_routes.dart';
import 'package:flowers_ecommerce_app/core/constants/constants.dart';
import 'package:flowers_ecommerce_app/core/di/di.dart';
import 'package:flowers_ecommerce_app/core/helpers/shared_pref.dart';
import 'package:flowers_ecommerce_app/features/profile/presentation/view_model/profile_setting_cubit.dart';
import 'package:flowers_ecommerce_app/features/profile/presentation/view_model/profile_setting_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/routing/route_generator.dart';
import 'config/theme/app_theme.dart';
import 'core/l10n/translations/app_localizations.dart';
import 'features/profile/presentation/view_model/profile_setting_state.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await configureDependencies();

  final sharedPref = getIt<SharedPrefHelper>();

  final savedLocale =
      sharedPref.getData(key: Constants.languageCode) as String? ??
      Constants.enKey;

  final isRemember =
      sharedPref.getData(key: Constants.isRemeber) as bool? ?? false;

  runApp(
    BlocProvider(
      create: (_) =>
          getIt<ProfileSettingCubit>()
            ..doIntent(ChangeLanguageEvent(savedLocale)),
      child: FlowersEcommerce(isRemember: isRemember),
    ),
  );
}

class FlowersEcommerce extends StatelessWidget {
  final bool isRemember;
  const FlowersEcommerce({super.key, required this.isRemember});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileSettingCubit, ProfileSettingState>(
      builder: (context, state) {
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              locale: Locale(state.localizationCode),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              debugShowCheckedModeBanner: false,
              onGenerateRoute: RouteGenerator.getRoute,
              initialRoute: isRemember ? AppRoutes.mainLayout : AppRoutes.login,
              theme: AppTheme.lightTheme,
            );
          },
        );
      },
    );
  }
}
