import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  late String uuid;
  late String category;
  late String id;
  late String name;
  late String? description;
  late double price;
  late int quantity;
  late String? image;

  ProductModel({
    this.uuid = "",
    required this.category,
    required this.id,
    required this.name,
    this.description,
    required this.price,
    required this.quantity,
    this.image,
  });

  ProductModel.fromDocumentSnapshot(
      {required DocumentSnapshot documentSnapshot}) {
    uuid = documentSnapshot.id;
    category = documentSnapshot["category"];
    id = documentSnapshot["id"];
    name = documentSnapshot["name"];
    description = documentSnapshot["description"];
    price = double.parse(documentSnapshot["price"].toString());
    quantity = int.parse(documentSnapshot["quantity"].toString());
    image = documentSnapshot["image"];
  }

  ProductModel.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    category = json['category'];
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    quantity = json['quantity'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['category'] = category;
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['quantity'] = quantity;
    data['image'] = image;

    return data;
  }
}
