import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductCategory {
  final String id;
  final String key;
  final String name;
  final String? description;
  final IconData? icon;
  final String? image;
  final String? color;

  ProductCategory({
    required this.id,
    required this.key,
    required this.name,
    this.description,
    this.icon,
    this.image,
    this.color,
  });

  factory ProductCategory.fromDocumentSnapshot(
      {required DocumentSnapshot documentSnapshot}) {
    return ProductCategory(
      id: documentSnapshot.id,
      key: documentSnapshot['key'],
      name: documentSnapshot['name'],
      description: documentSnapshot['description'],
      icon: documentSnapshot['icon'],
      image: documentSnapshot['image'],
      color: documentSnapshot['color'],
    );
  }

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json['id'],
      key: json['key'],
      name: json['name'],
      description: json['description'],
      icon: json['icon'],
      image: json['image'],
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['key'] = key;
    data['name'] = name;
    data['description'] = description;
    data['icon'] = icon;
    data['image'] = image;
    data['color'] = color;

    return data;
  }
}
