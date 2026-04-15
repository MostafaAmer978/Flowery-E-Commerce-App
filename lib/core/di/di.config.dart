// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;
import 'package:location/location.dart' as _i645;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as _i528;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/add_to_cart/data/repo/add_to_cart_repo_impl.dart'
    as _i876;
import '../../features/add_to_cart/data/source/add_to_cart_ds.dart' as _i629;
import '../../features/add_to_cart/data/source/add_to_cart_ds_impl.dart'
    as _i706;
import '../../features/add_to_cart/domin/repo/add_to_cart_repo.dart' as _i99;
import '../../features/add_to_cart/domin/usecase/add_to_cart_usecase.dart'
    as _i984;
import '../../features/add_to_cart/presentation/view_model/add_to_cart_cubit.dart'
    as _i964;
import '../../features/address_details/data/data_sources/add_new_address_ds.dart'
    as _i490;
import '../../features/address_details/data/data_sources/add_new_address_ds_impl.dart'
    as _i361;
import '../../features/address_details/data/data_sources/local_ds/get_cities_and_areas_local_ds.dart'
    as _i363;
import '../../features/address_details/data/data_sources/local_ds/get_cities_and_areas_local_ds_impl.dart'
    as _i768;
import '../../features/address_details/data/repositories/add_new_address_repo_impl.dart'
    as _i737;
import '../../features/address_details/domain/repositories/add_new_address_repo.dart'
    as _i430;
import '../../features/address_details/domain/use_cases/add_new_address_use_case.dart'
    as _i586;
import '../../features/address_details/domain/use_cases/get_areas_use_case.dart'
    as _i867;
import '../../features/address_details/domain/use_cases/get_cities_use_case.dart'
    as _i376;
import '../../features/address_details/presentation/manager/add_new_address_cubit/add_new_address_cubit.dart'
    as _i283;
import '../../features/address_details/presentation/manager/map_cubit/map_cubit.dart'
    as _i70;
import '../../features/auth/change_password/data/data_sources/change_password_ds.dart'
    as _i481;
import '../../features/auth/change_password/data/data_sources/change_password_ds_impl.dart'
    as _i964;
import '../../features/auth/change_password/data/repositories/change_password_repo_impl.dart'
    as _i960;
import '../../features/auth/change_password/domain/repositories/change_password_repo.dart'
    as _i784;
import '../../features/auth/change_password/domain/use_cases/change_password_use_case.dart'
    as _i792;
import '../../features/auth/change_password/presentation/manager/change_password_cubit.dart'
    as _i1035;
import '../../features/auth/forget_password/datasource/datasources/remote/email_verify_remote_datasource.dart'
    as _i45;
import '../../features/auth/forget_password/datasource/datasources/remote/email_verify_remote_datasource_impl.dart'
    as _i950;
import '../../features/auth/forget_password/datasource/datasources/remote/forget_pass_remote_datasource.dart'
    as _i197;
import '../../features/auth/forget_password/datasource/datasources/remote/forget_pass_remote_datasource_impl.dart'
    as _i990;
import '../../features/auth/forget_password/datasource/datasources/remote/reset_pass_remote_datasource.dart'
    as _i217;
import '../../features/auth/forget_password/datasource/datasources/remote/reset_pass_remote_datasource_impl.dart'
    as _i398;
import '../../features/auth/forget_password/datasource/repository_impl/email_verify_repo_impl.dart'
    as _i865;
import '../../features/auth/forget_password/datasource/repository_impl/forget_pass_repo_impl.dart'
    as _i791;
import '../../features/auth/forget_password/datasource/repository_impl/reset_pass_repo_impl.dart'
    as _i592;
import '../../features/auth/forget_password/domain/repository/email_verify_repo_contract.dart'
    as _i209;
import '../../features/auth/forget_password/domain/repository/forget_pass_repo_contract.dart'
    as _i171;
import '../../features/auth/forget_password/domain/repository/reset_pass_repo_contract.dart'
    as _i735;
import '../../features/auth/forget_password/domain/usecases/email_verify_usecase.dart'
    as _i532;
import '../../features/auth/forget_password/domain/usecases/forget_pass_usecase.dart'
    as _i107;
import '../../features/auth/forget_password/domain/usecases/reset_pass_usecase.dart'
    as _i801;
import '../../features/auth/forget_password/presentation/cubit/forget_pass_cubit.dart'
    as _i648;
