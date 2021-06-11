// To parse this JSON data, do
//
//     final budget = budgetFromJson(jsonString);
import 'dart:convert';

List<Budget> budgetFromJson(String str) => List<Budget>.from(json.decode(str).map((x) => Budget.fromJson(x)));

String budgetToJson(List<Budget> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Budget {
  Budget({
    required this.user,
    required this.transactions,
  });

  int user;
  List<Transaction> transactions;

  factory Budget.fromJson(Map<String, dynamic> json) => Budget(
    user: json["user"],
    transactions: List<Transaction>.from(json["transactions"].map((x) => Transaction.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
  };
}

class Transaction {
  Transaction({
    required this.id,
    required this.description,
    required this.amount,
    required this.dateCreated,
    required this.transactionDate,
    required this.budget,
    required this.category,
  });

  int id;
  String description;
  int amount;
  DateTime dateCreated;
  DateTime transactionDate;
  int budget;
  int category;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    id: json["id"],
    description: json["description"],
    amount: json["amount"],
    dateCreated: DateTime.parse(json["date_created"]),
    transactionDate: DateTime.parse(json["transaction_date"]),
    budget: json["budget"],
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "amount": amount,
    "date_created": "${dateCreated.year.toString().padLeft(4, '0')}-${dateCreated.month.toString().padLeft(2, '0')}-${dateCreated.day.toString().padLeft(2, '0')}",
    "transaction_date": "${transactionDate.year.toString().padLeft(4, '0')}-${transactionDate.month.toString().padLeft(2, '0')}-${transactionDate.day.toString().padLeft(2, '0')}",
    "budget": budget,
    "category": category,
  };

  getAmount(){
    return amount;
  }
}
