import 'package:flutter/material.dart';
import 'package:store_management/screens/components/product_category_card.dart';

class DiaplyProductListComponent extends StatelessWidget {
  final List<String> products;

  const DiaplyProductListComponent({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: CustomScrollView(
        slivers: [
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            delegate: SliverChildListDelegate(
              products
                  .map((e) => ProductCategoryCardComponent(productName: e))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
