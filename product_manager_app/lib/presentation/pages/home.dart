import 'package:flutter/material.dart';
import 'package:product_manager_app/data/models/product.dart';
import 'package:product_manager_app/services/product_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // List<Product> list = List<Product>.empty(growable: true);
  // SharedPreferences sharedPreferences;

  // @override
  // void initState() {
  //   initSharedPreferences();
  //   super.initState();
  // }
  @override
  void initState() {
    Future<List> products = ProductsApi.getProductsDefault(context);
    super.initState();
  }

  // initSharedPreferences() async{
  //   if (sharedPreferences == null) {

  //   } else {
  //     sharedPreferences = await SharedPreferences.getInstance();
  //   }
  // }
  Widget buildProducts(List<Product> products) => ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          return ListTile(
            title: Text(product.name),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Product>>(
        future: ProductsApi.getProductsDefault(context),
        builder: (context, snapshot) {
          final products = snapshot.data;
          print(snapshot.data);

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text('some error'),
                );
              } else {
                return buildProducts(products);
              }
          }
        },
      ),
    );
  }
}
