import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:product_manager_app/bloc/product_form/bloc.dart';
import 'package:product_manager_app/boxes.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:product_manager_app/data/models/product.dart';

class ProductFormBloc extends Bloc<ProductFormEvent, ProductFormState> {
  Box<Product> productBox;
  ProductFormBloc() : super(ProductFormState()) {
    productBox = Hive.box<Product>(HiveBoxes.productList);
  }

  @override
  mapEventToState(ProductFormEvent event) async* {
    if (event is ProductFormLoad) {
      if (event.id != null) {
        Product product = productBox.get(event.id);
        yield state.copyWith(
          id: product.key,
          name: product.name,
          price: product.price,
          discountPrice: product.discountPrice,
        );
      }
    }
    if (event is ProductFormSave) {
      if (state.id != null) {
        Product product = productBox.get(state.id);
        product.name = event.name;
        product.price = event.price;
        product.discountPrice = event.discountPrice;
        product.save();
      } else {
        Product newProduct = Product(
          name: event.name,
          price: event.price,
          discountPrice: event.discountPrice,
        );

        productBox.add(newProduct);
      }
    }
  }
}
