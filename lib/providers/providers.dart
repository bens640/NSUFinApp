import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nsu_financial_app/models/budget.dart';
import 'package:nsu_financial_app/models/loan.dart';
import 'package:nsu_financial_app/notifiers/budget_notifier.dart';
import 'package:nsu_financial_app/notifiers/general_notifiers.dart';
import 'package:nsu_financial_app/notifiers/loan_notifier.dart';

import '../network_requests.dart';

final budgetProvider = ChangeNotifierProvider<BudgetNotifier>((ref) {
  Budget curBudget = Budget(user: 0, transactions: [], balance: 0);
  return BudgetNotifier(curBudget);
});


final loggedInProvider =
StateNotifierProvider<LoggedInNotifier, bool>((ref) {
  return LoggedInNotifier();
});

final loanProvider = ChangeNotifierProvider<LoanChangeNotifier>((ref) {
  var currentLoan = Loan(name:"",amount:0,interest:0,term:0,);
  return LoanChangeNotifier(currentLoan);
});

final futureBudgetProvider = FutureProvider<List<dynamic>>((ref) async {
  BudgetScreenModel x = await setBudgetAndCategories();
  int sel = 1;
  return [x, sel];
});