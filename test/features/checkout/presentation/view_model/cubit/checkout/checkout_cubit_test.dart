import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_ecommerce_app/core/errors/api_results.dart';
import 'package:flowers_ecommerce_app/core/errors/failures.dart';
import 'package:flowers_ecommerce_app/features/checkout/domin/entities/address.dart';
import 'package:flowers_ecommerce_app/features/checkout/domin/usecase/get_logged_user_addresses_usecase.dart';
import 'package:flowers_ecommerce_app/features/checkout/presentation/view_model/cubit/checkout/checkout_cubit.dart';
import 'package:flowers_ecommerce_app/features/payment/domain/use_case/payment_card_use_case.dart';
import 'package:flowers_ecommerce_app/features/payment/domain/use_case/payment_cash_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'checkout_cubit_test.mocks.dart';

@GenerateMocks([
  GetLoggedUserAddressesUsecase,
  PaymentCardUseCase,
  PaymentCashUseCase,
])
void main() {
  late CheckoutCubit cubit;
  late MockGetLoggedUserAddressesUsecase mockUsecase;
  late MockPaymentCardUseCase mockPaymentCardUseCase;
  late MockPaymentCashUseCase mockPaymentCashUseCase;

  setUpAll(() {
    mockPaymentCardUseCase = MockPaymentCardUseCase();
    mockPaymentCashUseCase = MockPaymentCashUseCase();
    provideDummy<ApiResult<List<Address>>>(ApiSuccessResult(data: []));
  });

  setUp(() {
    mockUsecase = MockGetLoggedUserAddressesUsecase();
    cubit = CheckoutCubit(
      mockUsecase,
      mockPaymentCardUseCase,
      mockPaymentCashUseCase,
    );
  });

  final address = Address(id: '1', city: 'Cairo', street: 'Street 1');

  group('getLoggedUserAddresses', () {
    blocTest<CheckoutCubit, CheckoutState>(
      'emits [loading, success] when getLoggedUserAddresses succeeds',
      build: () {
        when(
          mockUsecase.invok(),
        ).thenAnswer((_) async => ApiSuccessResult(data: [address]));
        return cubit;
      },
      act: (cubit) => cubit.getLoggedUserAddresses(),
      expect: () => [
        cubit.state.copyWith(isLoading: true, addresses: []),
        cubit.state.copyWith(isLoading: false, addresses: [address]),
      ],
    );

    blocTest<CheckoutCubit, CheckoutState>(
      'emits [loading, error] when getLoggedUserAddresses fails',
      build: () {
        when(mockUsecase.invok()).thenAnswer(
          (_) async => ApiErrorResult(failure: Failure(errorMessage: "error")),
        );
        return cubit;
      },
      act: (cubit) => cubit.getLoggedUserAddresses(),
      expect: () => [
        cubit.state.copyWith(isLoading: true),
        cubit.state.copyWith(isLoading: false),
      ],
    );

    blocTest<CheckoutCubit, CheckoutState>(
      'updates gift fields step by step',
      build: () => CheckoutCubit(
        mockUsecase,
        mockPaymentCardUseCase,
        mockPaymentCashUseCase,
      ),
      act: (cubit) {
        cubit.toggleGift(true);
        cubit.updateGiftStreet("Street X");
        cubit.updateGiftPhone("0100000000");
        cubit.updateGiftCity("Giza");
      },
      expect: () => [
        cubit.state.copyWith(
          isGift: true,
          selectedPaymentMethod: PaymentMethod.creditCard,
          giftStreet: '',
          giftPhone: '',
          giftCity: '',
        ),
        cubit.state.copyWith(
          isGift: true,
          giftStreet: "Street X",
          giftPhone: '',
          giftCity: '',
          selectedPaymentMethod: PaymentMethod.creditCard,
        ),
        cubit.state.copyWith(
          isGift: true,
          giftStreet: "Street X",
          giftPhone: "0100000000",
          giftCity: '',
          selectedPaymentMethod: PaymentMethod.creditCard,
        ),
        cubit.state.copyWith(
          isGift: true,
          giftStreet: "Street X",
          giftPhone: "0100000000",
          giftCity: "Giza",
          selectedPaymentMethod: PaymentMethod.creditCard,
        ),
      ],
    );
  });
}
