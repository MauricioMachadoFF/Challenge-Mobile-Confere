import 'package:product_manager_app/data/models/product.dart';

class ProductFormState {
  final int id;
  final String name;
  final String price;
  final String discountPrice;
  final String imageUrl;

  ProductFormState({
    this.id,
    this.name,
    this.price,
    this.discountPrice,
    this.imageUrl,
  });

  ProductFormState copyWith({
    int id,
    String name,
    String price,
    String discountPrice,
    String imageUrl,
  }) {
    return ProductFormState(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      discountPrice: discountPrice ?? this.discountPrice,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
