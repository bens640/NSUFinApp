class Transaction {
  Transaction({
    required this.id,
    required this.description,
    required this.amount,
    required this.transactionDate,
    required this.budget,
    required this.category,
  });

  int id;
  String description;
  double amount;
  DateTime transactionDate;
  int budget;
  int category;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    id: json["id"],
    description: json["description"],
    amount: double.parse(json["amount"]),
    transactionDate: DateTime.parse(json["transaction_date"]),
    budget: json["budget"],
    category: json["category"],
  );

  Map<String, dynamic> toJson(int id) => {
    "description": description,
    "amount": amount,
    "transaction_date":
    "${transactionDate.year.toString().padLeft(4, '0')}-${transactionDate.month.toString().padLeft(2, '0')}-${transactionDate.day.toString().padLeft(2, '0')}",
    "budget": id,
    "category": category,
  };
}
//This model is for the circular chart on the budget page
class BudgetTotalData {
  final int category;
  final double amount;

  BudgetTotalData(this.category, this.amount);
}
