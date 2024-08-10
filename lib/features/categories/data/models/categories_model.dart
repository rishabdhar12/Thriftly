import 'dart:convert';

import 'package:budgeting_app/features/categories/domain/entities/products_entity.dart';

List<CategoriesModel> categoriesModelFromJson(String str) =>
    List<CategoriesModel>.from(
        json.decode(str).map((x) => CategoriesModel.fromJson(x)));

String categoriesModelToJson(List<CategoriesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoriesModel extends CategoriesEntity {
  const CategoriesModel({
    required super.categoryName,
    required super.items,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        categoryName: json["categoryName"],
        items: List<String>.from(json["items"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "categoryName": categoryName,
        "items": List<dynamic>.from(items.map((x) => x)),
      };
}
