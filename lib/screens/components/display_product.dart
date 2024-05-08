import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_management/controllers/product_controller.dart';

class DiaplyProductListComponent extends GetView<ProductController> {
  final List<Widget> children;

  const DiaplyProductListComponent({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: controller.obx(
        (state) => CustomScrollView(
          slivers: [
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 190,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              delegate: SliverChildListDelegate(
                children,
              ),
            ),
          ],
        ),
        onLoading: Container(
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
