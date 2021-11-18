import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_manager_app/boxes.dart';
import 'package:product_manager_app/cubit/counter_cubit.dart';
import 'package:product_manager_app/data/models/product.dart';
import 'package:product_manager_app/presentation/pages/home.dart';
import 'package:product_manager_app/presentation/pages/single_product.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:product_manager_app/services/product_api.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  var box = await Hive.openBox<Product>(HiveBoxes.productList);
  if (box.length == 0) {
    box.addAll(await ProductsApi.getProductsDefault());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Home(),
    );
  }
}
