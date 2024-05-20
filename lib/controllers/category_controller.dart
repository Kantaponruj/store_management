import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:store_management/services/firestore_db.dart';

import '../models/category.dart';

class CategoryController extends GetxController with StateMixin {
  final box = GetStorage();

  RxList<ProductCategory> categoryList = <ProductCategory>[].obs;
  RxBool isOpen = false.obs;

  @override
  void onInit() {
    super.onInit();

    Future.delayed(const Duration(seconds: 1), () async {
      await fetchCategories();
    });
  }

  addCategory(ProductCategory category) async {
    categoryList.add(category);
    await FirestoreDb.addCategory(category);
  }

  Future<void> fetchCategories() async {
    change(null, status: RxStatus.loading());
    await Future.delayed(const Duration(seconds: 1));
    List<ProductCategory> categories = [
      ProductCategory(id: "1", key: "all", name: "ทั้งหมด"),
      ProductCategory(id: "2", key: "drink", name: "เครื่องดื่ม"),
      ProductCategory(id: "3", key: "snack", name: "ขนม"),
      ProductCategory(id: "4", key: "other", name: "อื่น ๆ"),
    ];
    categoryList.addAll(categories);
    change(categoryList, status: RxStatus.success());

    if (isOpen.value) {
      final storedString = box.read('categories');
      if (storedString != null) {
        final jsonData = jsonDecode(storedString) as List;

        if (jsonData.isNotEmpty) {
          categoryList.value = jsonData
              .map((product) => ProductCategory.fromJson(product))
              .toList();
          change(categoryList, status: RxStatus.success());
        } else {
          change(categoryList, status: RxStatus.empty());
        }
      } else {
        final listFromFirestore = FirestoreDb.categoryStream();
        categoryList.bindStream(listFromFirestore);

        if (categoryList.isNotEmpty) {
          var categoriesAsMap =
              categoryList.map((cat) => cat.toJson()).toList();
          String jsonString = jsonEncode(categoriesAsMap);
          box.write('categories', jsonString);

          change(categoryList, status: RxStatus.success());
        } else {
          change(categoryList, status: RxStatus.empty());
        }
      }
    }
  }
}
