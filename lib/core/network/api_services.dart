import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flowers_ecommerce_app/core/network/api_constants.dart';
import 'package:flowers_ecommerce_app/features/add_to_cart/data/model/add_product_body.dart';
import 'package:flowers_ecommerce_app/features/add_to_cart/data/model/add_product_respone.dart';
import 'package:flowers_ecommerce_app/features/address_details/data/models/request/add_new_address_request_dto.dart';
import 'package:flowers_ecommerce_app/features/address_details/data/models/response/addresses_response_dto.dart';
import 'package:flowers_ecommerce_app/features/auth/forget_password/datasource/models/email_verify_model.dart';
import 'package:flowers_ecommerce_app/features/auth/forget_password/datasource/models/forget_pass_model.dart';
import 'package:flowers_ecommerce_app/features/auth/forget_password/datasource/models/reset_pass_model.dart';
import 'package:flowers_ecommerce_app/features/auth/login/data/model/request/login_request_dto.dart';
import 'package:flowers_ecommerce_app/features/auth/login/data/model/responce/login_responce_dto.dart';
import 'package:flowers_ecommerce_app/features/auth/register/data/model/register_body_dto.dart';
import 'package:flowers_ecommerce_app/features/auth/register/data/model/register_respone/register_respone_dto.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/data/models/response/edit_profile_response.dart';
import 'package:flowers_ecommerce_app/features/edit_profile/data/models/response/upload_photo_response.dart';
import 'package:flowers_ecommerce_app/features/products_detalis/data/model/get_specific_product_respone/get_specific_product_respone.dart';
import 'package:flowers_ecommerce_app/features/payment/data/model/request/payment_request_model_dto.dart';
import 'package:flowers_ecommerce_app/features/payment/data/model/responce/card_pay_responce/card_pay_responce_model_dto.dart';
import 'package:flowers_ecommerce_app/features/payment/data/model/responce/cash_pay_responce/cash_pay_responce_model_dto.dart';
import 'package:flowers_ecommerce_app/features/checkout/data/model/get_user_addreses_respone/get_user_addreses_respone.dart';
import 'package:flowers_ecommerce_app/features/orders/data/model/user_orders_respone/user_orders_respone.dart';
import 'package:flowers_ecommerce_app/features/search/data/models/reponse/search_response.dart';
import 'package:flowers_ecommerce_app/features/profile/data/model/user_response_dto.dart';
import 'package:flowers_ecommerce_app/features/cart/data/models/delete_cart_item_respone/delete_cart_item_respone.dart';
import 'package:flowers_ecommerce_app/features/cart/data/models/updeate_cart_prouduct_quantity_body.dart';
import 'package:flowers_ecommerce_app/features/cart/data/models/updeate_proudact_quantity_respone/updeate_proudact_quantity_respone.dart';
import 'package:flowers_ecommerce_app/features/cart/data/models/user_cart/user_cart.dart';
import 'package:flowers_ecommerce_app/features/home_screen/data/model/home_response_dto.dart';
import 'package:flowers_ecommerce_app/features/categories/data/models/response/category_response.dart';
import 'package:flowers_ecommerce_app/features/categories/data/models/response/product_response.dart';
import 'package:flowers_ecommerce_app/features/track_order/data/model/response/vehicle_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../features/auth/change_password/data/models/request/change_password_request_dto.dart';
import '../../features/auth/change_password/data/models/response/change_password_response_dto.dart';
import '../../features/saved_addresses/data/models/get_user_address_dto.dart';
import '../../features/saved_addresses/data/models/user_address_dto.dart';
import '../../features/auth/logout/data/models/logout_response_dto.dart';
import '../../features/occasions/data/models/occasions_response_dto.dart';
import '../utils/app_constants.dart';

part 'api_services.g.dart';

@RestApi()
@injectable
abstract class ApiServices {
  @factoryMethod
  factory ApiServices(Dio dio) = _ApiServices;

