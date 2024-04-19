import 'package:flutter/material.dart';
import 'package:store_management/screens/components/categories_tab_bar.dart';
import 'package:store_management/shared/components/color_theme.dart';

import 'components/display_product.dart';

class POSPage extends StatefulWidget {
  const POSPage({super.key});

  @override
  State<POSPage> createState() => _POSPageState();
}

class _POSPageState extends State<POSPage> {
  @override
  Widget build(BuildContext context) {
    final List<String> drinkProducts = [
      "Drink 1",
      "Drink 2",
      "Drink 3",
      "Drink 4",
      "Drink 5",
      "Drink 6",
      "Drink 7",
      "Drink 8",
      "Drink 9",
      "Drink 10",
      "Drink 11",
      "Drink 12",
      "Drink 13",
      "Drink 14",
      "Drink 15",
      "Drink 16",
      "Drink 17",
      "Drink 18",
      "Drink 19",
      "Drink 20",
      "Drink 21",
      "Drink 22",
      "Drink 23",
      "Drink 24",
      "Drink 25",
      "Drink 26",
      "Drink 27",
      "Drink 28",
      "Drink 29",
      "Drink 30",
    ];
    final List<String> foodProducts = [
      "Food 1",
      "Food 2",
      "Food 3",
      "Food 4",
      "Food 5",
    ];
    final List<String> otherProducts = [
      "Product 1",
    ];

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
                          products: drinkProducts,
                        ),
                        DiaplyProductListComponent(
                          products: foodProducts,
                        ),
                        DiaplyProductListComponent(
                          products: otherProducts,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 20),
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
                              children: [
                                const Text(
                                  "รายการสินค้า",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  // onTap: () => clearAll(),
                                  child: const Icon(
                                    Icons.delete_outlined,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          // ListView.builder(
                          //   shrinkWrap: true,
                          //   itemCount: products.length,
                          //   itemBuilder: (context, index) {
                          //     return ListTile(
                          //       leading: Text(
                          //           "${products[index].quantity.toString()}x"),
                          //       title: Text("รายการที่ ${index + 1}"),
                          //       trailing: Text("${products[index].price} บาท"),
                          //     );
                          //   },
                          // ),
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Text(
                                  "รวมทั้งสิ้น",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Text(
                                    "0",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
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
                        "ชำระเงิน 0 บาท",
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
