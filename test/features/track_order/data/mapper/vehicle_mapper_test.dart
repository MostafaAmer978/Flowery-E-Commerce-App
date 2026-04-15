import 'package:flowers_ecommerce_app/features/track_order/data/mapper/vehicle_mapper.dart';
import 'package:flowers_ecommerce_app/features/track_order/data/model/response/vehicle_response_dto.dart';
import 'package:flowers_ecommerce_app/features/track_order/data/model/vehicle_dto.dart';
import 'package:flowers_ecommerce_app/features/track_order/domain/entities/vehicle_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'toEntity should map VehicleResponseDto to VehicleEntity with image',
    () {
      final dto = VehicleResponseDto(
        message: 'ok',
        vehicle: VehicleDto(
          id: null,
          type: null,
          image: 'img.png',
          createdAt: null,
          updatedAt: null,
          version: null,
        ),
      );

      final result = dto.toEntity();

      expect(result, isA<VehicleEntity>());
      expect(result.image, 'img.png');
    },
  );

  test(
    'toEntity should default to empty image when vehicle or image is null',
    () {
      final nullVehicleDto = VehicleResponseDto(message: null, vehicle: null);
      final result1 = nullVehicleDto.toEntity();
      expect(result1.image, '');

      final nullImageDto = VehicleResponseDto(
        message: null,
        vehicle: VehicleDto(
          id: null,
          type: null,
          image: null,
          createdAt: null,
          updatedAt: null,
          version: null,
        ),
      );
      final result2 = nullImageDto.toEntity();
      expect(result2.image, '');
    },
  );
}