import '../../features/auth/login/data/data_sources/login_ds.dart' as _i773;
import '../../features/auth/login/data/data_sources/login_ds_imp.dart' as _i265;
import '../../features/auth/login/data/repositories/login_repo_imp.dart'
    as _i408;
import '../../features/auth/login/domain/repositories/login_repo.dart' as _i172;
import '../../features/auth/login/domain/use_case/login_use_case.dart' as _i630;
import '../../features/auth/login/presentation/view_model/login_bloc.dart'
    as _i959;
import '../../features/auth/logout/data/data_sources/logout_ds.dart' as _i367;
import '../../features/auth/logout/data/data_sources/logout_ds_impl.dart'
    as _i626;
import '../../features/auth/logout/data/repositories/logout_repo_impl.dart'
    as _i690;
import '../../features/auth/logout/domain/repositories/logout_repo.dart'
    as _i899;
import '../../features/auth/logout/domain/use_cases/logout_use_case.dart'
    as _i386;
import '../../features/auth/logout/presentation/manager/logout_cubit.dart'
    as _i116;
import '../../features/auth/register/data/repo/auth_repo_impl.dart' as _i990;
import '../../features/auth/register/data/source/auth_remote_data_sourse.dart'
    as _i637;
import '../../features/auth/register/data/source/auth_remote_data_sourse_imlp.dart'
    as _i30;
import '../../features/auth/register/domin/repo/auth_repo.dart' as _i975;
import '../../features/auth/register/domin/usecase/register_usecase.dart'
    as _i752;
import '../../features/auth/register/presentation/view_model/cubit/register_cubit.dart'
    as _i444;
import '../../features/cart/data/data_sources/cart_remote_data_sourse.dart'
    as _i1046;
import '../../features/cart/data/data_sources/cart_remote_data_sourse_impl.dart'
    as _i84;
import '../../features/cart/data/repo/cart_repo_impl.dart' as _i234;
import '../../features/cart/domin/repo/cart_repo.dart' as _i1047;
import '../../features/cart/domin/usecase/delete_cart_usecase.dart' as _i664;
import '../../features/cart/domin/usecase/get_user_carts_usecase.dart'
    as _i1043;
import '../../features/cart/domin/usecase/updeate_cart_product_quantity_usecase.dart'
    as _i177;
import '../../features/cart/presentation/view_model/cubit/cart_cubit.dart'
    as _i323;
import '../../features/categories/data/datasources/remote/category_remote_datasource.dart'
    as _i747;
import '../../features/categories/data/datasources/remote/category_remote_datasource_impl.dart'
    as _i337;
import '../../features/categories/data/datasources/remote/product_remote_datasource.dart'
    as _i295;
import '../../features/categories/data/datasources/remote/product_remote_datasource_impl.dart'
    as _i250;
import '../../features/categories/data/repository_impl/category_repo_impl.dart'
    as _i6;
import '../../features/categories/data/repository_impl/product_repo_impl.dart'
    as _i574;
import '../../features/categories/domain/repository/category_repo.dart'
    as _i124;
import '../../features/categories/domain/repository/product_repo.dart' as _i573;
import '../../features/categories/domain/usecases/category_usecase.dart'
    as _i710;
import '../../features/categories/domain/usecases/product_usecase.dart'
    as _i1006;
import '../../features/categories/presentation/cubit/category_cubit.dart'
    as _i93;
import '../../features/checkout/data/repo/checkout_repo_impl.dart' as _i351;
import '../../features/checkout/data/sources/checkout_remote_ds.dart' as _i676;
import '../../features/checkout/data/sources/checkout_remote_ds_impl.dart'
    as _i700;
import '../../features/checkout/domin/repo/checkout_repo.dart' as _i703;
import '../../features/checkout/domin/usecase/get_logged_user_addresses_usecase.dart'
    as _i390;
import '../../features/checkout/presentation/view_model/cubit/checkout/checkout_cubit.dart'
    as _i1043;
import '../../features/edit_profile/data/datasources/remote/edit_profile_remote_ds.dart'
    as _i70;
import '../../features/edit_profile/data/datasources/remote/edit_profile_remote_ds_imp.dart'
    as _i1039;
import '../../features/edit_profile/data/datasources/remote/upload_photo_remote_ds.dart'
    as _i462;
import '../../features/edit_profile/data/datasources/remote/upload_photo_remote_ds_impl.dart'
    as _i686;
import '../../features/edit_profile/data/repository_impl/edit_profile_repository_impl.dart'
    as _i71;
import '../../features/edit_profile/data/repository_impl/upload_photo_repo_impl.dart'
    as _i693;
