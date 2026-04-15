import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flowers_ecommerce_app/core/di/modules/token_interceptor.dart';
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../di/di.dart';
import 'api_constants.dart';

@module
abstract class ExternalModules {
  @lazySingleton
  Dio provideDio() {
    Dio dio = Dio();
    dio.options.baseUrl = ApiConstants.baseUrl;
    dio.options.headers = {'Content-Type': 'application/json'};
    dio.interceptors.add(getIt.get<PrettyDioLogger>());
    dio.interceptors.add(getIt.get<TokenInterceptor>());
    return dio;
  }

  @lazySingleton
  PrettyDioLogger providePrettyDioLogger() {
    return PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
    );
  }

  @lazySingleton
  InternetConnectionChecker provideInternetConnectionChecker() =>
      InternetConnectionChecker.instance;

  @lazySingleton
  Location provideLocation() => Location();
  @lazySingleton
  FirebaseFirestore provideFirebaseFirestore() {
    return FirebaseFirestore.instance;
  }
}
