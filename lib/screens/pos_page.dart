import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_management/controllers/product_controller.dart';
import 'package:store_management/controllers/transaction_controller.dart';
import 'package:store_management/models/transaction.dart';
import 'package:store_management/screens/components/categories_tab_bar.dart';
import 'package:store_management/shared/theme/color_theme.dart';
import 'package:store_management/shared/theme/text_theme.dart';

import '../controllers/category_controller.dart';
import '../models/product.dart';
import 'components/display_product.dart';
import 'components/product_category_card.dart';

class POSPage extends StatefulWidget {
  const POSPage({super.key});

  @override
  State<POSPage> createState() => _POSPageState();
}

class _POSPageState extends State<POSPage> {
  // String? _barcode;
  bool visible = true;
  Transaction? transaction;

  final productController = Get.put(ProductController());
  final transactionController = Get.put(TransactionController());
  final categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    void onTapAddProduct(ProductModel product) {
      TransactionProduct item = TransactionProduct(
        id: product.id,
        name: product.name,
        price: product.price,
        amount: 1,
        totalPrice: product.price,
      );

      transactionController.addTransactionProduct(item);

      // transaction = Transaction(
      //   id: "${products.length}_${DateTime.now()}",
      //   amount: transactionController.tranTotalCount,
      //   totalPrice: transactionController.tranTotalPrice,
      //   date: DateTime.now(),
      //   products: transactionController.transactionProducts,
      // );

      setState(() {});
    }

    return Obx(() {
      final productList = productController.productList;
      final categoryList = categoryController.categoryList;
      final transactionList = transactionController.transactionProducts;

      return Container(
        color: ColorTheme.background,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          children: <Widget>[
            // VisibilityDetector(
            //   onVisibilityChanged: (VisibilityInfo info) {
            //     visible = info.visibleFraction > 0;
            //   },
            //   key: const Key('visible-detector-key'),
            //   child: BarcodeKeyboardListener(
            //     bufferDuration: const Duration(milliseconds: 200),
            //     onBarcodeScanned: (barcode) {
            //       if (!visible) return;
            //       debugPrint(barcode);

            //       var product = productController.productList
            //           .firstWhere((product) => product.id == barcode);

            //       setState(() {
            //         _barcode = barcode;
            //       });
            //     },
            //     useKeyDownEvent: Platform.isWindows,
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: <Widget>[
            //         Text(
            //           _barcode == null ? 'SCAN BARCODE' : 'BARCODE: $_barcode',
            //           style: Theme.of(context).textTheme.headlineSmall,
            //         ),
            //         // const Center(
            //         //   child: QRCodeGenerate(
            //         //     isShowAccountDetail: false,
            //         //     isShowAmountDetail: false,
            //         //     promptPayId: "0939529954",
            //         //     amount: 500.56,
            //         //     width: 200,
            //         //     height: 200,
            //         //   ),
            //         // ),
            //       ],
            //     ),
            //   ),
            // ),
            Expanded(
              flex: 6,
              child: Container(
                decoration: BoxDecoration(
                  color: ColorTheme.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: CategoriesTabBarComponent(
                        categories: categoryList.map((e) => e.name).toList(),
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
                                      .map((product) =>
                                          ProductCategoryCardComponent(
                                            product: product,
                                            onTap: () {
                                              onTapAddProduct(product);
                                            },
                                          ))
                                      .toList(),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                margin: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "สรุปบิล",
                                        style: CustomTextTheme.subtitleBold,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => {
                                      transactionController
                                          .deleteTransactionProduct()
                                    },
                                    child: const Icon(
                                      Icons.delete_outlined,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: transactionList.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    dense: true,
                                    visualDensity:
                                        const VisualDensity(vertical: -3),
                                    leading: Text(
                                        "${transactionList[index].amount.toString()}x"),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          transactionList[index].name,
                                          style: CustomTextTheme.smallBody,
                                        ),
                                        Row(
                                          children: [
                                            transactionList[index].amount > 1
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      right: 40,
                                                    ),
                                                    child: Text(
                                                      "${transactionList[index].price}/ชิ้น",
                                                      style: CustomTextTheme
                                                          .description,
                                                    ),
                                                  )
                                                : const SizedBox.shrink(),
                                            Text(
                                              transactionList[index]
                                                  .totalPrice
                                                  .toString(),
                                              style: CustomTextTheme
                                                  .smallBodyMedium,
                                            ),
                                            Text(
                                              " บาท",
                                              style: CustomTextTheme.smallBody,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                              child: Row(
                                children: [
                                  Text(
                                    "รายการทั้งหมด",
                                    style: CustomTextTheme.bodyMedium,
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      transactionController.tranTotalCount
                                          .toString(),
                                      style: CustomTextTheme.bodyMedium,
                                    ),
                                  ),
                                  const Text(
                                    "ชิ้น",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Text(
                                    "รวมทั้งสิ้น",
                                    style: CustomTextTheme.bodyMedium,
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      transactionController.tranTotalPrice == 0
                                          ? "0"
                                          : transactionController.tranTotalPrice
                                              .toStringAsFixed(2),
                                      style: CustomTextTheme.titleBold.copyWith(
                                        color: ColorTheme.success,
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    "บาท",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xff034C8C),
                      ),
                      alignment: Alignment.center,
                      height: 60,
                      child: InkWell(
                        onTap: () => {},
                        child: const Text(
                          "ชำระเงิน",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
