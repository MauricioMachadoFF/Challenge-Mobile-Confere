import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:product_manager_app/boxes.dart';
import 'package:product_manager_app/data/models/product.dart';
import 'package:hive/hive.dart';

class SingleProduct extends StatefulWidget {
  const SingleProduct({Key key}) : super(key: key);

  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  final formKey = GlobalKey<FormState>();
  // final price = GlobalKey<FormFieldState>();

  validated() {
    if (formKey.currentState != null && formKey.currentState.validate()) {
      _onFormSubmit();
      print('Validated');
    } else {
      print('Form not validated');
    }
  }

  String name;
  String price;
  String discountPrice;

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
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Enter a valid name";
                    } else {
                      name = value;
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Price",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Enter a valid value";
                    } else {
                      price = value;
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Discounted Price",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.numberWithOptions(),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Enter a valid value";
                    } else {
                      discountPrice = value;
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextButton(
                  onPressed: () {
                    validated();
                  },
                  style: TextButton.styleFrom(backgroundColor: Colors.blue),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Salvar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onFormSubmit() {
    Box<Product> productBox = Hive.box<Product>(HiveBoxes.productList);
    productBox.add(Product(
      name: name,
      price: price,
      discountPrice: discountPrice,
    ));
    Navigator.of(context).pop();
    print(productBox);
  }
}
