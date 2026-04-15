import 'package:equatable/equatable.dart';

class AddToCartState extends Equatable {
  final bool isSucsses;
  final bool isLoading;
  final String? loadingProductId;

  final String errorMsg;

  const AddToCartState({
    this.isSucsses = false,
    this.errorMsg = '',
    this.isLoading = false,
    this.loadingProductId,
  });

  AddToCartState copyWith({
    bool? isSucsses,
    String? errorMsg,
    bool? isLoading,
    String? loadingProductId,
  }) {
    return AddToCartState(
      isSucsses: isSucsses ?? this.isSucsses,
      errorMsg: errorMsg ?? this.errorMsg,
      isLoading: isLoading ?? this.isLoading,
      loadingProductId: loadingProductId ?? this.loadingProductId,
    );
  }

  @override
  List<Object?> get props => [isSucsses, errorMsg, isLoading, loadingProductId];
}