  @POST(ApiConstants.loginEndpoint)
  Future<LoginResponceDto> login(@Body() LoginRequestDto loginRequestDto);
  @GET(ApiConstants.homeEndpoint)
  Future<HomeResponseDto> homeData();

  @POST(ApiConstants.forgetPasswordEndpoint)
  Future<ForgetPasswordModel> forgetPassword(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.verifyResetCode)
  Future<EmailVerifyModel> verifyResetCode(@Body() Map<String, dynamic> body);

  @PUT(ApiConstants.resetPassword)
  Future<ResetPasswordModel> resetPassword(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.registerEndpoint)
  Future<RegisterResponeDto> register(@Body() RegisterBodyDTo request);

  @GET(ApiConstants.userData)
  Future<UserResponseProfileDto> userData();

  @GET(ApiConstants.cart)
  Future<UserCartDto> getUserCart();

  @PUT(ApiConstants.cartUD)
  Future<UpdeateProudactQuantityRespone> updeateCartProudctQuantity(
    @Path("id") String id,
    @Body() UpdeateCartProuductQuantityBody body,
  );

  @DELETE(ApiConstants.cartUD)
  Future<DeleteCartItemRespone> deleteCartProudct(@Path("id") String id);

  @GET(ApiConstants.getSpecificOccasion)
  Future<OccasionsResponseDto> getOccasions();

  @GET(ApiConstants.product)
  Future<ProductResponse> getAllProducts(@Query("sort") String? sortBy);

  @GET(ApiConstants.categories)
  Future<CategoryResponse> getAllCategory();

  @PATCH(ApiConstants.changePassword)
  Future<ChangePasswordResponseDto> changePassword(
    @Body() ChangePasswordRequestDto requestDto,
    @Header(ApiConstants.authorization) String token,
  );

  @PUT(ApiConstants.editProfile)
  Future<EditProfileResponse> editProfile(@Body() Map<String, dynamic> body);

  @MultiPart()
  @PUT(ApiConstants.uploadPhoto)
  Future<UploadPhotoResponse> uploadPhoto(@Part(name: "photo") File file);
  @POST(ApiConstants.paymendCard)
  Future<CardPayResponceModelDto> paymentCard(
    @Body() PaymentRequestModelDto paymentRequestModelDto,
  );
  @POST(ApiConstants.paymentCash)
  Future<CashPayResponceModelDto> paymentCash(
    @Body() PaymentRequestModelDto paymentRequestModelDto,
  );

  @GET(ApiConstants.addresses)
  Future<GetUserAddresesRespone> getLoggedUserAddresses();

  @POST(ApiConstants.cart)
  Future<AddProductRespone> addToCart(@Body() AddProductBody addProductBody);

  @GET(ApiConstants.orders)
  Future<UserOrdersRespone> getUserOrders();

  @PATCH(ApiConstants.address)
  Future<AddressesResponseDto> addNewAddress(
    @Header(ApiConstants.authorization) String token,
    @Body() AddNewAddressRequestDto requestDto,
  );

  @DELETE("${ApiConstants.deleteOrGetSavedAddress}/{id}")
  Future<UserAddressDto> removeAddress(
    @Header(ApiConstants.authorization) String token,
    @Path(AppConstants.id) String id,
  );

  @GET(ApiConstants.deleteOrGetSavedAddress)
  Future<GetUserAddressDto> getAllAddresses(
    @Header(ApiConstants.authorization) String token,
  );

  @GET(ApiConstants.search)
  Future<SearchResponse> search(@Query("keyword") String? keyword);

  @GET(ApiConstants.logout)
  Future<LogoutResponseDto> logout(
    @Header(ApiConstants.authorization) String token,
  );

  @GET(ApiConstants.products)
  Future<GetSpecificProductRespone> getSpecificProduct(
    @Path('productId') String productId,
  );

  @GET(ApiConstants.vehicles)
  Future<VehicleResponseDto> getVehicleById(
    @Path("vehicleId") String vehicleId,
  );
}
