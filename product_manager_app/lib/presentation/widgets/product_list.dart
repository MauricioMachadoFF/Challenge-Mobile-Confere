import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:product_manager_app/data/models/product.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:product_manager_app/boxes.dart';
import 'package:product_manager_app/presentation/pages/edit_product_screen.dart';

class ProductList extends StatelessWidget {
  const ProductList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<Product>(HiveBoxes.productList).listenable(),
      builder: (context, Box<Product> box, widget) {
        if (box.values.isEmpty) {
          return Center(
            child: Text('No products registered'),
          );
        } else {
          print('Produto adicionado');
          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              Product res = box.getAt(index);

              print(res.key);
              return Dismissible(
                background: Container(
                  color: Colors.red[600],
                ),
                key: UniqueKey(),
                onDismissed: (direction) {
                  // box.put(
                  // '',
                  // Product(
                  //   name: 'jgjg',
                  //   price: '21',
                  //   discountPrice: '222',
                  // ),
                  // );
                  res.delete();
                },
                child: ListTile(
                  title: Text(res.name ?? ''),
                  subtitle: Text(res.price ?? ''),
                  trailing: Ink(
                    decoration: ShapeDecoration(
                      shape: CircleBorder(),
                      color: Colors.orange,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditProductScreen(id: res.key),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
