import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:product_manager_app/data/models/product.dart';

class ProductsApi {
  static Future<List<Product>> getProductsDefault(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final data = await assetBundle.loadString('assets/data/db.json');
    final body = json.decode(data) as List<dynamic>;

    final result = body.map<Product>((e) => Product.fromJson(e)).toList();
    return result;
  }
}