import '../../features/edit_profile/domain/repository/edti_profile.dart'
    as _i223;
import '../../features/edit_profile/domain/repository/upload_photo_repo_contract.dart'
    as _i90;
import '../../features/edit_profile/domain/usecases/edit_profile_usecase.dart'
    as _i894;
import '../../features/edit_profile/domain/usecases/upload_photo_usecase.dart'
    as _i26;
import '../../features/edit_profile/presentation/cubit/edit_profile_cubit.dart'
    as _i657;
import '../../features/home_screen/data/data_sources/home_ds.dart' as _i635;
import '../../features/home_screen/data/data_sources/home_ds_imp.dart' as _i58;
import '../../features/home_screen/data/repositories/home_repo_imp.dart'
    as _i177;
import '../../features/home_screen/domain/repositories/home_repo.dart' as _i367;
import '../../features/home_screen/domain/use_cases/home_use_case.dart'
    as _i294;
import '../../features/home_screen/presentaion/view_model/home_bloc.dart'
    as _i341;
import '../../features/occasions/data/data_sources/occasions_ds.dart' as _i553;
import '../../features/occasions/data/data_sources/occasions_ds_impl.dart'
    as _i31;
import '../../features/occasions/data/repositories/occasions_repo_impl.dart'
    as _i156;
import '../../features/occasions/domain/repositories/occasions_repo.dart'
    as _i282;
import '../../features/occasions/domain/use_cases/get_specific_occasions_use_case.dart'
    as _i859;
import '../../features/occasions/presentation/manager/occasions_cubit.dart'
    as _i610;
import '../../features/orders/data/repo/order_repo_impl.dart' as _i222;
import '../../features/orders/data/source/orders_remote_ds.dart' as _i587;
import '../../features/orders/data/source/orders_remote_ds_impl.dart' as _i368;
import '../../features/orders/domin/repo/orders_repo.dart' as _i810;
import '../../features/orders/domin/usecase/get_user_orders_usecase.dart'
    as _i538;
import '../../features/orders/presentation/view_model/cubit/orders_cubit.dart'
    as _i871;
import '../../features/payment/data/data_source/payment_ds.dart' as _i152;
import '../../features/payment/data/data_source/payment_ds_imp.dart' as _i89;
import '../../features/payment/data/repo/payment_repo_imp.dart' as _i1035;
import '../../features/payment/domain/repo/payment_repo.dart' as _i50;
import '../../features/payment/domain/use_case/payment_card_use_case.dart'
    as _i795;
import '../../features/payment/domain/use_case/payment_cash_use_case.dart'
    as _i197;
import '../../features/payment/presentaion/view_model/payment_cubit.dart'
    as _i697;
import '../../features/products_detalis/data/repo/products_detalis_repo_impl.dart'
    as _i505;
import '../../features/products_detalis/data/source/products_detalis_ds.dart'
    as _i25;
import '../../features/products_detalis/data/source/products_detalis_ds_impl.dart'
    as _i247;
import '../../features/products_detalis/domin/repo/products_detalis_repo.dart'
    as _i329;
import '../../features/products_detalis/domin/usecase/get_specific_product_usecase.dart'
    as _i838;
import '../../features/products_detalis/presentation/view_model/cubit/product_details_cubit.dart'
    as _i680;
import '../../features/profile/data/local_data_source/get_content_ds.dart'
    as _i99;
import '../../features/profile/data/local_data_source/get_content_ds_imp.dart'
    as _i283;
import '../../features/profile/data/remot_data_source/get_user_data_ds.dart'
    as _i950;
import '../../features/profile/data/remot_data_source/get_user_data_ds_imp.dart'
    as _i237;
import '../../features/profile/data/repo/content_repo_imp.dart' as _i466;
import '../../features/profile/data/repo/get_user_data_repo_imp.dart' as _i1054;
import '../../features/profile/domain/repo/contect_repo.dart' as _i755;
import '../../features/profile/domain/repo/get_user_data_repo.dart' as _i275;
import '../../features/profile/domain/usecase/contect_terms_use_case.dart'
    as _i922;
import '../../features/profile/domain/usecase/content_about_us_use_case.dart'
    as _i116;
import '../../features/profile/domain/usecase/get_user_data_use_case.dart'
    as _i954;
import '../../features/profile/presentation/view_model/profile_setting_cubit.dart'
    as _i124;
import '../../features/saved_addresses/data/data_sources/saved_address_ds.dart'
    as _i156;
