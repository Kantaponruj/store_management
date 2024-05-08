import 'package:get/get.dart';

import '../models/category.dart';

class CategoryController extends GetxController {
  RxList<ProductCategory> categoryList = <ProductCategory>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  addCategory(ProductCategory category) {
    categoryList.add(category);
  }

  Future<void> fetchCategories() async {
    await Future.delayed(const Duration(seconds: 1));
    List<ProductCategory> categories = [
      ProductCategory(id: "1", key: "all", name: "ทั้งหมด"),
      ProductCategory(id: "2", key: "drink", name: "เครื่องดื่ม"),
      ProductCategory(id: "3", key: "snack", name: "ขนม"),
      ProductCategory(id: "4", key: "other", name: "อื่น ๆ"),
    ];

    categoryList.addAll(categories);
  }
}
