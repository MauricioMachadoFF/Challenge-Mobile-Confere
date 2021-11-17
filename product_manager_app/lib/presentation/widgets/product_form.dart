import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:product_manager_app/data/models/product.dart';
import 'package:product_manager_app/boxes.dart';

class ProductForm extends StatefulWidget {
  const ProductForm({Key key}) : super(key: key);

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final formKey = GlobalKey<FormState>();
  String name;
  String price;
  String discountPrice;

  validated() {
    if (formKey.currentState != null && formKey.currentState.validate()) {
      _onFormSubmit();
      print('Validated');
    } else {
      print('Form not validated');
    }
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

  @override
  Widget build(BuildContext context) {
    return Form(
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
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
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
    );
  }
}
