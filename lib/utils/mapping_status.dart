import 'package:store_management/models/category.dart';

String mappingCategory(String key, List<ProductCategory> categoryList) {
  for (ProductCategory category in categoryList) {
    if (category.key == key) {
      return category.name;
    }
  }

  return "";
}
