import 'package:get/get.dart';

import '../models/transaction.dart';

class TransactionController extends GetxController {
  final transactionList = <Transaction>[].obs;
  final transactionProducts = <TransactionProduct>[].obs;

  double get tranTotalPrice =>
      transactionProducts.fold(0, (sum, item) => sum + item.totalPrice);

  int get tranTotalCount =>
      transactionProducts.fold(0, (sum, item) => sum + item.amount);

  addTransactionProduct(TransactionProduct product) {
    final list = transactionProducts;
    final duplicateIndex =
        transactionProducts.indexWhere((element) => element.id == product.id);

    if (duplicateIndex != -1) {
      list[duplicateIndex].amount += 1;

      final price = list[duplicateIndex].price;
      final amount = list[duplicateIndex].amount;
      final total = price * amount;
      list[duplicateIndex].totalPrice = total;
    } else {
      list.add(product);
    }
  }

  deleteTransactionProduct(String productId) {
    final list = transactionProducts;

    final index = list.indexWhere((element) => element.id == productId);
    list.removeAt(index);
  }

  clearTransaction() {
    final list = transactionProducts;

    list.clear();
  }

  addTransaction(TransactionProduct transaction) {
    transactionProducts.add(transaction);
  }
}
