import 'package:flutter/material.dart';

import '../../shared/components/color_theme.dart';
import '../../shared/components/text_theme.dart';

class ProductCategoryCardComponent extends StatelessWidget {
  final String productName;
  // final String productPrice;
  // final String productQuantity;

  const ProductCategoryCardComponent({
    super.key,
    required this.productName,
    // required this.productPrice,
    // required this.productQuantity,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorTheme.white,
      elevation: 1,
      surfaceTintColor: ColorTheme.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              color: ColorTheme.background,
            ),
            height: 80,
            child: const Icon(
              Icons.local_drink_outlined,
              size: 40,
              color: ColorTheme.primary,
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              productName,
              style: CustomTextTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
