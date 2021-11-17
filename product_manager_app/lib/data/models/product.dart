import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'product.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String price;
  @HiveField(2)
  String discountPrice;
  Product({
    @required this.name,
    @required this.price,
    @required this.discountPrice,
  });
}
