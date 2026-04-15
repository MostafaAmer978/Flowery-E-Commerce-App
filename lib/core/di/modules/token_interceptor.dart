import 'package:dio/dio.dart';
import 'package:flowers_ecommerce_app/core/di/di.dart';
import 'package:flowers_ecommerce_app/core/services/token_service.dart';
import 'package:flowers_ecommerce_app/core/utils/app_constants.dart';
import 'package:injectable/injectable.dart';

@injectable
class TokenInterceptor extends Interceptor {
  final TokenService tokenService = getIt.get<TokenService>();
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final String? token = await tokenService.getToken();
    if (token != null) {
      options.headers[AppConstants.authorization] = "Bearer $token";
    }
    return super.onRequest(options, handler);
  }
}
