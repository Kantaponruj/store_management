import 'package:flutter/material.dart';
import 'package:store_management/models/transaction.dart';
import 'package:store_management/screens/components/categories_tab_bar.dart';
import 'package:store_management/shared/theme/color_theme.dart';
import 'package:store_management/shared/theme/text_theme.dart';

import '../models/product.dart';
import '../utils/constant.dart';
import 'components/display_product.dart';
import 'components/product_category_card.dart';

class POSPage extends StatefulWidget {
  const POSPage({super.key});

  @override
  State<POSPage> createState() => _POSPageState();
}

class _POSPageState extends State<POSPage> {
  List<TransactionProduct> products = [];
  Transaction? transaction;

  @override
  Widget build(BuildContext context) {
    void onTapAddProduct(Product product) {
      double total = 0.0;
      int totalAmount = 0;

      TransactionProduct item = TransactionProduct(
        id: product.id,
        name: product.name,
        price: product.price,
        amount: 1,
        totalPrice: product.price,
      );

      final duplicateIndex =
          products.indexWhere((element) => element.id == item.id);

      if (duplicateIndex != -1) {
        products[duplicateIndex].amount += 1;

        final price = products[duplicateIndex].price;
        final amount = products[duplicateIndex].amount;
        final total = price * amount;
        products[duplicateIndex].totalPrice = total;
      } else {
        products.add(item);
      }

      for (int i = 0; i < products.length; i++) {
        final price = products[i].price;
        final amount = products[i].amount;

        total += price * amount;
        totalAmount += amount;
      }

      transaction = Transaction(
        id: "${products.length}_${DateTime.now()}",
        amount: totalAmount,
        totalPrice: total,
        date: DateTime.now(),
        products: products,
      );

      setState(() {});
    }

    return Container(
      color: ColorTheme.background,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: <Widget>[
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
                      categories: const ["เครื่องดื่ม", "อาหาร", "อื่น ๆ"],
                      tabBarView: [
                        DiaplyProductListComponent(
                          children: drinkProducts
                              .map((product) => ProductCategoryCardComponent(
                                    productName: product.name,
                                    onTap: () {
                                      onTapAddProduct(product);
                                    },
                                  ))
                              .toList(),
                        ),
                        DiaplyProductListComponent(
                          children: foodProducts
                              .map((e) => ProductCategoryCardComponent(
                                  productName: e.name,
                                  onTap: () {
                                    debugPrint(e.id);
                                  }))
                              .toList(),
                        ),
                        DiaplyProductListComponent(
                          children: otherProducts
                              .map((e) => ProductCategoryCardComponent(
                                  productName: e.name,
                                  onTap: () {
                                    debugPrint(e.id);
                                  }))
                              .toList(),
                        ),
                      ],
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
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(10)),
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
                                    setState(() {
                                      products.clear();
                                      transaction = null;
                                    })
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
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  dense: true,
                                  visualDensity:
                                      const VisualDensity(vertical: -3),
                                  leading: Text(
                                      "${products[index].amount.toString()}x"),
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        products[index].name,
                                        style: CustomTextTheme.smallBody,
                                      ),
                                      Row(
                                        children: [
                                          products[index].amount > 1
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    right: 40,
                                                  ),
                                                  child: Text(
                                                    "${products[index].price}/ชิ้น",
                                                    style: CustomTextTheme
                                                        .description,
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          Text(
                                            products[index]
                                                .totalPrice
                                                .toString(),
                                            style:
                                                CustomTextTheme.smallBodyMedium,
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
                                    transaction?.amount.toString() ?? "0",
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
                                    transaction?.totalPrice.toString() ?? "0",
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
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(10),
                      ),
                      color: Color(0xff034C8C),
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
  }
}
