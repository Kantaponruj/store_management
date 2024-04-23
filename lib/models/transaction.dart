class Transaction {
  final String id;
  final int amount;
  final DateTime date;
  final double totalPrice;
  final List<TransactionProduct> products;

  Transaction({
    required this.id,
    required this.amount,
    required this.date,
    required this.totalPrice,
    required this.products,
  });
}

class TransactionProduct {
  String id;
  String name;
  int amount;
  double price;
  double totalPrice;

  TransactionProduct({
    required this.id,
    required this.name,
    required this.amount,
    required this.price,
    required this.totalPrice,
  });
}
