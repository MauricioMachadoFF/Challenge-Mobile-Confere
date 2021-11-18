import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:product_manager_app/bloc/product_form/product_form_bloc.dart';
import 'package:product_manager_app/bloc/product_form/product_form_bloc.dart';
import 'package:product_manager_app/data/models/product.dart';
import 'package:product_manager_app/boxes.dart';

class ProductForm extends StatefulWidget {
  final String name;
  final String price;
  final String discountPrice;
  final Function onSave;
  const ProductForm({
    Key key,
    this.name,
    this.price,
    this.discountPrice,
    this.onSave,
  }) : super(key: key);

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final formKey = GlobalKey<FormState>();

  TextEditingController nameController;
  TextEditingController priceController;
  TextEditingController discountPriceController;

  @override
  void initState() {
    print('init state form');
    nameController = TextEditingController(text: widget.name);
    priceController = TextEditingController(text: widget.price);
    discountPriceController = TextEditingController(text: widget.discountPrice);
    super.initState();
  }

  validated() {
    if (formKey.currentState != null && formKey.currentState.validate()) {
      _onFormSubmit();
      print('Validated');
    } else {
      print('Form not validated');
    }
  }

  void _onFormSubmit() {
    widget.onSave({
      "name": nameController.text,
      "price": priceController.text,
      "discountPrice": discountPriceController.text,
    });
    // if (widget.product != null) {
    //   widget.product.name = nameController.text;
    //   widget.product.price = priceController.text;
    //   widget.product.discountPrice = discountPriceController.text;

    //   widget.product.save();
    // } else {
    //   Box<Product> productBox = Hive.box<Product>(HiveBoxes.productList);
    //   productBox.add(Product(
    //     name: nameController.text,
    //     price: priceController.text,
    //     discountPrice: discountPriceController.text,
    //   ));
    // }
  }

  @override
  Widget build(BuildContext context) {
    print('build from');
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return "Enter a valid name";
                }
                return null;
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              controller: priceController,
              decoration: const InputDecoration(
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
                }
                return null;
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              controller: discountPriceController,
              decoration: InputDecoration(
                labelText: "Discounted Price",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              validator: (value) {
                if (value.isEmpty) {
                  return "Enter a valid value";
                }
                return null;
              },
            ),
            SizedBox(
              height: 30.0,
            ),
            TextButton(
              onPressed: () {
                validated();
              },
              style: TextButton.styleFrom(backgroundColor: Colors.deepPurple),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Save',
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
