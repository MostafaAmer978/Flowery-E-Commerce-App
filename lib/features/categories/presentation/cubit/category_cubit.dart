import 'package:bloc/bloc.dart';
import 'package:flowers_ecommerce_app/core/errors/api_results.dart';
import 'package:flowers_ecommerce_app/core/errors/failures.dart';
import 'package:flowers_ecommerce_app/features/categories/domain/entity/category_model.dart';
import 'package:flowers_ecommerce_app/features/categories/domain/entity/product_response_entity.dart';
import 'package:flowers_ecommerce_app/features/categories/domain/entity/products_entity.dart';
import 'package:flowers_ecommerce_app/features/categories/domain/usecases/category_usecase.dart';
import 'package:flowers_ecommerce_app/features/categories/domain/usecases/product_usecase.dart';
import 'package:flowers_ecommerce_app/features/categories/presentation/cubit/category_event.dart';
import 'package:injectable/injectable.dart';

import 'category_state.dart';

@injectable
class CategoryCubit extends Cubit<CategoryState> {
  String? lastSelectedFilter;
  GetAllCategoryUseCase getAllCategoryUseCase;
  GetAllProductsUseCase getAllProductsUseCase;

  CategoryCubit({
    required this.getAllCategoryUseCase,
    required this.getAllProductsUseCase,
  }) : super(CategoryState.initial());

  Future<void> doIntent(CategoryEvent event) async {
    switch (event) {
      case GetAllCategoryEvent():
        await _getAllCategories();
        break;
      case GetAllProductsEvent():
        await _getAllProducts(event.sortBy);
        break;
      case ProductsByCategoryId():
        await _productsByCategoryId(event.categoryId);
        break;
    }
  }

  void setLastSelectedFilter(String? filter) {
    lastSelectedFilter = filter;
    emit(state.copyWith());
  }

  Future<void> _getAllCategories() async {
    emit(state.copyWith(isLoading: true));
    ApiResult<List<CategoryModel>> result = await getAllCategoryUseCase.call();
    switch (result) {
      case ApiSuccessResult<List<CategoryModel>>():
        emit(
          state.copyWith(
            isSuccess: true,
            isLoading: false,
            listCategoryModel: result.data,
          ),
        );
      case ApiErrorResult<List<CategoryModel>>():
        emit(
          state.copyWith(
            isError: true,
            isLoading: false,
            errorMessage: Failure(
              errorMessage: result.failure.errorMessage,
              code: result.failure.code,
            ),
          ),
        );
    }
  }

  Future<void> _getAllProducts(String? sortBy) async {
    emit(state.copyWith(isLoading: true));
    ApiResult<ProductResponseEntity> result = await getAllProductsUseCase.call(
      sortBy,
    );
    switch (result) {
      case ApiSuccessResult<ProductResponseEntity>():
        final allProducts = result.data.products ?? [];

        List<ProductsEntity> filtered = [];
        if (state.listCategoryModel.isNotEmpty) {
          final firstCategoryId = state.listCategoryModel.first.id;
          filtered = allProducts
              .where((p) => p.category == firstCategoryId)
              .toList();
        }
        emit(
          state.copyWith(
            isSuccess: true,
            isLoading: false,
            dataLoading: true,
            allProducts: allProducts,
            filteredProducts: filtered,
          ),
        );
      case ApiErrorResult<ProductResponseEntity>():
        emit(
          state.copyWith(
            isError: true,
            isLoading: false,
            errorMessage: Failure(
              errorMessage: result.failure.errorMessage,
              code: result.failure.code,
            ),
          ),
        );
    }
  }

  Future<void> _productsByCategoryId(String categoryId) async {
    final products = state.allProducts;

    final filteredProducts = products
        .where((product) => product.category == categoryId)
        .toList();

    emit(state.copyWith(filteredProducts: filteredProducts));
  }

  String getDiscountPercentage(int? price, int? priceAfterDiscount) {
    if (price == null || priceAfterDiscount == null) return "";
    if (price <= 0 || priceAfterDiscount >= price) {
      return "";
    }
    final discount = ((price - priceAfterDiscount) / price) * 100;
    return "${discount.round()}%";
  }
}
