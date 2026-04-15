import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowers_ecommerce_app/core/constants/constants.dart';
import 'package:flowers_ecommerce_app/core/services/firebase_services.dart';
import 'package:flowers_ecommerce_app/features/map/data/model/response_dto.dart';
import 'package:flowers_ecommerce_app/features/map/data/sources/tracking_ds_imp.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tracking_ds_imp_test.mocks.dart';

@GenerateMocks([FirebaseService, DocumentSnapshot])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('TrackingDataSourceImp', () {
    final mockfirebaseService = MockFirebaseService();
    final fakeJson = {'driverLocation': '30.0444,31.2357'};

    final MockDocumentSnapshot mockDocumentSnapshot = MockDocumentSnapshot();
    final mockdatasource = TrackingDataSourceImp(mockfirebaseService);
    const expectedLocation = '30.0444,31.2357';

    test(
      'verify when call trackOrder it should call trackOrder from firebaseServices',
      () async {
        when(
          mockfirebaseService.getData(any, any),
        ).thenAnswer((_) async => mockDocumentSnapshot);
        when(mockDocumentSnapshot.data()).thenReturn(fakeJson);

        var result = await mockdatasource.getData('');
        expect(result, isA<ResponseDto>());
      },
    );
    test(
      'when call trackOrder it should call trackOrder from firebaseServices',
      () async {
        when(
          mockDocumentSnapshot.data(),
        ).thenReturn({Constants.driverLocationKey: expectedLocation});
        when(
          mockfirebaseService.streamData('orders', ''),
        ).thenAnswer((_) => Stream.value(mockDocumentSnapshot));
        final result = mockdatasource.streamDriverLocation('');
        await expectLater(result, emits(expectedLocation));
      },
    );
  });
}
