import 'package:flutter/material.dart';

import '../../models/product.dart';
import '../../shared/theme/color_theme.dart';
import '../../shared/theme/text_theme.dart';

class ProductCategoryCardComponent extends StatefulWidget {
  final ProductModel product;
  final VoidCallback? onTap;
  // final String productPrice;
  // final String productQuantity;

  const ProductCategoryCardComponent({
    super.key,
    required this.product,
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
      borderRadius: BorderRadius.circular(10),
      child: Card(
        color: ColorTheme.background,
        elevation: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                ),
                child: const Icon(
                  Icons.local_drink_outlined,
                  size: 40,
                  color: ColorTheme.primary,
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: ColorTheme.white,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.product.name,
                      style: CustomTextTheme.bodyMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: FittedBox(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "฿ ${widget.product.price.toStringAsFixed(2)} บาท",
                        style: CustomTextTheme.smallBody,
                      ),
                    ),
                  ),
                ],
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
