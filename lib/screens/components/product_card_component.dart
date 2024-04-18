import 'package:flutter/material.dart';

class ProductCardComponent extends StatelessWidget {
  final String productName;
  final String productPrice;
  final String productQuantity;

  const ProductCardComponent({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.productQuantity,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.liquor_outlined),
      title: Row(
        children: [
          Text("$productQuantity x"),
          Text(productName),
        ],
      ),
      trailing: Text(productPrice),
    );
  }
}
