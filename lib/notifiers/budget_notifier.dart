import 'package:flutter/material.dart';
import 'package:nsu_financial_app/models/budget.dart';



class BudgetNotifier extends ChangeNotifier {
  BudgetNotifier(this.budget);

  Budget budget;


  void sortTransactions(String sort) {
    List<Transaction> transList= [];
    // for (dynamic x in budget.transactions){
    //
    // }
  switch (sort){
    case 'amount':{
      budget.transactions.sort((a, b) => a.amount.compareTo(b.amount));
    }
  }

    notifyListeners();
  }


}
