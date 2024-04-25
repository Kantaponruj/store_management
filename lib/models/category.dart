import 'package:flutter/material.dart';

class ProductCategory {
  final String id;
  final String key;
  final String name;
  final String? description;
  final IconData? icon;
  final String? image;

  ProductCategory({
    required this.id,
    required this.key,
    required this.name,
    this.description,
    this.icon,
    this.image,
  });
}
