import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:store_management/services/firestore_db.dart';

import '../models/product.dart';

class ProductController extends GetxController with StateMixin {
  final box = GetStorage();

  RxList<ProductModel> productList = <ProductModel>[].obs;
  final product = ProductModel(
    category: '',
    id: '',
    name: '',
    price: 0,
    quantity: 0,
  ).obs;
  RxBool isReview = false.obs;
  RxBool isLoading = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    change(null, status: RxStatus.loading());

    Future.delayed(const Duration(seconds: 1), () async {
      await fetchData();
    });
  }

  fetchData() async {
    final storedString = box.read('products');
    if (storedString != null) {
      final jsonData = jsonDecode(storedString) as List;

      if (jsonData.isNotEmpty) {
        debugPrint("Products: $jsonData");
        productList.value =
            jsonData.map((product) => ProductModel.fromJson(product)).toList();
        change(productList, status: RxStatus.success());
      } else {
        change(productList, status: RxStatus.empty());
      }
    } else {
      debugPrint("Empty");
      change(productList, status: RxStatus.empty());
    }
  }

  getAllProducts() async {
    change(null, status: RxStatus.loading());
    final listFromFirestore = FirestoreDb.productStream();
    productList.bindStream(listFromFirestore);
    productList.refresh();

    if (productList.isNotEmpty) {
      var productsAsMap =
          productList.map((product) => product.toJson()).toList();
      String jsonString = jsonEncode(productsAsMap);
      box.write('products', jsonString);

      final storedString = box.read('products');
      debugPrint('Stored product: $storedString');
      await fetchData();
      change(productList, status: RxStatus.success());
    } else {
      change(productList, status: RxStatus.empty());
    }
  }

  addProduct(ProductModel product) async {
    productList.add(product);
    await FirestoreDb.addProduct(product);
    isReview.value = false;
  }
}
