import 'package:bloc/bloc.dart';
import 'package:flowers_ecommerce_app/features/add_to_cart/domin/usecase/add_to_cart_usecase.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/api_results.dart';
import '../../data/model/add_product_body.dart';
import 'add_to_cart_event.dart';
import 'add_to_cart_state.dart';

@injectable
class AddToCartCubit extends Cubit<AddToCartState> {
  final AddToCartUsecase addProductToCartUsecase;

  AddToCartCubit(this.addProductToCartUsecase) : super(const AddToCartState());

  Future<void> doIntent(AddToCartEvent event) async {
    switch (event) {
      case AddProductToCart():
        await _addProductToCart(event.productId);
    }
  }

  Future<bool> _addProductToCart(String productId) async {
    emit(
      state.copyWith(
        isLoading: true,
        errorMsg: '',
        loadingProductId: productId,
      ),
    );
    final result = await addProductToCartUsecase.invoke(
      AddProductBody(product: productId, quantity: 1),
    );
    switch (result) {
      case ApiSuccessResult():
        emit(
          state.copyWith(
            isSucsses: true,
            isLoading: false,
            errorMsg: '',
            loadingProductId: null,
          ),
        );
        return true;
      case ApiErrorResult():
        emit(
          state.copyWith(
            isLoading: false,
            isSucsses: false,
            errorMsg: result.failure.errorMessage,
            loadingProductId: null,
          ),
        );
        return false;
    }
  }
}
