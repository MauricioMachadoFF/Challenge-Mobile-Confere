import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:product_manager_app/bloc/product_list/bloc.dart';
import 'package:product_manager_app/data/models/product.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:product_manager_app/boxes.dart';
import 'package:product_manager_app/presentation/pages/edit_product_screen.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key key}) : super(key: key);
  static String defaultImageUrl =
      'https://cdn-icons-png.flaticon.com/512/2867/2867158.png';

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  ProductListBloc productListBloc;

  @override
  void initState() {
    productListBloc = ProductListBloc();
    productListBloc.add(ProductListLoad());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductListBloc, ProductListState>(
      bloc: productListBloc,
      builder: (context, state) {
        if ((state.productsList ?? []).isEmpty) {
          return Center(
            child: Text('No products registeres'),
          );
        }

        return ListView.builder(
          itemCount: state.productsList.length,
          itemBuilder: (context, index) {
            state.productsList.sort((item1, item2) =>
                item1.name.toLowerCase().compareTo(item2.name.toLowerCase()));
            Product res = state.productsList[index];

            return Dismissible(
              background: Container(
                color: Colors.red[600],
              ),
              key: UniqueKey(),
              onDismissed: (direction) {
                productListBloc.add(ProductListDeleteItem(id: res.key));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(res.image ?? ProductList.defaultImageUrl),
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
                  trailing: Container(
                    width: 90.0,
                    child: Row(
                      children: [
                        Ink(
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
                        SizedBox(
                          width: 10.0,
                        ),
                        Ink(
                          width: 40,
                          decoration: ShapeDecoration(
                            shape: CircleBorder(),
                            color: Colors.red,
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              showDialog(
                                barrierDismissible: true,
                                context: context,
                                builder: (_) => AlertDialog(
                                  title:
                                      const Text('You really want to delete:'),
                                  content: Text(
                                    res.name,
                                    textAlign: TextAlign.center,
                                  ),
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(
                                              context,
                                              rootNavigator: true,
                                            ).pop();
                                          },
                                          child: Text(
                                            'No',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          style: TextButton.styleFrom(
                                            backgroundColor: Colors.orange[600],
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            productListBloc.add(
                                              ProductListDeleteItem(
                                                  id: res.key),
                                            );
                                            Navigator.of(
                                              context,
                                              rootNavigator: true,
                                            ).pop();
                                          },
                                          child: Text(
                                            'Yes',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          style: TextButton.styleFrom(
                                            backgroundColor: Colors.deepPurple,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
