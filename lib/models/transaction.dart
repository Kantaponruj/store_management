class Transaction {
  final String id;
  final double amount;
  final DateTime date;
  final List<TransactionProduct> products;

  Transaction({
    required this.id,
    required this.amount,
    required this.date,
    required this.products,
  });
}

class TransactionProduct {
  String id;
  String name;
  int quantity;
  double price;
  double amount;

  TransactionProduct({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.amount,
  });
}
