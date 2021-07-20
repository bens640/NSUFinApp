
import 'dart:convert';

List<Budget> budgetFromJson(String str) => List<Budget>.from(json.decode(str).map((x) => Budget.fromJson(x)));

String budgetToJson(List<Budget> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Budget {
  Budget({
    required this.user,
    required this.transactions,
    required this.balance
  });

  int user;
  double balance = 0;
  List<Transaction> transactions;

  factory Budget.fromJson(Map<String, dynamic> json) => Budget(
    user: json["user"],
    balance: double.parse(json['balance']),
    transactions: List<Transaction>.from(json["transactions"].map((x) => Transaction.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    // 'balance': balance,
    "transactions": List<dynamic>.from(transactions.map((x) => x.toJson(this.user))),
  };
}

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
    "transaction_date": "${transactionDate.year.toString().padLeft(4, '0')}-${transactionDate.month.toString().padLeft(2, '0')}-${transactionDate.day.toString().padLeft(2, '0')}",
    "budget": id,
    "category": category,
  };

  getAmount(){
    return amount;
  }
}
