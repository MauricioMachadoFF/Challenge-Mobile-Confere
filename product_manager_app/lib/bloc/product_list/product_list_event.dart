import 'package:equatable/equatable.dart';

class ProductListEvent extends Equatable {
  const ProductListEvent();

  @override
  List<Object> get props => [];
}

class ProductListLoad extends ProductListEvent {}
