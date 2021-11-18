import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
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

  @override
  void initState() {
    print(widget.id);
    result = Hive.box<Product>(HiveBoxes.productList).get(widget.id);
    print(result);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Column(
        children: [
          ProductForm(product: result),
        ],
      ),
    );
  }
}
