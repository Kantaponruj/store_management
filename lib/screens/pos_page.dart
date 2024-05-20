import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:store_management/controllers/product_controller.dart';
import 'package:store_management/controllers/transaction_controller.dart';
import 'package:store_management/models/category.dart';
import 'package:store_management/models/components.dart';
import 'package:store_management/models/transaction.dart';
import 'package:store_management/screens/components/categories_tab_bar.dart';
import 'package:store_management/screens/components/custom_button.dart';
import 'package:store_management/screens/components/custom_text_fields.dart';
import 'package:store_management/screens/components/display_product.dart';
import 'package:store_management/screens/components/display_transaction.dart';
import 'package:store_management/screens/components/product_category_card.dart';
import 'package:store_management/screens/components/select_payment.dart';
import 'package:store_management/screens/components/snack_bar.dart';
import 'package:store_management/shared/theme/color_theme.dart';
import 'package:store_management/utils/barcode_scanner.dart';

import '../controllers/category_controller.dart';
import '../models/product.dart';

class POSPage extends StatefulWidget {
  const POSPage({super.key});

  @override
  State<POSPage> createState() => _POSPageState();
}

class _POSPageState extends State<POSPage> {
  Transaction? transaction;

  final productController = Get.put(ProductController());
  final transactionController = Get.put(TransactionController());
  final categoryController = Get.put(CategoryController());

  @override
  void initState() {
    debugPrint('isMobile: ${GetPlatform.isMobile}');
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    final context = Get.context!;

    return Obx(() {
      final productList = productController.productList;
      final categoryList = categoryController.categoryList;
      final transactionList = transactionController.transactionProducts;

      return Container(
        color: ColorTheme.background,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: context.isPhone
            ? Column(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorTheme.white,
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: CustomButton(
                                buttonName: "เลือกสินค้า", onPressed: () {}),
                          ),
                          IconButton(
                            onPressed: () async {
                              String barcodeScanRes =
                                  await FlutterBarcodeScanner.scanBarcode(
                                ColorTheme.primary.toString(),
                                "Cancel",
                                true,
                                ScanMode.BARCODE,
                              );

                              debugPrint(barcodeScanRes);
                            },
                            icon: const Icon(
                              Icons.qr_code_scanner_outlined,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  displayTransactionSide(
                    transactionList: transactionList,
                    paddingLeft: false,
                  ),
                ],
              )
            : Row(
                children: <Widget>[
                  displayProductSide(productList, categoryList),
                  displayTransactionSide(
                    transactionList: transactionList,
                  ),
                ],
              ),
      );
    });
  }

  void scanBarcode({required List<String> barcodes}) {
    final listTranProduct = transactionController.transactionProducts;
    for (String barcode in barcodes) {
      final TransactionProduct product =
          listTranProduct.firstWhere((element) => element.id == barcode);
      transactionController.addTransactionProduct(product);
    }
  }

  Widget displayProductSide(
      RxList<ProductModel> productList, RxList<ProductCategory> categoryList) {
    return Expanded(
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
                    .map(
                      (cat) => DiaplyProductListComponent(
                        children: productList
                            .where((item) {
                              if (cat.key == "all") {
                                return item.category == item.category;
                              } else {
                                return item.category == cat.key;
                              }
                            })
                            .map((product) => ProductCategoryCardComponent(
                                  product: product,
                                  onTap: () {
                                    onTapAddProduct(product);
                                  },
                                ))
                            .toList(),
                      ),
                    )
                    .toList(),
                titleActions: [
                  // buildSearchBox(),
                  IconButton(
                    onPressed: () => startBarcodeScanStream(
                      onScan: (barcode) {
                        List<String> listBarcode = [];
                        listBarcode.add(barcode.toString());
                        scanBarcode(barcodes: listBarcode);
                      },
                    ),
                    icon: const Icon(
                      Icons.qr_code_scanner_outlined,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget displayTransactionSide({
    required RxList<TransactionProduct> transactionList,
    bool paddingLeft = true,
  }) {
    return Expanded(
      flex: 3,
      child: DisplayTransaction(
        transactionList: transactionList,
        paddingLeft: paddingLeft,
        totalProduct: transactionController.tranTotalCount.toString(),
        totalPrice: transactionController.tranTotalPrice == 0
            ? "0"
            : transactionController.tranTotalPrice.toStringAsFixed(2),
        customButtonProps: CustomButtonProps(
          text: "ชำระเงิน",
          onTap: transactionList.isNotEmpty
              ? () {
                  showModalSelectPayment();
                }
              : null,
        ),
        popupMenu: [
          CustomMenuItem(
            title: "ลบทั้งหมด",
            icon: Icons.delete_forever_rounded,
            onTap: () {
              transactionController.clearTransaction();
            },
          ),
        ],
      ),
    );
  }

  void showModalSelectPayment() {
    showDialog(
      context: context,
      builder: (context) {
        return SelectPayment(
          paymentList: [
            paymentCard(
              text: "เงินสด",
              icon: Icons.payments_rounded,
              onPressed: () {
                Get.back();
                transactionController.clearTransaction();
                displaySnackbar(
                  title: 'สถาะการชำระเงิน',
                  content: 'ชำระเงินด้วยเงินสดสำเร็จ',
                  status: CustomSnackbarStatus.success,
                );
              },
            ),
            const SizedBox(width: 20),
            paymentCard(
              text: "Prompt Pay",
              icon: Icons.qr_code_rounded,
              onPressed: () {
                Get.offAndToNamed("/payment");
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildSearchBox() {
    return SizedBox(
      width: 200,
      child: Container(
        padding: const EdgeInsets.only(right: 20),
        alignment: Alignment.centerLeft,
        child: const CustomTextField(
          props: CustomTextFieldProps(
            topic: "",
            prefixIcon: Icon(Icons.search_outlined),
          ),
        ),
      ),
    );
  }
}
