import 'package:flutter/material.dart';

import '../../shared/components/color_theme.dart';
import '../../shared/components/text_theme.dart';

class ProductCategoryCardComponent extends StatefulWidget {
  final String productName;
  final VoidCallback? onTap;
  // final String productPrice;
  // final String productQuantity;

  const ProductCategoryCardComponent({
    super.key,
    required this.productName,
    this.onTap,
    // required this.productPrice,
    // required this.productQuantity,
  });

  @override
  State<ProductCategoryCardComponent> createState() =>
      _ProductCategoryCardComponentState();
}

class _ProductCategoryCardComponentState
    extends State<ProductCategoryCardComponent> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onLongPress: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return modalBuyProduct();
          },
        );
      },
      child: Card(
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: FittedBox(
                child: Text(
                  widget.productName,
                  style: CustomTextTheme.bodyMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget modalBuyProduct() {
    return AlertDialog(
      title: const Text("Alert Dialog"),
      content: const Text("Dialog Content"),
      actions: [
        TextButton(
          child: const Text("Close"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
