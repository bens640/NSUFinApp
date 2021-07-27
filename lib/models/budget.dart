
import 'dart:convert';

List<Budget> budgetFromJson(String str) => List<Budget>.from(json.decode(str).map((x) => Budget.fromJson(x)));

String budgetToJson(List<Budget> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Budget {
  Budget({
    required this.user,
    required this.transactions,
    required this.balance
  }):
  _totals ={},
  budgetTotals = [];

  int user;
  double balance = 0;
  Map<int, double> _totals;
  List<Transaction> transactions;
  List<BudgetTotalData> budgetTotals;

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
   getTotals(){
    for (Transaction t in transactions){
      if (_totals[t.category] == null) _totals[t.category] = t.amount;
      else _totals[t.category] = (_totals[t.category]! + t.amount)!;
    }
    _totals.forEach((key, value) {budgetTotals.add(BudgetTotalData(key, value)); });
    print(_totals);

  }


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




}

class BudgetTotalData{
  final int category;
  final double amount;
  BudgetTotalData(this.category, this.amount);
}