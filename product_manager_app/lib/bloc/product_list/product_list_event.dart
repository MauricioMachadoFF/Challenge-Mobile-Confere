import 'package:equatable/equatable.dart';

class ProductListEvent extends Equatable {
  const ProductListEvent();

  @override
  List<Object> get props => [];
}

class ProductListLoad extends ProductListEvent {}

class ProductListDeleteItem extends ProductListEvent {
  final int id;
  ProductListDeleteItem({
    this.id,
  });
}

class ProductListFilter extends ProductListEvent {
  final String query;
  ProductListFilter({
    this.query,
  });
}
