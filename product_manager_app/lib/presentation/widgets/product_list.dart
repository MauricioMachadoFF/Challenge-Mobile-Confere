import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:product_manager_app/data/models/product.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:product_manager_app/boxes.dart';
import 'package:product_manager_app/presentation/pages/edit_product_screen.dart';

class ProductList extends StatelessWidget {
  const ProductList({Key key}) : super(key: key);
  static String defaultImageUrl =
      'https://lh3.googleusercontent.com/proxy/PjGmsW9bnk98iQ8oamk9zJwEVUmf5sB115ZcAVwaTxLxFhxZBs9sBOApPNPWk5d1yQi0Lggj0ccZH3ezDaPwZbm--zVPLvXLvd3FpPCmXR2s-EYIc9p75vpb-axz0KBt-xqBo89uae_f4qMbVBsrWzJYrNQ';

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

              return Dismissible(
                background: Container(
                  color: Colors.red[600],
                ),
                key: UniqueKey(),
                onDismissed: (direction) {
                  print(box.getAt(index).toString());
                  res.delete();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(res.image ?? defaultImageUrl),
                    ),
                    title: Text(
                      res.name ?? '',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Preço original: R\$ ${res.price}' ?? '',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          'Preço com desconto: R\$ ${res.discountPrice}' ?? '',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                    trailing: Ink(
                      width: 40,
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
                ),
              );
            },
          );
        }
      },
    );
  }
}
