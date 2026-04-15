import 'package:flowers_ecommerce_app/config/routing/app_routes.dart';
import 'package:flowers_ecommerce_app/config/routing/routing_extensions.dart';
import 'package:flowers_ecommerce_app/config/theme/colors.dart';
import 'package:flowers_ecommerce_app/core/di/di.dart';
import 'package:flowers_ecommerce_app/core/helpers/dialogue_utils.dart';
import 'package:flowers_ecommerce_app/core/helpers/flutter_toast.dart';
import 'package:flowers_ecommerce_app/core/helpers/regex.dart';
import 'package:flowers_ecommerce_app/core/l10n/translations/app_localizations.dart';
import 'package:flowers_ecommerce_app/features/auth/login/domain/entities/login_request_entity.dart';
import 'package:flowers_ecommerce_app/features/auth/login/presentation/view_model/login_bloc.dart';
import 'package:flowers_ecommerce_app/features/auth/login/presentation/view_model/login_event.dart';
import 'package:flowers_ecommerce_app/features/auth/login/presentation/view_model/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ValueNotifier<bool> isCheck = ValueNotifier(false);
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LoginBloc>(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(AppLocalizations.of(context)!.login),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state.isLoadding == true) {
                DialogueUtils.showLoading(
                  context: context,
                  message: AppLocalizations.of(context)!.loading,
                );
              } else if (state.errorMessage.isNotEmpty) {
                DialogueUtils.hideLoading(context);
                DialogueUtils.showMessage(
                  context: context,
                  message: state.errorMessage,
                  posActionName: AppLocalizations.of(context)!.ok,
                );
              } else if (state.userEntity != null) {
                DialogueUtils.hideLoading(context);
                ToastMessage.toastMsg(
                  AppLocalizations.of(context)!.login_successfully,
                );

                Navigator.pushReplacementNamed(context, AppRoutes.mainLayout);
              }
            },
            builder: (BuildContext context, LoginState state) {
              return SingleChildScrollView(
                child: Form(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 25.sp,
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (AppRegExp.isEmailValid(emailController.text) ==
                              false) {
                            return AppLocalizations.of(
                              context,
                            )!.email_not_valid;
                          }
                          return null;
                        },
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.email,
                          hintText: AppLocalizations.of(
                            context,
                          )!.enter_your_email,
                        ),
                      ),
                      //passwordTextField
                      TextFormField(
                        validator: (value) {
                          if (!AppRegExp.isPasswordValid(
                            passwordController.text,
                          )) {
                            return AppLocalizations.of(
                              context,
                            )!.password_not_valid;
                          }
                          return null;
                        },
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.password,
                          hintText: AppLocalizations.of(
                            context,
                          )!.enter_your_password,
                        ),
                      ),
                      Row(
                        children: [
                          ValueListenableBuilder<bool>(
                            valueListenable: isCheck,
                            builder: (context, value, child) {
                              return Checkbox(
                                value: value,
                                onChanged: (value) {
                                  isCheck.value = value ?? false;
                                },
                              );
                            },
                          ),
                          Text(
                            AppLocalizations.of(context)!.remember_me,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              context.pushNamed(AppRoutes.forgetPassword);
                            },
                            child: Text(
                              '${AppLocalizations.of(context)!.forget_password}?',
                              style: Theme.of(context).textTheme.labelSmall!
                                  .copyWith(
                                    decoration: TextDecoration.underline,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_key.currentState!.validate()) {
                            context.read<LoginBloc>().doIntent(
                              SumitLoginEvent(
                                isRemember: isCheck.value,
                                loginRequestEntity: LoginRequestEntity(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                              ),
                            );
                          }
                        },
                        child: Text(AppLocalizations.of(context)!.login),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.read<LoginBloc>().doIntent(
                            SumitAsGestEvent(),
                          );
                          context.pushReplacementNamed(AppRoutes.mainLayout);
                        },
                        style: ElevatedButton.styleFrom().copyWith(
                          backgroundColor: WidgetStateProperty.all(
                            Colors.transparent,
                          ),
                          side: WidgetStateProperty.all(
                            const BorderSide(color: AppColors.black),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.continue_as_guest,
                          style: Theme.of(context).textTheme.labelMedium!
                              .copyWith(color: AppColors.darkGrey),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.dont_have_an_account,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          TextButton(
                            onPressed: () {
                              context.pushNamed(AppRoutes.register);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.sign_up,
                              style: Theme.of(context).textTheme.displayMedium!
                                  .copyWith(
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColors.pink,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
