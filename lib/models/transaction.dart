class Transaction{
  int id;
  String description;
  double amount;
  int budgetId;
  int category;
  String transDate;


  Transaction({required this.id, required this.description,required this.amount,
    required this.budgetId, required this.category,
    required this.transDate
    });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      description: json['description'],
      amount: json['amount'],
      budgetId: json['budget'],
      id: json['id'],
      transDate: json['transDate'],
      category: json['category'],

    );
  }
}