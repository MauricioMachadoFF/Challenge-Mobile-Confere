import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:product_manager_app/bloc/product_form/bloc.dart';
import 'package:product_manager_app/boxes.dart';
import 'package:product_manager_app/data/models/product.dart';
import 'package:hive/hive.dart';
import 'package:product_manager_app/presentation/widgets/product_form.dart';

class SingleProduct extends StatefulWidget {
  const SingleProduct({Key key}) : super(key: key);

  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  ProductFormBloc productFormBloc;

  @override
  void initState() {
    productFormBloc = ProductFormBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return KeyboardDismisser(
      gestures: [
        GestureType.onTap,
        GestureType.onVerticalDragDown,
      ],
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Add Product'),
        ),
        body: ProductForm(
          onSave: (value) {
            productFormBloc.add(ProductFormSave(
              name: value['name'],
              price: value['price'],
              discountPrice: value['discountPrice'],
            ));
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
