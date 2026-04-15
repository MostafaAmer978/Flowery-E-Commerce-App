import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'translations/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @enter_your_email.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enter_your_email;

  /// No description provided for @enter_your_password.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enter_your_password;

  /// No description provided for @remember_me.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get remember_me;

  /// No description provided for @forget_password.
  ///
  /// In en, this message translates to:
  /// **'Forget password'**
  String get forget_password;

  /// No description provided for @dont_have_an_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account'**
  String get dont_have_an_account;

  /// No description provided for @sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get sign_up;

  /// No description provided for @continue_as_guest.
  ///
  /// In en, this message translates to:
  /// **'Continue as guest'**
  String get continue_as_guest;

  /// No description provided for @enter_first_name.
  ///
  /// In en, this message translates to:
  /// **'Enter first name'**
  String get enter_first_name;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @first_name.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get first_name;

  /// No description provided for @enter_last_name.
  ///
  /// In en, this message translates to:
  /// **'Enter last name'**
  String get enter_last_name;

  /// No description provided for @last_name.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get last_name;

  /// No description provided for @enter_password.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get enter_password;

  /// No description provided for @confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirm_password;

  /// No description provided for @enter_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number'**
  String get enter_phone_number;

  /// No description provided for @phone_number.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phone_number;

  /// No description provided for @already_have_an_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get already_have_an_account;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @terms_conditions.
  ///
  /// In en, this message translates to:
  /// **'Terms&Conditions'**
  String get terms_conditions;

  /// No description provided for @agree_to_our.
  ///
  /// In en, this message translates to:
  /// **'Creating an account, you agree to our'**
  String get agree_to_our;

  /// No description provided for @acount_created_successfully.
  ///
  /// In en, this message translates to:
  /// **'Account created successfully'**
  String get acount_created_successfully;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @no_internet_connection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get no_internet_connection;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @login_successfully.
  ///
  /// In en, this message translates to:
  /// **'Login successfully'**
  String get login_successfully;

  /// No description provided for @register_successfully.
  ///
  /// In en, this message translates to:
  /// **'Register Successfully'**
  String get register_successfully;

  /// No description provided for @egp.
  ///
  /// In en, this message translates to:
  /// **'EGP'**
  String get egp;

  /// No description provided for @view_all.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get view_all;

  /// No description provided for @product_details.
  ///
  /// In en, this message translates to:
  /// **'Product Details'**
  String get product_details;

  /// No description provided for @cart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @loding.
  ///
  /// In en, this message translates to:
  /// **'Loding...'**
  String get loding;

  /// No description provided for @all_products_include_tax.
  ///
  /// In en, this message translates to:
  /// **'All prices include tax'**
  String get all_products_include_tax;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @out_of_stock.
  ///
  /// In en, this message translates to:
  /// **'out of stock'**
  String get out_of_stock;

  /// No description provided for @in_stock.
  ///
  /// In en, this message translates to:
  /// **'in stock'**
  String get in_stock;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @best_seller.
  ///
  /// In en, this message translates to:
  /// **'Best seller'**
  String get best_seller;

  /// No description provided for @occasion.
  ///
  /// In en, this message translates to:
  /// **'Occasion'**
  String get occasion;

  /// No description provided for @flower.
  ///
  /// In en, this message translates to:
  /// **'Flower'**
  String get flower;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @email_not_valid.
  ///
  /// In en, this message translates to:
  /// **'This Email is not valid'**
  String get email_not_valid;

  /// No description provided for @email_required.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get email_required;

  /// No description provided for @password_not_valid.
  ///
  /// In en, this message translates to:
  /// **'Invalid password'**
  String get password_not_valid;

  /// No description provided for @password_empty.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get password_empty;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @about_us.
  ///
  /// In en, this message translates to:
  /// **'About us'**
  String get about_us;

  /// No description provided for @change_language.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get change_language;

  /// No description provided for @my_order.
  ///
  /// In en, this message translates to:
  /// **'My orders'**
  String get my_order;

  /// No description provided for @saved_address.
  ///
  /// In en, this message translates to:
  /// **'Saved address'**
  String get saved_address;

  /// No description provided for @reset_password.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get reset_password;

  /// No description provided for @current_password.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get current_password;

  /// No description provided for @new_password.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get new_password;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @password_changed_successfully.
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully'**
  String get password_changed_successfully;

  /// No description provided for @please_enter_your_email_associated_to_your_account.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email associated to\n your account'**
  String get please_enter_your_email_associated_to_your_account;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @email_verification.
  ///
  /// In en, this message translates to:
  /// **'Email verification'**
  String get email_verification;

  /// No description provided for @please_enter_your_code_that_send_to_your_email_address.
  ///
  /// In en, this message translates to:
  /// **'Please enter your code that send to your\n email address'**
  String get please_enter_your_code_that_send_to_your_email_address;

  /// No description provided for @didnot_receive_code.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive code? '**
  String get didnot_receive_code;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @password_must_not_be_empty_and_must_contain_6_characters_with_upper_case_letter_and_one_number_at_least.
  ///
  /// In en, this message translates to:
  /// **'Password must not be empty and must contain\n 6 characters with upper case letter and one\n number at least'**
  String
  get password_must_not_be_empty_and_must_contain_6_characters_with_upper_case_letter_and_one_number_at_least;

  /// No description provided for @password_is_required.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get password_is_required;

  /// No description provided for @password_must_be_at_least_6_characters.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get password_must_be_at_least_6_characters;

  /// No description provided for @passwords_do_not_match.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwords_do_not_match;

  /// No description provided for @edit_profile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get edit_profile;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @profile_updated_successfully.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profile_updated_successfully;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @first_name_is_required.
  ///
  /// In en, this message translates to:
  /// **'First Name is required'**
  String get first_name_is_required;

  /// No description provided for @last_name_is_required.
  ///
  /// In en, this message translates to:
  /// **'Last Name is required'**
  String get last_name_is_required;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @enter_your_city.
  ///
  /// In en, this message translates to:
  /// **'Enter your city'**
  String get enter_your_city;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @enter_your_phone.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone'**
  String get enter_your_phone;

  /// No description provided for @street.
  ///
  /// In en, this message translates to:
  /// **'Street'**
  String get street;

  /// No description provided for @enter_your_street.
  ///
  /// In en, this message translates to:
  /// **'Enter your street'**
  String get enter_your_street;

  /// No description provided for @add_new.
  ///
  /// In en, this message translates to:
  /// **'Add New'**
  String get add_new;

  /// No description provided for @its_a_gift.
  ///
  /// In en, this message translates to:
  /// **'It\'s a gift'**
  String get its_a_gift;

  /// No description provided for @delivery_address.
  ///
  /// In en, this message translates to:
  /// **'Delivery Address'**
  String get delivery_address;

  /// No description provided for @no_addresses_found.
  ///
  /// In en, this message translates to:
  /// **'No addresses found'**
  String get no_addresses_found;

  /// No description provided for @place_order.
  ///
  /// In en, this message translates to:
  /// **'Place order'**
  String get place_order;

  /// No description provided for @subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// No description provided for @delivery_fee.
  ///
  /// In en, this message translates to:
  /// **'Delivery fee'**
  String get delivery_fee;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @checkout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout;

  /// No description provided for @credit_card.
  ///
  /// In en, this message translates to:
  /// **'Credit card'**
  String get credit_card;

  /// No description provided for @cash_on_delivery.
  ///
  /// In en, this message translates to:
  /// **'Cash on delivery'**
  String get cash_on_delivery;

  /// No description provided for @payment_method.
  ///
  /// In en, this message translates to:
  /// **'Payment method'**
  String get payment_method;

  /// No description provided for @schedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get schedule;

  /// No description provided for @delevery_time.
  ///
  /// In en, this message translates to:
  /// **'Delivery time'**
  String get delevery_time;

  /// No description provided for @my_orders.
  ///
  /// In en, this message translates to:
  /// **'My orders'**
  String get my_orders;

  /// No description provided for @track_order.
  ///
  /// In en, this message translates to:
  /// **'Track Order'**
  String get track_order;

  /// No description provided for @reorder.
  ///
  /// In en, this message translates to:
  /// **'Reorder'**
  String get reorder;

  /// No description provided for @order_number.
  ///
  /// In en, this message translates to:
  /// **'Order Number'**
  String get order_number;

  /// No description provided for @delivered_on.
  ///
  /// In en, this message translates to:
  /// **'Delivered on'**
  String get delivered_on;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @no_product_found.
  ///
  /// In en, this message translates to:
  /// **'No Product Found'**
  String get no_product_found;

  /// No description provided for @add_to_Cart.
  ///
  /// In en, this message translates to:
  /// **'Add To Cart'**
  String get add_to_Cart;

  /// No description provided for @search_for_any_product_you_want.
  ///
  /// In en, this message translates to:
  /// **'Search For Any Product You Want'**
  String get search_for_any_product_you_want;

  /// No description provided for @enter_the_address.
  ///
  /// In en, this message translates to:
  /// **'Enter the address'**
  String get enter_the_address;

  /// No description provided for @enter_the_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Enter the phone number'**
  String get enter_the_phone_number;

  /// No description provided for @recipient_name.
  ///
  /// In en, this message translates to:
  /// **'Recipient name'**
  String get recipient_name;

  /// No description provided for @enter_the_recipient_name.
  ///
  /// In en, this message translates to:
  /// **'Enter the recipient name'**
  String get enter_the_recipient_name;

  /// No description provided for @area.
  ///
  /// In en, this message translates to:
  /// **'Area'**
  String get area;

  /// No description provided for @save_address.
  ///
  /// In en, this message translates to:
  /// **'Save Address'**
  String get save_address;

  /// No description provided for @this_field_is_required.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get this_field_is_required;

  /// No description provided for @saved_address_successfully.
  ///
  /// In en, this message translates to:
  /// **'Saved Address Successfully'**
  String get saved_address_successfully;

  /// No description provided for @saved_addresses.
  ///
  /// In en, this message translates to:
  /// **'Saved Addresses'**
  String get saved_addresses;

  /// No description provided for @no_addresses_yet.
  ///
  /// In en, this message translates to:
  /// **'No Addresses Yet , Press on Add Address to Add New One'**
  String get no_addresses_yet;

  /// No description provided for @add_new_address.
  ///
  /// In en, this message translates to:
  /// **'Add New Address'**
  String get add_new_address;

  /// No description provided for @confirm_logout.
  ///
  /// In en, this message translates to:
  /// **'Confirm Logout!!'**
  String get confirm_logout;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @logout_successfully.
  ///
  /// In en, this message translates to:
  /// **'Logout Successfully'**
  String get logout_successfully;

  /// No description provided for @bloom_with_our_exquisite_best_sellers.
  ///
  /// In en, this message translates to:
  /// **'Bloom with our exquisite best sellers'**
  String get bloom_with_our_exquisite_best_sellers;

  /// No description provided for @no_products.
  ///
  /// In en, this message translates to:
  /// **'No Products founded'**
  String get no_products;

  /// No description provided for @bloom_with.
  ///
  /// In en, this message translates to:
  /// **'Bloom with our exquisite best sellers'**
  String get bloom_with;

  /// No description provided for @you_should_login.
  ///
  /// In en, this message translates to:
  /// **'You should login first'**
  String get you_should_login;

  /// No description provided for @some_thing_went_wrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get some_thing_went_wrong;

  /// No description provided for @your_cart_is_empty.
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty'**
  String get your_cart_is_empty;

  /// No description provided for @add_to_cart.
  ///
  /// In en, this message translates to:
  /// **'Add to cart'**
  String get add_to_cart;

  /// No description provided for @remove_from_cart.
  ///
  /// In en, this message translates to:
  /// **'Remove from cart'**
  String get remove_from_cart;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @items.
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get items;

  /// No description provided for @order_summary.
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get order_summary;

  /// No description provided for @order_placed_successfully.
  ///
  /// In en, this message translates to:
  /// **'Order placed successfully'**
  String get order_placed_successfully;

  /// No description provided for @order_placed.
  ///
  /// In en, this message translates to:
  /// **'Order Placed'**
  String get order_placed;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'logout'**
  String get logout;

  /// No description provided for @payment_cancled.
  ///
  /// In en, this message translates to:
  /// **'Payment Canceled'**
  String get payment_cancled;

  /// No description provided for @your_oredr_placed.
  ///
  /// In en, this message translates to:
  /// **'Your Oredr Placed'**
  String get your_oredr_placed;

  /// No description provided for @successfully.
  ///
  /// In en, this message translates to:
  /// **'Successfully'**
  String get successfully;

  /// No description provided for @no_products_found.
  ///
  /// In en, this message translates to:
  /// **'No Products Found'**
  String get no_products_found;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @sort_by.
  ///
  /// In en, this message translates to:
  /// **'Sort by'**
  String get sort_by;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
