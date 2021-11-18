import 'package:equatable/equatable.dart';

import 'package:product_manager_app/data/models/product.dart';

class ProductFormEvent {
  ProductFormEvent([List props = const []]);
}

class ProductFormLoad extends ProductFormEvent {
  final int id;
  ProductFormLoad(this.id);
}

class ProductFormSave extends ProductFormEvent {
  final String name;
  final String price;
  final String discountPrice;
  final String imageUrl;
  ProductFormSave({
    this.name,
    this.price,
    this.discountPrice,
    this.imageUrl,
  });
}
