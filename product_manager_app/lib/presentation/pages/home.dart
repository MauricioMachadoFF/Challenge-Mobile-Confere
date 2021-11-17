import 'package:flutter/material.dart';
import 'package:product_manager_app/boxes.dart';
import 'package:product_manager_app/data/models/product.dart';
import 'package:product_manager_app/presentation/pages/single_product.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:product_manager_app/presentation/widgets/product_list.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
  // @override
  // void initState() {
  //   Future<List> products = ProductsApi.getProductsDefault(context);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Manager'),
      ),
      body: ProductList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SingleProduct(),
            ),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Add product',
      ),
    );
  }
}
