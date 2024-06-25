import 'package:flutter/material.dart';
import 'package:store_management/shared/components/app_bar_component.dart';

import '../models/button_values.dart';

class ManualPOSPage extends StatefulWidget {
  const ManualPOSPage({super.key});

  @override
  State<ManualPOSPage> createState() => _ManualPOSPageState();
}

class _ManualPOSPageState extends State<ManualPOSPage> {
  String productPrice = "";
  int productQuantity = 1;
  String totalPrice = "";

  List<Product> products = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarComponent(
        title: "Manual POS",
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        color: const Color(0xffF2F2F2),
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      // output
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Text(
                                        "จำนวนชิ้น",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          disabledColor: Colors.grey,
                                          onPressed: productQuantity <= 1
                                              ? null
                                              : () {
                                                  setState(() {
                                                    productQuantity--;
                                                  });
                                                },
                                          icon: const Icon(Icons.remove),
                                        ),
                                        const Spacer(),
                                        Text(
                                          productQuantity.toString(),
                                          style: const TextStyle(
                                            fontSize: 36,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.end,
                                        ),
                                        const Spacer(),
                                        IconButton(
                                          disabledColor: Colors.grey,
                                          onPressed: () {
                                            setState(() {
                                              productQuantity++;
                                            });
                                          },
                                          icon: const Icon(Icons.add),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const VerticalDivider(),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Padding(
                                        padding:
                                            EdgeInsets.only(top: 20, right: 50),
                                        child: Text(
                                          "ราคา",
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        productPrice == "" ? "0" : productPrice,
                                        style: const TextStyle(
                                          fontSize: 48,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                      const Spacer(),
                                      const Text(
                                        "บาท",
                                        style: TextStyle(
                                          fontSize: 36,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: Btn.buttonNumbers
                                          .take(3)
                                          .map(
                                            (value) => displayButton(value),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: Btn.buttonNumbers
                                          .skip(3)
                                          .take(3)
                                          .map(
                                            (value) => displayButton(value),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: Btn.buttonNumbers
                                          .skip(6)
                                          .take(3)
                                          .map(
                                            (value) => displayButton(value),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: Btn.buttonNumbers
                                          .skip(9)
                                          .map(
                                            (value) => displayButton(value),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: Btn.buttonPOSOperators
                                    .map(
                                      (value) => displayButton(value),
                                    )
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
                                      onTap: () => clearAll(),
                                      child: const Icon(
                                        Icons.delete_outlined,
                                        color: Colors.grey,
                                      )),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.grey.withOpacity(0.3),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: Text(
                                      "${products[index].quantity.toString()}x"),
                                  title: Text("รายการที่ ${index + 1}"),
                                  trailing:
                                      Text("${products[index].price} บาท"),
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  const Text(
                                    "รวมทั้งสิ้น",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      totalPrice == "" ? "0" : totalPrice,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
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
                        child: Text(
                          "ชำระเงิน $totalPrice บาท",
                          style: const TextStyle(
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
      ),
    );
  }

  Widget buildButton({
    Icon? icon,
    String? text,
    required String value,
    bool textBold = true,
  }) {
    return Expanded(
      flex: value == Btn.n0 ? 2 : 1,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
          color: Colors.grey.withOpacity(0.2),
        )),
        child: InkWell(
          onTap: () => onBtnTap(value),
          child: Center(
            child: icon ??
                Text(
                  text ?? value,
                  style: TextStyle(
                    fontWeight: textBold ? FontWeight.bold : FontWeight.normal,
                    fontSize: 24,
                  ),
                ),
          ),
        ),
      ),
    );
  }

  Widget displayButton(value) {
    switch (value) {
      case Btn.del:
        return buildButton(
            value: value,
            icon: const Icon(
              Icons.backspace_outlined,
              color: Colors.red,
              size: 40,
            ));
      case Btn.calculate:
        return buildButton(
            value: value,
            icon: const Icon(
              Icons.arrow_forward_outlined,
              color: Colors.green,
              size: 50,
            ));
      default:
        return buildButton(value: value, text: value);
    }
  }

  void onBtnTap(String value) {
    if (value == Btn.del) {
      delete();
      return;
    }

    if (value == Btn.calculate) {
      calculate();
      return;
    }

    appendValue(value);
  }

  void appendValue(String value) {
    // assign value to number1 variable
    if (productPrice.isEmpty) {
      // check if value is "." | ex: number1 = "1.2"
      if (value == Btn.dot && productPrice.contains(Btn.dot)) return;
      if (value == Btn.dot &&
          (productPrice.isEmpty || productPrice == Btn.n0)) {
        // ex: number1 = "" | "0"
        value = "0.";
      }
    }

    productPrice += value;

    setState(() {});
  }

  void calculate() {
    double result = 0.0;

    setState(() {
      products.add(Product(
        price: productPrice,
        quantity: productQuantity,
      ));
    });

    for (int i = 0; i < products.length; i++) {
      final price = double.parse(products[i].price);

      result += price * products[i].quantity;
    }

    setState(() {
      totalPrice = result.toStringAsPrecision(3);
      productPrice = "";
      productQuantity = 1;
    });
  }

  void delete() {
    if (productPrice.isNotEmpty) {
      productPrice = productPrice.substring(0, productPrice.length - 1);
    }

    setState(() {});
  }

  void clearAll() {
    setState(() {
      productPrice = "";
      totalPrice = "";
      products.clear();
    });
  }
}

class Product {
  final String price;
  final int quantity;

  Product({required this.price, required this.quantity});
}
