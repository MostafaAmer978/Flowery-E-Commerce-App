import 'package:flowers_ecommerce_app/features/address_details/presentation/manager/add_new_address_cubit/add_new_address_cubit.dart';
import 'package:flowers_ecommerce_app/features/address_details/presentation/pages/address_details_screen.dart';
import 'package:flowers_ecommerce_app/features/auth/forget_password/domain/entity/email_verify_args.dart';
import 'package:flowers_ecommerce_app/features/auth/forget_password/presentation/pages/email_verification_screen.dart';
import 'package:flowers_ecommerce_app/features/auth/forget_password/presentation/pages/forget_password_screen.dart';
import 'package:flowers_ecommerce_app/features/auth/forget_password/presentation/pages/reset_password.dart';
import 'package:flowers_ecommerce_app/features/auth/login/presentation/pages/login_screen.dart';
import 'package:flowers_ecommerce_app/features/auth/logout/presentation/pages/logout_screen.dart';
import 'package:flowers_ecommerce_app/features/auth/register/presentation/pages/register_screen.dart';
import 'package:flowers_ecommerce_app/features/cart/presentation/pages/cart_page.dart';
import 'package:flowers_ecommerce_app/features/categories/presentation/pages/categories_screen.dart';
import 'package:flowers_ecommerce_app/features/checkout/presentation/pages/checkout_page.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/presentation/pages/edit_profile_screen.dart';
import 'package:flowers_ecommerce_app/features/home_screen/presentaion/pages/home_screen.dart';
import 'package:flowers_ecommerce_app/features/map/presentation/pages/maps_screen.dart';
import 'package:flowers_ecommerce_app/features/most_selling/presentation/pages/most_selling_page.dart';
import 'package:flowers_ecommerce_app/features/notification/presentation/page/notification_screen.dart';
import 'package:flowers_ecommerce_app/features/occasions/presentation/pages/occasions_screen.dart';
import 'package:flowers_ecommerce_app/features/orders/presentation/pages/orders_page.dart';
import 'package:flowers_ecommerce_app/features/payment/presentaion/page/webvieww_screen.dart';
import 'package:flowers_ecommerce_app/features/products_detalis/presentation/pages/product_details_page.dart';
import 'package:flowers_ecommerce_app/features/profile/domain/entities/about_us_entity.dart';
import 'package:flowers_ecommerce_app/features/profile/domain/entities/term_entity.dart';
import 'package:flowers_ecommerce_app/features/profile/presentation/pages/about_us_screen.dart';
import 'package:flowers_ecommerce_app/features/profile/presentation/pages/profile_screen.dart';
import 'package:flowers_ecommerce_app/features/profile/presentation/pages/terms_screen.dart';
import 'package:flowers_ecommerce_app/features/saved_addresses/presentation/manager/user_addresses_cubit.dart';
import 'package:flowers_ecommerce_app/features/saved_addresses/presentation/pages/user_addresses.dart';
import 'package:flowers_ecommerce_app/features/search/presentation/pages/search_screen.dart';
import 'package:flowers_ecommerce_app/features/track_order/presentaion/page/success_screen.dart';
import 'package:flowers_ecommerce_app/features/track_order/presentaion/page/track_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/di/di.dart';
import '../../core/utils/app_constants.dart';
import '../../features/address_details/presentation/manager/add_new_address_cubit/add_new_address_event.dart';
import '../../features/address_details/presentation/manager/map_cubit/map_cubit.dart';
import '../../features/address_details/presentation/manager/map_cubit/map_event.dart';
import '../../features/auth/change_password/presentation/presentation/pages/reset_password_screen.dart';
import '../../features/cart/domin/entities/user_cart.dart';
import '../../features/home_screen/domain/entities/best_saller_entity.dart';
import '../../features/main_layout/main_layout.dart';
import '../../features/profile/domain/entities/user_entity.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      case AppRoutes.forgetPassword:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());

      case AppRoutes.categories:
        return MaterialPageRoute(builder: (_) => const CategoriesScreen());

      case AppRoutes.emailVerification:
        final args = settings.arguments as EmailVerifyArgs;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: args.cubit,
            child: EmailVerificationScreen(email: args.email),
          ),
        );

      case AppRoutes.resetPassword:
        final args = settings.arguments as EmailVerifyArgs;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: args.cubit,
            child: ResetPasswordScreen(email: args.email),
          ),
        );

      case AppRoutes.mainLayout:
        return MaterialPageRoute(builder: (context) => const MainLayout());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      case AppRoutes.occasions:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => OccasionsScreen(
            occasionsList: args[AppConstants.occasionsParam],
            startedIndex: args[AppConstants.index],
          ),
        );
      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => const ProfileSettingScreen());
      case AppRoutes.terms:
        final termsList = settings.arguments as List<TermEntity>? ?? [];
        return MaterialPageRoute(
          builder: (_) => TermsScreen(termsList: termsList),
        );
      case AppRoutes.aboutUs:
        final aboutUsList = settings.arguments as List<AboutUsEntity>? ?? [];
        return MaterialPageRoute(
          builder: (_) => AboutUsScreen(aboutUsList: aboutUsList),
        );

      case AppRoutes.searchScreen:
        return MaterialPageRoute(builder: (context) => const SearchScreen());

      case AppRoutes.changePassword:
        return MaterialPageRoute(builder: (_) => const ChangePasswordScreen());
      case AppRoutes.successPayment:
        return MaterialPageRoute(
          builder: (_) => PaymentSuccessScreen(orderId: ''),
        );
      case AppRoutes.webView:
        final url = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => WebviewScreen(url: url));
      case AppRoutes.mostSelling:
        final args = settings.arguments as List<BestSallerEntity>;
        return MaterialPageRoute(
          builder: (_) => MostSellingPage(products: args),
        );
      case AppRoutes.cart:
        return MaterialPageRoute(builder: (context) => const CartPage());

      case AppRoutes.logout:
        return MaterialPageRoute(builder: (context) => const LogoutScreen());

      case AppRoutes.trackOrder:
        return MaterialPageRoute(
          builder: (context) => const TrackOrderScreen(),
        );

      case AppRoutes.editProfile:
        final args = settings.arguments as UserProfileEntity;
        return MaterialPageRoute(
          builder: (context) => EditProfileScreen(userEntity: args),
        );

      case AppRoutes.savedAddresses:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<UserAddressesCubit>(),
            child: const UserAddressesScreen(),
          ),
        );

      case AppRoutes.productDetails:
        final args = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ProductDetailsPage(productId: args),
        );

      case AppRoutes.trackOrderMap:
        return MaterialPageRoute(builder: (_) => DriverMapPage(orderId: ''));

      case AppRoutes.addressDetails:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    getIt<AddressDetailsCubit>()
                      ..doIntent(GetAreasAndCitiesEvent()),
              ),
              BlocProvider(
                create: (context) => getIt<MapCubit>()
                  ..doIntent(RequestLocationPermissionEvent())
                  ..doIntent(CheckLocationServiceEvent()),
              ),
            ],
            child: const AddressDetailsScreen(),
          ),
        );

      case AppRoutes.notification:
        return MaterialPageRoute(
          builder: (context) => const NotificationScreen(),
        );

      case AppRoutes.orders:
        return MaterialPageRoute(builder: (_) => OrdersPage());

      case AppRoutes.checkout:
        final args = settings.arguments as UserCart;
        return MaterialPageRoute(builder: (_) => CheckoutPage(userCart: args));
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('No Route Found')),
        body: const Center(child: Text('No Route Found')),
      ),
    );
  }
}
