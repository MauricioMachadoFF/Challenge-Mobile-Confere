import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:product_manager_app/bloc/product_list/bloc.dart';
import 'package:product_manager_app/bloc/product_list/product_list_event.dart';
import 'package:product_manager_app/boxes.dart';
import 'package:product_manager_app/data/models/product.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  Box<Product> productBox;
  ProductListBloc() : super(ProductListState()) {
    productBox = Hive.box<Product>(HiveBoxes.productList);
    Hive.box<Product>(HiveBoxes.productList).listenable().addListener(() {
      add(ProductListLoad());
    });
  }

  @override
  mapEventToState(ProductListEvent event) async* {
    if (event is ProductListLoad) {
      yield state.copyWith(productsList: productBox.values.toList());
    }
    if (event is ProductListDeleteItem) {
      productBox.get(event.id).delete();
    }
  }
}
