import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:store_management/constants/constant.dart';
import 'package:store_management/controllers/product_controller.dart';
import 'package:store_management/shared/theme/color_theme.dart';
import 'package:store_management/shared/theme/text_theme.dart';

class DiaplyProductListComponent extends GetView<ProductController> {
  final List<Widget> children;

  const DiaplyProductListComponent({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final double size = context.isPhone ? 100 : 160;
    final double spacing = isPhone ? 5 : 10;

    return Container(
      padding: const EdgeInsets.all(20),
      child: controller.obx(
        (state) => CustomScrollView(
          slivers: [
            SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: size,
                mainAxisSpacing: spacing,
                crossAxisSpacing: spacing,
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
        onEmpty: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/images/svg/empty.svg",
              width: 120,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text("ไม่พบสินค้า",
                  style: CustomTextTheme.subtitleBold.copyWith(
                    color: ColorTheme.primary,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
