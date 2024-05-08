import 'package:anydrawer/anydrawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_management/models/product.dart';
import 'package:store_management/screens/components/product_detail.dart';
import 'package:store_management/shared/theme/color_theme.dart';
import 'package:store_management/shared/theme/text_theme.dart';

import '../controllers/category_controller.dart';
import '../controllers/product_controller.dart';
import 'components/categories_tab_bar.dart';
import 'components/custom_button.dart';
import 'components/display_product.dart';
import 'components/modal_create_product.dart';
import 'components/product_category_card.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final productController = Get.put(ProductController());
  final categoryController = Get.put(CategoryController());

  final AnyDrawerController controller = AnyDrawerController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _showDrawer(ProductModel product) {
    showDrawer(
      context,
      builder: (context) {
        return Container(
          color: ColorTheme.background,
          child: DisplayProductDetail(
            product: product,
          ),
        );
      },
      config: const DrawerConfig(
        side: DrawerSide.right,
      ),
      onClose: () {},
      onOpen: () {},
      controller: controller,
    );
  }

  void showModalCreateProduct() {
    showDialog(
      context: context,
      builder: (context) {
        return const ModalCreateProduct();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorTheme.primary,
        foregroundColor: ColorTheme.white,
        title: Text(
          "Product Page",
          style: CustomTextTheme.titleBold,
        ),
        actions: [
          IconButton(
            onPressed: () {
              productController.getAllProducts();
            },
            icon: const Icon(Icons.autorenew_outlined),
          ),
        ],
      ),
      body: Obx(() {
        final productList = productController.productList;
        final categoryList = categoryController.categoryList;

        return SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Expanded(
                  child: CategoriesTabBarComponent(
                    categories:
                        categoryList.map((e) => e.name.toString()).toList(),
                    tabBarView: categoryList
                        .map((cat) => DiaplyProductListComponent(
                              children: productList
                                  .where((item) {
                                    if (cat.key == "all") {
                                      return item.category == item.category;
                                    } else {
                                      return item.category == cat.key;
                                    }
                                  })
                                  .map(
                                      (product) => ProductCategoryCardComponent(
                                            product: product,
                                            onTap: () {
                                              _showDrawer(product);
                                            },
                                          ))
                                  .toList(),
                            ))
                        .toList(),
                    titleActions: [
                      CustomButton(
                        buttonName: "เพิ่มสินค้า",
                        icon: Icons.add,
                        onPressed: () {
                          showModalCreateProduct();
                        },
                      ),
                    ],
                    tabActions: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit, color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
