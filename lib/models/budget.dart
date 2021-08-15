import 'dart:convert';
import 'package:nsu_financial_app/models/transaction.dart';
//Budget data class
class Budget {
  Budget(
      {required this.user, required this.transactions, required this.balance})
      : _totals = {},
        budgetTotals = [];

  int user;
  double balance = 0;
  Map<int, double> _totals;
  // List of Transaction objects
  List<Transaction> transactions;
  // List of BudgetTotalDataObjects for circular chart
  List<BudgetTotalData> budgetTotals;
  //Returns an instance of the Budget class with given JSON data
  factory Budget.fromJson(Map<String, dynamic> json) => Budget(  //Converts input json into Budget Object
        user: json["user"],
        balance: double.parse(json['balance']),
        transactions: List<Transaction>.from(
            json["transactions"].map((x) => Transaction.fromJson(x))),
      );
  //Returns a JSON string from the supplied Budget instance
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
  }
}

