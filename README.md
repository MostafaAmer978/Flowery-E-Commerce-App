## 🌸 Flowery E-Commerce App

**Flowery — a Flutter-based mobile e-commerce application for selling flowers and related products.**

---

## Project Overview
Flowery is a cross-platform (Android / iOS) Flutter e-commerce application focused on shopping for flowers and related items. It follows production-ready development practices including CI automation and code generation.

---

## Tech Stack
- **Flutter** (UI)
- **Dart** (language)
- **Bloc** for state management
- **Dio + Retrofit** for networking
- **json_serializable** for model generation
- **Injectable** for dependency injection
- **Cached Network Image** for optimized images
- **mockito** for testing

---

## Architecture
- **Clean Architecture Inspired**
- Data / Domain / Presentation separation
- **Bloc/Cubit** for state management With MVI Pattern
- **Code generation** for DI, networking, models
- **shared prefrences & flutter secure** for local cashing and token saver
---

## Features
- Product listing and details
- Product search functionality
- Flower categories
- Secure authentication
- Local caching
- Modern UI/UX for smooth shopping
- Cart and checkout flow

---

## Testing
- Unit testing using `flutter_test`
- Mocks using `mockito`
- Test command:
```bash
flutter test
```

---

## Folder Structure
```
lib/
├── config/                         # Global app configurations
│   ├── routing/                    # Navigation & route management
│   └── theme/                      # Light/Dark themes setup

├── core/                           # Shared base layer used by all features
│   ├── components/                 # Reusable custom widgets
│   ├── di/                         # Dependency Injection (Injectable setup)
│   ├── errors/                     # Failure models + Safe API call handler
│   ├── helpers/                    # Toasts, dialogs, spacing helpers, validators
│   ├── l10n/                       # Localization (EN/AR) files and setup
│   ├── network/                    # Networking base (Dio interceptors, client setup)
│   ├── providers/                  # Theme & locale providers
│   ├── services/                   # App level services (Token, Firebase, etc.)
│   └── utils/                      # App constants, keys, assets utilities

├── features/                       # Modular features (Fully independent)
│   ├── auth/
│   │   ├── data/
│   │   │   ├── data_source/        # Remote/Local data sources
│   │   │   ├── models/             # DTOs with json_serializable
│   │   │   └── repositories_impl/  # Repository implementations
│   │   ├── domain/
│   │   │   ├── entities/           # Business entities
│   │   │   ├── repositories/       # Repository contracts
│   │   │   └── usecases/           # Auth use cases
│   │   └── presentation/
│   │       ├── view_models/        # BLoC / Cubit state management
│   │       ├── screens/            # UI pages
│   │       └── widgets/            # Feature-specific widgets
│   │
│   ├── home/                       # Same structure for each feature
│   ├── product/
│   └── cart/

├── firebase_options.dart           # Firebase configuration file
└── main.dart                       # Application entry point

```

---

