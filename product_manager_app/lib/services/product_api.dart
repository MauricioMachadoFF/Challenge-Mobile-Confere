import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:product_manager_app/data/models/product.dart';
import 'package:flutter/services.dart' show rootBundle;

class ProductsApi {
  static Future<List<Product>> getProductsDefault() async {
    final data = await rootBundle.loadString('assets/data/db.json');
    final body = json.decode(data) as List<dynamic>;

    final result = body.map<Product>((e) => Product.fromJson(e)).toList();
    return result;
  }
}
