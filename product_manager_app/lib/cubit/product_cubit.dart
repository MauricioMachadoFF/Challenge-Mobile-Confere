import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductState(productIndex: 0));

  void getIndex() => emit(ProductState(productIndex: state.productIndex));
  void increment() => emit(ProductState(productIndex: state.productIndex + 1));
  void decrement() => emit(ProductState(productIndex: state.productIndex - 1));
}