## How to Run the Project
1. Install Flutter (stable channel recommended)
2. Get dependencies:
```bash
flutter pub get
```
3. Generate code:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```
4. Run the app:
```bash
flutter run
```
5. Build an APK:
```bash
flutter build apk --release
```

---

## CI / CD
- GitHub Actions for linting, pull request title, branch name, unit testing, soner qube, building & distribution
- Fastlane workflow for Firebase App Distribution

---

## Future Improvements
- Full integration tests for critical flows
- Release automation & versioning setup
- Enhanced analytics & performance monitoring
- Screen previews and demo videos
- Secure environment variables for API configuration

---

## 📱 Screenshots

<div align="center">

<!-- Login & Sign Up -->
<h3>Authentication Screens</h3>
<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/8bb2bf5a-a27e-4fa5-9cc7-9f9bfb880482" width="250" alt="login"/></td>
    <td><img src="https://github.com/user-attachments/assets/601a0384-adb8-48b3-a0bd-0d3f8b2e58ce" width="250" alt="sign_up"/></td>
    <td><img src="https://github.com/user-attachments/assets/8e87ef92-97cc-4e2a-85ef-e10ff9f9fcbd" width="250" alt="forgot1"/></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/1db116be-4708-4e81-8b73-b764d7d62eb6" width="250" alt="code"/></td>
    <td><img src="https://github.com/user-attachments/assets/013248f3-03e2-489e-8643-90865ecc6e84" width="250" alt="new_pass"/></td>
  </tr>
</table>

<br/>

<!-- Home -->
<h3>Home Screens</h3>
<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/e9f11761-cd8d-43cb-a072-77eafd8e490b" width="250" alt="home_screen"/></td>
    <td><img src="https://github.com/user-attachments/assets/44232a4e-0c0b-4889-b836-0ea1c8d6c36f" width="250" alt="home_screen_2"/></td>
    <td><img src="https://github.com/user-attachments/assets/7342e49a-8437-4c66-af26-250841463a2d" width="250" alt="occasions"/></td>
    <td><img src="https://github.com/user-attachments/assets/420396bd-ece9-4575-a05c-336d8dd139ae" width="250" alt="occasions_2"/></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/50db8fa9-60c3-4d8a-ac33-1ebffc39c1ad" width="250" alt="categories"/></td>
    <td><img src="https://github.com/user-attachments/assets/44e2ab4b-323b-4ecb-84a7-5cee1f7506c9" width="250" alt="order_details"/></td>
    <td><img src="https://github.com/user-attachments/assets/6b2fbfa9-1e2d-47ef-ae29-ad718b8dc939" width="250" alt="cart"/></td>
  </tr>
</table>

<br/>

<!-- Checkout -->
<h3>Checkout & Payment</h3>
<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/e0529ac4-0ed8-49ff-82f3-54447bd6dfd8" width="250" alt="checkout1"/></td>
    <td><img src="https://github.com/user-attachments/assets/b426e61f-bf7d-4c37-8e5a-eba6cb642d2e" width="250" alt="empty_save_address"/></td>
    <td><img src="https://github.com/user-attachments/assets/983cc77f-9092-4336-8b12-cd9743ef1f05" width="250" alt="select_address"/></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/027e5aaa-1d2c-41d7-bf3d-4d442dd30781" width="250" alt="address_saved"/></td>
    <td><img src="https://github.com/user-attachments/assets/c9e75cb4-3672-4eb1-ad9d-77b3599b8313" width="250" alt="saved_addresses_screen"/></td>
    <td><img src="https://github.com/user-attachments/assets/cf23834a-282d-4c7d-89d0-99f2ebd564ac" width="250" alt="payment2"/></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/abf3d6ed-44c9-4f2c-ab65-85cec04adb02" width="250" alt="payment3_processing"/></td>
    <td><img src="https://github.com/user-attachments/assets/5c845918-1c36-4b88-ba9f-162e90802c9d" width="250" alt="checkout2"/></td>
   <td><img src="https://github.com/user-attachments/assets/73a81efb-2c6f-4354-86b7-0934d2e881d8" width="250" alt="successfully"/></td>
  </tr>
</table>

<br/>

<!-- Profile & Settings -->
<h3>Profile & Settings</h3>
<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/4090ef44-c090-4894-8835-a686b34fa132" width="250" alt="done"/></td>
    <td><img src="https://github.com/user-attachments/assets/cb584c82-817b-4509-a312-1224e25c83e9" width="250" alt="edit_main_profile"/></td>
    <td><img src="https://github.com/user-attachments/assets/9aa7a3b9-974e-4b00-bdff-6446f0583514" width="250" alt="active_orders"/></td>
    <td><img src="https://github.com/user-attachments/assets/13b6acb0-47c7-468e-be7d-b63484110e11" width="250" alt="change_lang"/></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/0a0ac806-4912-4bb1-8f59-986c5b0032b8" width="250" alt="change_lang_ar"/></td>
    <td><img src="https://github.com/user-attachments/assets/35de52dd-fadf-4094-b04f-4059c934719e" width="250" alt="terms"/></td>
    <td><img src="https://github.com/user-attachments/assets/7d4d9b00-a7a0-412c-9edb-df9464566493" width="250" alt="logout_dialogue"/></td>
  </tr>
</table>

<br/>

<!-- Order Tracking -->
<h3>Order Tracking</h3>
<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/72905748-181f-4a98-8c91-d31ea839cab8" width="250" alt="tracking_1"/></td>
    <td><img src="https://github.com/user-attachments/assets/413d1155-ad8f-44c8-a7f6-a7651ade342a" width="250" alt="tracking_2"/></td>
    <td><img src="https://github.com/user-attachments/assets/32d09cdf-9cd8-438b-a896-863badc7cd21" width="250" alt="tracking_3"/></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/d15c701f-75df-447a-9dcc-2764e29f12db" width="250" alt="tracking_4"/></td>
    <td><img src="https://github.com/user-attachments/assets/92684354-0802-409e-8272-51097a1d4e2a" width="250" alt="tracking_5"/></td>
    <td><img src="https://github.com/user-attachments/assets/68fc273f-0681-479f-aa38-11c5f7f543c2" width="250" alt="tracking_6"/></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/c583ba87-b0ee-4855-b2ce-8b0c13f8ef15" width="250" alt="tracking_7"/></td>
    <td><img src="https://github.com/user-attachments/assets/61dd584a-b838-4188-85f5-81b1942152df" width="250" alt="tracking_8"/></td>
    <td><img src="https://github.com/user-attachments/assets/1b5b5041-cb84-4d6b-b17d-0ec3e92f95f4" width="250" alt="tracking_9"/></td>
  </tr>
</table>

</div>

---

## 👨‍💻 Contributors

- [Yahya Eltayeeb](https://github.com/YahyaEltayeeb)
- [Ahmed Rajeh](https://github.com/rajeh1032)
- [Mostafa Amer](https://github.com/MostafaAmer978)
- [Ahmed Yehia](https://github.com/ahmedyhia123)
- [Ahmed Fayed](https://github.com/AhmedFayed55)

---

### 👥 GitHub Avatars
<a href="https://github.com/YahyaEltayeeb"><img src="https://github.com/YahyaEltayeeb.png" width="60" /></a>
<a href="https://github.com/rajeh1032"><img src="https://github.com/rajeh1032.png" width="60" /></a>
<a href="https://github.com/MostafaAmer978"><img src="https://github.com/MostafaAmer978.png" width="60" /></a>
<a href="https://github.com/ahmedyhia123"><img src="https://github.com/ahmedyhia123.png" width="60" /></a>
<a href="https://github.com/AhmedFayed55"><img src="https://github.com/AhmedFayed55.png" width="60" /></a>


---

## License
Choose a license (MIT recommended)
