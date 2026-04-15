import 'package:dio/dio.dart';
import 'package:flowers_ecommerce_app/core/errors/api_results.dart';
import 'package:flowers_ecommerce_app/core/errors/failures.dart';
import 'package:flowers_ecommerce_app/core/network/api_services.dart';
import 'package:flowers_ecommerce_app/features/categories/data/models/response/product_response.dart';
import 'package:flowers_ecommerce_app/features/categories/domain/entity/product_response_entity.dart';
import 'package:injectable/injectable.dart';

import 'product_remote_datasource.dart';

@Injectable(as: GetAllProductsRemoteDatasource)
class GetAllProductsRemoteDatasourceImpl
    implements GetAllProductsRemoteDatasource {
  ApiServices apiServices;

  GetAllProductsRemoteDatasourceImpl({required this.apiServices});

  @override
  Future<ApiResult<ProductResponseEntity>> getAllProducts(
    String? sortBy,
  ) async {
    try {
      ProductResponse response = await apiServices.getAllProducts(sortBy);
      ProductResponseEntity responseEntity = response.toEntity();
      return ApiSuccessResult<ProductResponseEntity>(data: responseEntity);
    } on DioException catch (error) {
      return ApiErrorResult<ProductResponseEntity>(
        failure: ServerFailure.fromDioError(dioException: error),
      );
    } catch (e) {
      return ApiErrorResult<ProductResponseEntity>(
        failure: Failure(errorMessage: e.toString()),
      );
    }
  }
}
