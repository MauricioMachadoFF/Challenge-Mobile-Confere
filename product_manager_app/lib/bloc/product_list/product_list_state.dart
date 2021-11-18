import 'package:product_manager_app/data/models/product.dart';

class ProductListState {
  final List<Product> productsList;
  ProductListState({
    this.productsList,
  });

  ProductListState copyWith({
    List<Product> productsList,
  }) {
    return ProductListState(
      productsList: productsList ?? this.productsList,
    );
  }
}
