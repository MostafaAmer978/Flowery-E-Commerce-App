import 'package:equatable/equatable.dart';
import 'package:flowers_ecommerce_app/features/home_screen/domain/entities/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'product_response_dto.g.dart';

@JsonSerializable()
class ProductResponseDto extends Equatable {
  final int? rateAvg;
  final int? rateCount;
  @JsonKey(name: '_id')
  final String? idMongo;
  final String? id;
  final String? title;
  final String? slug;
  final String? description;
  final String? imgCover;
  final List<String> images;
  final int? price;
  final int? priceAfterDiscount;
  final int? quantity;
  final String? category;
  final String? occasion;
  final String? createdAt;
  final String? updatedAt;
  final int? sold;
  final bool? isSuperAdmin;
  const ProductResponseDto({
    this.rateAvg,
    this.rateCount,
    this.idMongo,
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images = const [],
    this.price,
    this.priceAfterDiscount,
    this.quantity,
    this.category,
    this.occasion,
    this.createdAt,
    this.updatedAt,
    this.sold,
    this.isSuperAdmin,
  });

  factory ProductResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseDtoToJson(this);

  ProductEntity toDomain() {
    return ProductEntity(
      id ?? '',
      title ?? '',
      description ?? '',
      imgCover ?? '',
      images,
      price ?? 0,
      priceAfterDiscount ?? 0,
      quantity ?? 0,
      sold ?? 0,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    imgCover,
    images,
    price,
    priceAfterDiscount,
    quantity,
    sold,
  ];
}
