import 'package:dio/dio.dart';
import 'package:flowers_ecommerce_app/core/errors/api_results.dart';
import 'package:flowers_ecommerce_app/core/errors/failures.dart';
import 'package:flowers_ecommerce_app/core/utils/app_constants.dart';
import 'package:flowers_ecommerce_app/features/auth/register/data/mapper/to_register_body_dto.dart';
import 'package:flowers_ecommerce_app/features/auth/register/data/source/auth_remote_data_sourse.dart';
import 'package:flowers_ecommerce_app/features/auth/register/domin/entites/register_body.dart';
import 'package:flowers_ecommerce_app/features/auth/register/domin/entites/register_respone.dart';
import 'package:flowers_ecommerce_app/features/auth/register/domin/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepoImpl(this._authRemoteDataSource);
  @override
  Future<ApiResult<RegisterRespone>> register(RegisterBody request) async {
    // final bool isConnected =
    //     await InternetConnectionChecker.instance.hasConnection;
    //
    // if (!isConnected) {
    //   return ApiErrorResult(
    //     failure: Failure(errorMessage: AppConstants.noInternet),
    //   );
    // }
    try {
      var respone = await _authRemoteDataSource.register(
        toRegisterBodyDTo(request),
      );
      return ApiSuccessResult(data: respone.toEntity());
    } on DioException catch (e) {
      return ApiErrorResult(
        failure: Failure(errorMessage: e.response!.data[AppConstants.error]),
      );
    } catch (e) {
      return ApiErrorResult(failure: Failure(errorMessage: e.toString()));
    }
  }
}
