import 'package:get/get.dart';

import '../models/product.dart';

class ProductController extends GetxController {
  RxList<ProductModel> productList = <ProductModel>[].obs;
  final product = ProductModel(
    category: '',
    id: '',
    name: '',
    price: 0,
    quantity: 0,
  ).obs;
  RxBool isReview = false.obs;

  @override
  void onInit() {
    fetchTransactions();
    super.onInit();
  }

  addProduct(ProductModel product) {
    productList.add(product);
    isReview.value = false;
  }

  Future<void> fetchTransactions() async {
    await Future.delayed(const Duration(seconds: 1));
    final List<ProductModel> initailProducts = [
      ProductModel(
          category: "drink",
          id: "drink_0",
          name: "Berry Smoothie",
          quantity: 28,
          price: 30),
      ProductModel(
          category: "drink",
          id: "drink_1",
          name: "Iced Coffee",
          quantity: 10,
          price: 50),
      ProductModel(
          category: "drink",
          id: "drink_2",
          name: "Green Tea",
          quantity: 45,
          price: 45),
      ProductModel(
          category: "drink",
          id: "drink_3",
          name: "Sparkling Citrus",
          description: "Orange and lime juice",
          quantity: 50,
          price: 35),
      ProductModel(
          category: "snack",
          id: "snack_1",
          name: "Mango Lassi",
          quantity: 14,
          price: 30),
      ProductModel(
          category: "snack",
          id: "snack_2",
          name: "Mango Smoothie",
          quantity: 10,
          price: 40),
      ProductModel(
          category: "snack",
          id: "snack_3",
          name: "Watermelon Smoothie",
          quantity: 15,
          price: 30),
      ProductModel(
          category: "snack",
          id: "snack_4",
          name: "Water",
          quantity: 19,
          price: 10),
      ProductModel(
          category: "other",
          id: "other_1",
          name: "Americano",
          quantity: 23,
          price: 55),
      ProductModel(
          category: "other",
          id: "other_2",
          name: "Pepsi",
          quantity: 12,
          price: 20)
    ];

    productList.assignAll(initailProducts);
  }
}
