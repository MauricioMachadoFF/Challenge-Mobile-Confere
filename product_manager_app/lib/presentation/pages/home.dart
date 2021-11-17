import 'package:flutter/material.dart';
import 'package:product_manager_app/boxes.dart';
import 'package:product_manager_app/data/models/product.dart';
import 'package:product_manager_app/presentation/pages/single_product.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Product>(HiveBoxes.productList).listenable(),
        builder: (context, Box<Product> box, widget) {
          if (box.values.isEmpty) {
            return Center(
              child: Text('No products registered'),
            );
          } else {
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
                    res.delete();
                  },
                  child: ListTile(
                    title: Text(res.name),
                    subtitle: Text(res.price),
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
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => EditProduct()),
                          // );
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
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
