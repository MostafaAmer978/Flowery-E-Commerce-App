import 'package:flowers_ecommerce_app/core/errors/api_results.dart';
import 'package:flowers_ecommerce_app/features/categories/domain/entity/product_response_entity.dart';
import 'package:flowers_ecommerce_app/features/categories/domain/repository/product_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllProductsUseCase {
  GetAllProductsRepositoryContract getAllProductsRepositoryContract;

  GetAllProductsUseCase({required this.getAllProductsRepositoryContract});

  Future<ApiResult<ProductResponseEntity>> call(String? sortBy) async {
    ApiResult<ProductResponseEntity> result =
        await getAllProductsRepositoryContract.getAllProducts(sortBy);
    return result;
  }
}