import '../../features/saved_addresses/data/data_sources/saved_address_ds_impl.dart'
    as _i483;
import '../../features/saved_addresses/data/repositories/saved_address_repo_impl.dart'
    as _i337;
import '../../features/saved_addresses/domain/repositories/saved_address_repo.dart'
    as _i564;
import '../../features/saved_addresses/domain/use_cases/get_all_addresses_use_case.dart'
    as _i100;
import '../../features/saved_addresses/domain/use_cases/remove_address_use_case.dart'
    as _i342;
import '../../features/saved_addresses/presentation/manager/user_addresses_cubit.dart'
    as _i336;
import '../../features/search/data/datasources/remote/search_remote_ds.dart'
    as _i716;
import '../../features/search/data/datasources/remote/search_remote_ds_impl.dart'
    as _i1054;
import '../../features/search/data/repository_impl/search_repo_impl.dart'
    as _i890;
import '../../features/search/domain/repository/search_repo.dart' as _i858;
import '../../features/search/domain/usecases/search_usecase.dart' as _i1053;
import '../../features/search/presentation/cubit/search_cubit.dart' as _i341;
import '../errors/internet_connection.dart' as _i339;
import '../helpers/shared_pref.dart' as _i42;
import '../network/api_services.dart' as _i804;
import '../network/external_modules.dart' as _i576;
import '../services/token_service.dart' as _i227;
import 'modules/database_module.dart' as _i664;
import 'modules/token_interceptor.dart' as _i89;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final databaseModule = _$DatabaseModule();
    final externalModules = _$ExternalModules();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => databaseModule.providesharedPreferences,
      preResolve: true,
    );
    gh.factory<_i89.TokenInterceptor>(() => _i89.TokenInterceptor());
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => databaseModule.flutterSecureStorage(),
    );
    gh.lazySingleton<_i361.Dio>(() => externalModules.provideDio());
    gh.lazySingleton<_i528.PrettyDioLogger>(
      () => externalModules.providePrettyDioLogger(),
    );
    gh.lazySingleton<_i973.InternetConnectionChecker>(
      () => externalModules.provideInternetConnectionChecker(),
    );
    gh.lazySingleton<_i645.Location>(() => externalModules.provideLocation());
    gh.factory<_i363.GetCitiesAndAreasLocalDataSource>(
      () => _i768.GetCitiesAndAreasLocalDataSourceImpl(),
    );
    gh.factory<_i99.GetContentDataSource>(
      () => _i283.GetContentDataSourceImp(),
    );
    gh.factory<_i804.ApiServices>(() => _i804.ApiServices(gh<_i361.Dio>()));
    gh.factory<_i152.PaymentDataSource>(
      () => _i89.PaymentDataSourceImp(gh<_i804.ApiServices>()),
    );
    gh.factory<_i747.GetAllCategoryRemoteDatasource>(
      () => _i337.GetAllCategoryRemoteDatasourceImpl(
        apiServices: gh<_i804.ApiServices>(),
      ),
    );
    gh.factory<_i629.AddToCartDS>(
      () => _i706.AddToCartDsImpl(gh<_i804.ApiServices>()),
    );
    gh.factory<_i553.OccasionsDataSource>(
      () => _i31.OccasionsDataSourceImpl(gh<_i804.ApiServices>()),
    );
    gh.factory<_i773.LoginDataSource>(
      () => _i265.LoginDataSourceImp(gh<_i804.ApiServices>()),
    );
    gh.factory<_i950.GetUserDataDataSource>(
      () => _i237.GetUserDataDataSourceImp(gh<_i804.ApiServices>()),
    );
    gh.factory<_i99.AddToCartRepo>(
      () => _i876.AddToCartRepoImpl(
        gh<_i629.AddToCartDS>(),
        gh<_i973.InternetConnectionChecker>(),
      ),
    );
    gh.factory<_i227.TokenService>(
      () => _i227.TokenService(
        prefs: gh<_i558.FlutterSecureStorage>(),
        sharedPreferences: gh<_i460.SharedPreferences>(),
      ),
    );
    gh.factory<_i481.ChangePasswordDataSource>(
      () => _i964.ChangePasswordDataSourceImpl(
        gh<_i804.ApiServices>(),
        gh<_i227.TokenService>(),
      ),
    );
    gh.factory<_i124.GetAllCategoryRepositoryContract>(
      () => _i6.GetAllCategoryRepositoryImpl(
        getAllCategoryRemoteDatasource:
            gh<_i747.GetAllCategoryRemoteDatasource>(),
      ),
    );
    gh.factory<_i42.SharedPrefHelper>(
      () => _i42.SharedPrefHelper(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i755.GetContectRepo>(
      () => _i466.GetContentRepoImp(gh<_i99.GetContentDataSource>()),
    );
    gh.factory<_i490.AddNewAddressDataSource>(
      () => _i361.AddNewAddressDataSourceImpl(
        gh<_i804.ApiServices>(),
        gh<_i227.TokenService>(),
      ),
    );
    gh.factory<_i367.LogoutDataSource>(
      () => _i626.LogoutDataSourceImpl(
        gh<_i804.ApiServices>(),
        gh<_i227.TokenService>(),
      ),
    );
    gh.factory<_i430.AddNewAddressRepo>(
      () => _i737.AddNewAddressRepoImpl(
        gh<_i490.AddNewAddressDataSource>(),
        gh<_i363.GetCitiesAndAreasLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i339.NetworkConnection>(
      () => _i339.NetworkConnectionImpl(gh<_i973.InternetConnectionChecker>()),
    );
    gh.factory<_i1046.CartRemoteDataSourse>(
      () => _i84.CartRemoteDataSourseImpl(gh<_i804.ApiServices>()),
    );
    gh.factory<_i275.GetUserDataRepo>(
      () => _i1054.GetUserDataRepoImp(gh<_i950.GetUserDataDataSource>()),
    );
    gh.factory<_i784.ChangePasswordRepo>(
      () => _i960.ChangePasswordRepoImpl(gh<_i481.ChangePasswordDataSource>()),
    );
    gh.factory<_i172.LoginRepo>(
      () => _i408.LoginRepoImp(gh<_i773.LoginDataSource>()),
    );
    gh.factory<_i156.SavedAddressDataSource>(
      () => _i483.SavedAddressDataSourceImpl(
        gh<_i804.ApiServices>(),
        gh<_i227.TokenService>(),
      ),
    );
    gh.factory<_i899.LogoutRepo>(
      () => _i690.LogoutRepoImpl(
        gh<_i367.LogoutDataSource>(),
        gh<_i227.TokenService>(),
      ),
    );
    gh.factory<_i70.MapCubit>(() => _i70.MapCubit(gh<_i645.Location>()));
    gh.factory<_i676.CheckoutRemoteDS>(
      () => _i700.CheckoutRemoteDsImpl(gh<_i804.ApiServices>()),
    );
    gh.factory<_i954.GetUserDataUseCase>(
      () => _i954.GetUserDataUseCase(gh<_i275.GetUserDataRepo>()),
    );
    gh.factory<_i197.ForgetPasswordRemoteDataSource>(
      () => _i990.ForgetPasswordRemoteDataSourceImpl(
        apiServices: gh<_i804.ApiServices>(),
      ),
    );
    gh.factory<_i45.EmailVerifyRemoteDataSource>(
      () => _i950.EmailVerifyRemoteDataSourceImpl(
        apiServices: gh<_i804.ApiServices>(),
      ),
    );
    gh.factory<_i587.OrdersRemoteDataSource>(
      () => _i368.OrdersRemoteDataSourceImpl(gh<_i804.ApiServices>()),
    );
    gh.factory<_i50.PaymentRepo>(
      () => _i1035.PaymentRepoImp(gh<_i152.PaymentDataSource>()),
    );
    gh.factory<_i716.SearchRemoteDataSource>(
      () => _i1054.SearchRemoteDataSourceImpl(
        apiServices: gh<_i804.ApiServices>(),
      ),
    );
    gh.factory<_i810.OrdersRepo>(
      () => _i222.OrderRepoImpl(
        gh<_i587.OrdersRemoteDataSource>(),
        gh<_i973.InternetConnectionChecker>(),
      ),
    );
    gh.factory<_i635.HomeDataSource>(
      () => _i58.HomeDataSourceImp(gh<_i804.ApiServices>()),
    );
    gh.factory<_i922.GetTermsUseCase>(
      () => _i922.GetTermsUseCase(gh<_i755.GetContectRepo>()),
    );
    gh.factory<_i116.GetAboutUsUseCase>(
      () => _i116.GetAboutUsUseCase(gh<_i755.GetContectRepo>()),
    );
    gh.factory<_i637.AuthRemoteDataSource>(
      () => _i30.AuthRemoteDataSourseImlp(gh<_i804.ApiServices>()),
    );
    gh.factory<_i975.AuthRepo>(
      () => _i990.AuthRepoImpl(gh<_i637.AuthRemoteDataSource>()),
    );
    gh.factory<_i70.EditProfileRemoteDataSource>(
      () => _i1039.EditProfileRemoteDataSourceImpl(
        apiServices: gh<_i804.ApiServices>(),
      ),
    );
    gh.factory<_i217.ResetPasswordRemoteDataSource>(
      () => _i398.ResetPasswordRemoteDataSourceImpl(
        apiServices: gh<_i804.ApiServices>(),
      ),
    );
    gh.factory<_i209.EmailVerifyRepoContract>(
      () => _i865.EmailVerifyRepoImpl(
        emailVerifyRemoteDataSource: gh<_i45.EmailVerifyRemoteDataSource>(),
      ),
    );
    gh.factory<_i462.UploadPhotoRemoteDataSourceContract>(
      () => _i686.UploadPhotoRemoteDataSourceImpl(
        apiServices: gh<_i804.ApiServices>(),
      ),
    );
    gh.factory<_i984.AddToCartUsecase>(
      () => _i984.AddToCartUsecase(gh<_i99.AddToCartRepo>()),
    );
    gh.factory<_i25.ProductsDetalisDs>(
      () => _i247.ProductsDetalisDsImpl(gh<_i804.ApiServices>()),
    );
    gh.factory<_i171.ForgetPasswordRepoContract>(
      () => _i791.ForgetPasswordRepoImpl(
        forgetPasswordRemoteDataSource:
            gh<_i197.ForgetPasswordRemoteDataSource>(),
      ),
    );
    gh.factory<_i295.GetAllProductsRemoteDatasource>(
      () => _i250.GetAllProductsRemoteDatasourceImpl(
        apiServices: gh<_i804.ApiServices>(),
      ),
    );
    gh.factory<_i858.SearchRepo>(
      () => _i890.SearchRepoImpl(
        searchRemoteDataSource: gh<_i716.SearchRemoteDataSource>(),
      ),
    );
    gh.factory<_i532.EmailVerifyUseCase>(
      () => _i532.EmailVerifyUseCase(
        emailVerifyRepoContract: gh<_i209.EmailVerifyRepoContract>(),
      ),
    );
    gh.factory<_i792.ChangePasswordUseCase>(
      () => _i792.ChangePasswordUseCase(gh<_i784.ChangePasswordRepo>()),
    );
    gh.factory<_i703.CheckoutRepo>(
      () => _i351.CheckoutRepoImpl(
        gh<_i676.CheckoutRemoteDS>(),
        gh<_i973.InternetConnectionChecker>(),
      ),
    );
    gh.factory<_i795.PaymentCardUseCase>(
      () => _i795.PaymentCardUseCase(gh<_i50.PaymentRepo>()),
    );
    gh.factory<_i197.PaymentCashUseCase>(
      () => _i197.PaymentCashUseCase(gh<_i50.PaymentRepo>()),
    );
    gh.factory<_i630.LoginUseCase>(
      () => _i630.LoginUseCase(gh<_i172.LoginRepo>()),
    );
    gh.factory<_i586.AddNewAddressUseCase>(
      () => _i586.AddNewAddressUseCase(gh<_i430.AddNewAddressRepo>()),
    );
    gh.factory<_i867.GetAreasUseCase>(
      () => _i867.GetAreasUseCase(gh<_i430.AddNewAddressRepo>()),
    );
    gh.factory<_i376.GetCitiesUseCase>(
      () => _i376.GetCitiesUseCase(gh<_i430.AddNewAddressRepo>()),
    );
    gh.factory<_i573.GetAllProductsRepositoryContract>(
      () => _i574.GetAllProductsRepositoryImpl(
        getAllProductsRemoteDatasource:
            gh<_i295.GetAllProductsRemoteDatasource>(),
      ),
    );
    gh.factory<_i710.GetAllCategoryUseCase>(
      () => _i710.GetAllCategoryUseCase(
        getAllCategoryRepositoryContract:
            gh<_i124.GetAllCategoryRepositoryContract>(),
      ),
    );
    gh.factory<_i282.OccasionsRepository>(
      () => _i156.OccasionsRepositoryImpl(
        gh<_i553.OccasionsDataSource>(),
        gh<_i339.NetworkConnection>(),
      ),
    );
    gh.factory<_i1047.CartRepo>(
      () => _i234.CartRepoImpl(
        gh<_i1046.CartRemoteDataSourse>(),
        gh<_i973.InternetConnectionChecker>(),
      ),
    );
    gh.singleton<_i283.AddressDetailsCubit>(
      () => _i283.AddressDetailsCubit(
        gh<_i586.AddNewAddressUseCase>(),
        gh<_i376.GetCitiesUseCase>(),
        gh<_i867.GetAreasUseCase>(),
      ),
    );
    gh.factory<_i386.LogoutUseCase>(
      () => _i386.LogoutUseCase(gh<_i899.LogoutRepo>()),
    );
    gh.factory<_i564.SavedAddressRepo>(
      () => _i337.SavedAddressRepoImpl(gh<_i156.SavedAddressDataSource>()),
    );
    gh.factory<_i124.ProfileSettingCubit>(
      () => _i124.ProfileSettingCubit(
        gh<_i954.GetUserDataUseCase>(),
        gh<_i922.GetTermsUseCase>(),
        gh<_i116.GetAboutUsUseCase>(),
      ),
    );
    gh.factory<_i697.PaymentCubit>(
      () => _i697.PaymentCubit(
        gh<_i795.PaymentCardUseCase>(),
        gh<_i197.PaymentCashUseCase>(),
      ),
    );
    gh.factory<_i859.GetSpecificOccasionsUseCase>(
      () => _i859.GetSpecificOccasionsUseCase(gh<_i282.OccasionsRepository>()),
    );
    gh.factory<_i100.GetAllAddressesUseCase>(
      () => _i100.GetAllAddressesUseCase(gh<_i564.SavedAddressRepo>()),
    );
    gh.factory<_i342.RemoveAddressUseCase>(
      () => _i342.RemoveAddressUseCase(gh<_i564.SavedAddressRepo>()),
    );
    gh.factory<_i959.LoginBloc>(
      () => _i959.LoginBloc(gh<_i630.LoginUseCase>()),
    );
    gh.factory<_i90.UploadPhotoRepoContract>(
      () => _i693.UploadPhotoRepoImpl(
        uploadPhotoRemoteDataSource:
            gh<_i462.UploadPhotoRemoteDataSourceContract>(),
      ),
    );
    gh.factory<_i964.AddToCartCubit>(
      () => _i964.AddToCartCubit(gh<_i984.AddToCartUsecase>()),
    );
    gh.factory<_i329.ProductsDetalisRepo>(
      () => _i505.ProductsDetalisRepoImpl(gh<_i25.ProductsDetalisDs>()),
    );
    gh.factory<_i367.HomeRepo>(
      () => _i177.HomeRepoImp(gh<_i635.HomeDataSource>()),
    );
    gh.factory<_i538.GetUserOrdersUsecase>(
      () => _i538.GetUserOrdersUsecase(ordersRepo: gh<_i810.OrdersRepo>()),
    );
    gh.factory<_i752.RegisterUsecase>(
      () => _i752.RegisterUsecase(authRepo: gh<_i975.AuthRepo>()),
    );
    gh.factory<_i390.GetLoggedUserAddressesUsecase>(
      () => _i390.GetLoggedUserAddressesUsecase(gh<_i703.CheckoutRepo>()),
    );
    gh.factory<_i871.OrdersCubit>(
      () => _i871.OrdersCubit(gh<_i538.GetUserOrdersUsecase>()),
    );
    gh.factory<_i1053.SearchUseCase>(
      () => _i1053.SearchUseCase(searchRepo: gh<_i858.SearchRepo>()),
    );
    gh.factory<_i1035.ChangePasswordCubit>(
      () => _i1035.ChangePasswordCubit(gh<_i792.ChangePasswordUseCase>()),
    );
    gh.factory<_i107.ForgetPasswordUseCase>(
      () => _i107.ForgetPasswordUseCase(
        forgetPasswordRepoContract: gh<_i171.ForgetPasswordRepoContract>(),
      ),
    );
    gh.factory<_i735.ResetPasswordRepoContract>(
      () => _i592.ResetPasswordRepoImpl(
        resetPasswordRemoteDataSource:
            gh<_i217.ResetPasswordRemoteDataSource>(),
      ),
    );
    gh.factory<_i1043.CheckoutCubit>(
      () => _i1043.CheckoutCubit(
        gh<_i390.GetLoggedUserAddressesUsecase>(),
        gh<_i795.PaymentCardUseCase>(),
        gh<_i197.PaymentCashUseCase>(),
      ),
    );
    gh.factory<_i223.EditProfileRepositoryContract>(
      () => _i71.EditProfileRepositoryImpl(
        editProfileRemoteDataSource: gh<_i70.EditProfileRemoteDataSource>(),
      ),
    );
    gh.factory<_i664.DeleteCartUsecase>(
      () => _i664.DeleteCartUsecase(gh<_i1047.CartRepo>()),
    );
    gh.factory<_i1043.GetUserCartsUsecase>(
      () => _i1043.GetUserCartsUsecase(gh<_i1047.CartRepo>()),
    );
    gh.factory<_i177.UpdeateCartProductQuantityUsecase>(
      () => _i177.UpdeateCartProductQuantityUsecase(gh<_i1047.CartRepo>()),
    );
    gh.factory<_i341.SearchCubit>(
      () => _i341.SearchCubit(searchUseCase: gh<_i1053.SearchUseCase>()),
    );
    gh.factory<_i801.ResetPasswordUseCase>(
      () => _i801.ResetPasswordUseCase(
        resetPasswordRepoContract: gh<_i735.ResetPasswordRepoContract>(),
      ),
    );
    gh.factory<_i336.UserAddressesCubit>(
      () => _i336.UserAddressesCubit(
        gh<_i100.GetAllAddressesUseCase>(),
        gh<_i342.RemoveAddressUseCase>(),
      ),
    );
    gh.factory<_i294.HomeUseCase>(
      () => _i294.HomeUseCase(gh<_i367.HomeRepo>()),
    );
    gh.factory<_i323.CartCubit>(
      () => _i323.CartCubit(
        gh<_i1043.GetUserCartsUsecase>(),
        gh<_i664.DeleteCartUsecase>(),
        gh<_i177.UpdeateCartProductQuantityUsecase>(),
      ),
    );
    gh.factory<_i1006.GetAllProductsUseCase>(
      () => _i1006.GetAllProductsUseCase(
        getAllProductsRepositoryContract:
            gh<_i573.GetAllProductsRepositoryContract>(),
      ),
    );
    gh.factory<_i894.EditProfileUseCase>(
      () => _i894.EditProfileUseCase(
        editProfileRepositoryContract:
            gh<_i223.EditProfileRepositoryContract>(),
      ),
    );
    gh.factory<_i341.HomeBloc>(() => _i341.HomeBloc(gh<_i294.HomeUseCase>()));
    gh.factory<_i444.RegisterCubit>(
      () => _i444.RegisterCubit(gh<_i752.RegisterUsecase>()),
    );
    gh.factory<_i838.GetSpecificProductUsecase>(
      () => _i838.GetSpecificProductUsecase(gh<_i329.ProductsDetalisRepo>()),
    );
    gh.factory<_i26.UploadPhotoUseCase>(
      () => _i26.UploadPhotoUseCase(
        uploadPhotoRepoContract: gh<_i90.UploadPhotoRepoContract>(),
      ),
    );
    gh.factory<_i116.LogoutCubit>(
      () => _i116.LogoutCubit(gh<_i386.LogoutUseCase>()),
    );
    gh.factory<_i657.EditProfileCubit>(
      () => _i657.EditProfileCubit(
        editProfileUseCase: gh<_i894.EditProfileUseCase>(),
        uploadPhotoUseCase: gh<_i26.UploadPhotoUseCase>(),
      ),
    );
    gh.factory<_i648.ForgetPasswordCubit>(
      () => _i648.ForgetPasswordCubit(
        forgetPasswordUseCase: gh<_i107.ForgetPasswordUseCase>(),
        emailVerifyUseCase: gh<_i532.EmailVerifyUseCase>(),
        resetPasswordUseCase: gh<_i801.ResetPasswordUseCase>(),
      ),
    );
    gh.factory<_i610.OccasionsCubit>(
      () => _i610.OccasionsCubit(gh<_i859.GetSpecificOccasionsUseCase>()),
    );
    gh.factory<_i680.ProductsDetalis>(
      () => _i680.ProductsDetalis(gh<_i838.GetSpecificProductUsecase>()),
    );
    gh.factory<_i93.CategoryCubit>(
      () => _i93.CategoryCubit(
        getAllCategoryUseCase: gh<_i710.GetAllCategoryUseCase>(),
        getAllProductsUseCase: gh<_i1006.GetAllProductsUseCase>(),
      ),
    );
    return this;
  }
}

class _$DatabaseModule extends _i664.DatabaseModule {}

class _$ExternalModules extends _i576.ExternalModules {}
