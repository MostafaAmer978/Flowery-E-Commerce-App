import 'package:flowers_ecommerce_app/core/errors/api_results.dart';
import 'package:flowers_ecommerce_app/features/categories/data/datasources/remote/product_remote_datasource.dart';
import 'package:flowers_ecommerce_app/features/categories/domain/entity/product_response_entity.dart';
import 'package:flowers_ecommerce_app/features/categories/domain/repository/product_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: GetAllProductsRepositoryContract)
class GetAllProductsRepositoryImpl implements GetAllProductsRepositoryContract {
  GetAllProductsRemoteDatasource getAllProductsRemoteDatasource;

  GetAllProductsRepositoryImpl({required this.getAllProductsRemoteDatasource});

  @override
  Future<ApiResult<ProductResponseEntity>> getAllProducts(
    String? sortBy,
  ) async {
    ApiResult<ProductResponseEntity> result =
        await getAllProductsRemoteDatasource.getAllProducts(sortBy);
    return result;
  }
}
