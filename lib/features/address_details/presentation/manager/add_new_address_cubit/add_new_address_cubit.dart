import 'package:flowers_ecommerce_app/core/errors/api_results.dart';
import 'package:flowers_ecommerce_app/features/address_details/domain/entities/request/add_new_address_request_entity.dart';
import 'package:flowers_ecommerce_app/features/address_details/domain/entities/response/addresses_response_entity.dart';
import 'package:flowers_ecommerce_app/features/address_details/domain/entities/response/area_response_entity.dart';
import 'package:flowers_ecommerce_app/features/address_details/domain/entities/response/cities_response_entity.dart';
import 'package:flowers_ecommerce_app/features/address_details/domain/use_cases/add_new_address_use_case.dart';
import 'package:flowers_ecommerce_app/features/address_details/domain/use_cases/get_areas_use_case.dart';
import 'package:flowers_ecommerce_app/features/address_details/presentation/manager/add_new_address_cubit/add_new_address_event.dart';
import 'package:flowers_ecommerce_app/features/address_details/presentation/manager/add_new_address_cubit/add_new_address_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/use_cases/get_cities_use_case.dart';

@Singleton()
class AddressDetailsCubit extends Cubit<AddressDetailsState> {
  AddressDetailsCubit(
    this.addNewAddressUseCase,
    this.getCitiesUseCase,
    this.getAreasUseCase,
  ) : super(const AddressDetailsState());
  final AddNewAddressUseCase addNewAddressUseCase;
  final GetCitiesUseCase getCitiesUseCase;
  final GetAreasUseCase getAreasUseCase;

  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final TextEditingController address = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController long = TextEditingController();
  final TextEditingController lat = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController area = TextEditingController();

  // var lang = getIt.get<SharedPrefHelper>().getData(key: Constants.languageCode);

  doIntent(AddressDetailsEvent event) {
    switch (event) {
      case AddNewAddressEvent():
        return _addNewAddress();
      case GetAreasAndCitiesEvent():
        return _getCitiesAndAreas();
    }
  }

  Future<void> _addNewAddress() async {
    if (isClosed) return;
    emit(state.copyWith(isLoading: true, isSuccess: false, errorMsg: null));
    var response = await addNewAddressUseCase.invoke(
      AddNewAddressRequestEntity(
        street: area.text,
        phone: phone.text,
        city: city.text,
        lat: lat.text,
        long: long.text,
        username: username.text,
      ),
    );
    switch (response) {
      case ApiSuccessResult<AddressesResponseEntity>():
        if (isClosed) return;
        emit(state.copyWith(isLoading: false, isSuccess: true));
        break;
      case ApiErrorResult<AddressesResponseEntity>():
        if (isClosed) return;
        emit(
          state.copyWith(
            isLoading: false,
            errorMsg: response.failure.errorMessage,
          ),
        );
        break;
    }
  }

  Future<void> _getCitiesAndAreas() async {
    await _getCities();
    await _getAreas();
  }

  Future<void> _getCities() async {
    emit(state.copyWith(isLoadingGetPLaces: true, errorGetCities: null));
    var response = await getCitiesUseCase.invoke();
    switch (response) {
      case ApiSuccessResult<CitiesResponseEntity>():
        // List<String> cities = response.data.data!
        //     .map((area) => lang == Constants.enKey
        //     ? (area.governorateNameEn ?? '')
        //     : (area.governorateNameAr ?? ''))
        //     .toList();
        List<String> cities = response.data.data!
            .map((city) => city.governorateNameEn ?? "")
            .toList();
        emit(state.copyWith(isLoadingGetPLaces: false, cities: cities));
      case ApiErrorResult<CitiesResponseEntity>():
        emit(
          state.copyWith(
            isLoadingGetPLaces: false,
            errorGetCities: response.failure.errorMessage,
          ),
        );
    }
  }

  Future<void> _getAreas() async {
    emit(state.copyWith(isLoadingGetPLaces: true, errorGetAreas: null));
    var response = await getAreasUseCase.invoke();
    switch (response) {
      case ApiSuccessResult<AreaResponseEntity>():
        // List<String> areas = response.data.data!
        //     .map((area) => lang == Constants.enKey
        //     ? (area.cityNameEn ?? '')
        //     : (area.cityNameAr ?? ''))
        //     .toList();
        List<String> areas = response.data.data!
            .map((area) => area.cityNameEn ?? "")
            .toList();
        emit(state.copyWith(isLoadingGetPLaces: false, areas: areas));
      case ApiErrorResult<AreaResponseEntity>():
        emit(
          state.copyWith(
            isLoadingGetPLaces: false,
            errorGetCities: response.failure.errorMessage,
          ),
        );
    }
  }

  void updateSelectedCity(String? selected) {
    if (selected != null) {
      city.text = selected;
    }
  }

  void updateSelectedArea(String? selected) {
    if (selected != null) {
      area.text = selected;
    }
  }

  void updateLatLong(double latValue, double longValue) {
    lat.text = latValue.toString();
    long.text = longValue.toString();
  }
}
