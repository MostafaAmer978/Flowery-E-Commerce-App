import 'package:flowers_ecommerce_app/core/constants/constants.dart';
import 'package:flowers_ecommerce_app/core/services/firebase_services.dart';
import 'package:flowers_ecommerce_app/features/map/data/model/response_dto.dart';
import 'package:flowers_ecommerce_app/features/map/data/sources/tracking_ds.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

@Injectable(as: TrackingDataSource)
class TrackingDataSourceImp implements TrackingDataSource {
  final FirebaseService _firebaseService;

  TrackingDataSourceImp(this._firebaseService);
  @override
  Future<ResponseDto> getData(String orderId) async {
    final snapshot = await _firebaseService.getData(
      Constants.collectionKey,
      orderId,
    );
    final data = snapshot.data() as Map<String, dynamic>;
    return ResponseDto.fromJson(data);
  }

  @override
  Stream<String> streamDriverLocation(String orderId) async* {
    yield* _firebaseService.streamData(Constants.collectionKey, orderId).map((
      snapshot,
    ) {
      final data = snapshot.data() as Map<String, dynamic>?;
      final loc = data![Constants.driverLocationKey];

      return loc;
    });
  }

  @override
  Future<void> callDriver(String phoneNumber) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    if (!await launchUrl(url)) {
      throw Exception();
    }
  }

  @override
  Future<void> openWatsApp(String phoneNumber) async {
    final Uri uri = Uri.parse('${Constants.urlwatsApp}$phoneNumber');
    if (!await launchUrl(uri)) throw Exception();
  }
}
