import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:product_manager_app/bloc/product_form/bloc.dart';
import 'package:product_manager_app/boxes.dart';
import 'package:product_manager_app/data/models/product.dart';
import 'package:product_manager_app/presentation/widgets/product_form.dart';

class EditProductScreen extends StatefulWidget {
  final int id;
  const EditProductScreen({Key key, this.id}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  Product result;
  ProductFormBloc productFormBloc;

  @override
  void initState() {
    print(widget.id);
    productFormBloc = ProductFormBloc();
    productFormBloc.add(ProductFormLoad(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: BlocBuilder<ProductFormBloc, ProductFormState>(
        bloc: productFormBloc,
        builder: (context, state) {
          if (state.id == null) {
            return Text('Carregando');
            //TRocar por loading spinner
          }
          return Column(
            children: [
              ProductForm(
                  name: state.name,
                  price: state.price,
                  discountPrice: state.discountPrice,
                  onSave: (value) {
                    productFormBloc.add(ProductFormSave(
                      name: value['name'],
                      price: value['price'],
                      discountPrice: value['discountPrice'],
                    ));
                    Navigator.of(context).pop();
                  }),
            ],
          );
        },
      ),
    );
  }
}
