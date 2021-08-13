import 'dart:convert';

import 'package:nsu_financial_app/models/transaction.dart';

List<Budget> budgetFromJson(String str) =>
    List<Budget>.from(json.decode(str).map((x) => Budget.fromJson(x)));

String budgetToJson(List<Budget> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Budget {
  Budget(
      {required this.user, required this.transactions, required this.balance})
      : _totals = {},
        budgetTotals = [];

  int user;
  double balance = 0;
  Map<int, double> _totals;
  List<Transaction> transactions;
  List<BudgetTotalData> budgetTotals;

  factory Budget.fromJson(Map<String, dynamic> json) => Budget(  //Converts input json into Budget Object
        user: json["user"],
        balance: double.parse(json['balance']),
        transactions: List<Transaction>.from(
            json["transactions"].map((x) => Transaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "transactions":
            List<dynamic>.from(transactions.map((x) => x.toJson(this.user))),
      };

  getTotals() { // Calculates totals for each transaction category
    for (Transaction t in transactions) {
      if (_totals[t.category] == null)
        _totals[t.category] = t.amount;
      else
        _totals[t.category] = (_totals[t.category]! + t.amount)!;
    }
    _totals.forEach((key, value) {
      budgetTotals.add(BudgetTotalData(key, value));
    });
    print(_totals);
  }
}

