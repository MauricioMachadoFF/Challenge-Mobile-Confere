// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    this.name,
    this.style,
    this.codeColor,
    this.colorSlug,
    this.color,
    this.onSale,
    this.regularPrice,
    this.actualPrice,
    this.discountPercentage,
    this.installments,
    this.image,
    this.sizes,
  });

  String name;
  String style;
  String codeColor;
  String colorSlug;
  String color;
  bool onSale;
  String regularPrice;
  String actualPrice;
  String discountPercentage;
  String installments;
  String image;
  List<Size> sizes;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json["name"],
        style: json["style"],
        codeColor: json["code_color"],
        colorSlug: json["color_slug"],
        color: json["color"],
        onSale: json["on_sale"],
        regularPrice: json["regular_price"],
        actualPrice: json["actual_price"],
        discountPercentage: json["discount_percentage"],
        installments: json["installments"],
        image: json["image"],
        sizes: List<Size>.from(json["sizes"].map((x) => Size.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "style": style,
        "code_color": codeColor,
        "color_slug": colorSlug,
        "color": color,
        "on_sale": onSale,
        "regular_price": regularPrice,
        "actual_price": actualPrice,
        "discount_percentage": discountPercentage,
        "installments": installments,
        "image": image,
        "sizes": List<dynamic>.from(sizes.map((x) => x.toJson())),
      };
}

class Size {
  Size({
    this.available,
    this.size,
    this.sku,
  });

  bool available;
  String size;
  String sku;

  factory Size.fromJson(Map<String, dynamic> json) => Size(
        available: json["available"],
        size: json["size"],
        sku: json["sku"],
      );

  Map<String, dynamic> toJson() => {
        "available": available,
        "size": size,
        "sku": sku,
      };
}
