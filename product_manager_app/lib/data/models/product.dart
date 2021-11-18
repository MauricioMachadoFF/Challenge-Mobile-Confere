import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'dart:convert';

part 'product.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String price;
  @HiveField(2)
  String discountPrice;
  @HiveField(3)
  String image;

  Product({
    @required this.name,
    @required this.price,
    @required this.discountPrice,
    this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json["name"],
        price: json["regular_price"].toString().substring(3),
        discountPrice: json["actual_price"].toString().substring(3),
        image: json["image"],
      );

  @override
  String toString() {
    return '$name com preço $price com image $image';
  }
}

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));
