import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nsu_financial_app/models/budget.dart';
import 'package:nsu_financial_app/models/budget_screen.dart';
import 'package:nsu_financial_app/models/category.dart';
import 'package:nsu_financial_app/models/loan.dart';
import 'package:nsu_financial_app/models/transaction.dart';
import 'package:nsu_financial_app/notifiers/budget_notifier.dart';
import 'package:nsu_financial_app/notifiers/category_notifier.dart';
import 'package:nsu_financial_app/notifiers/general_notifiers.dart';
import 'package:nsu_financial_app/notifiers/loan_notifier.dart';
import 'package:nsu_financial_app/notifiers/transaction_notifier.dart';

import '../network_requests.dart';



final loggedInProvider = ChangeNotifierProvider<LoggedInNotifier>((ref) {
  return LoggedInNotifier();
});



final loanProvider = ChangeNotifierProvider<LoanChangeNotifier>((ref) {
  var currentLoan = Loan(name:"",amount:0,interest:0,term:0,);
  return LoanChangeNotifier(currentLoan);
});

final futureBudgetProvider = FutureProvider.autoDispose<List<dynamic>>((ref) async {
  ref.maintainState = false;
  BudgetScreenModel budgetScreenModel = await setBudgetAndCategories();
  budgetScreenModel.budget.getTotals();
  int sel = 1;
  return [budgetScreenModel, sel];
});

//Provider that returns current budget
final budgetProvider = ChangeNotifierProvider<BudgetNotifier>((ref) {
  Budget curBudget = Budget(user: 0, transactions: [], balance: 0);
  return BudgetNotifier(curBudget);
});


final transProvider = ChangeNotifierProvider<TransactionNotifier>((ref) {
  var currentTransaction = Transaction(amount:0, id: 0, transactionDate: DateTime.now(), description: '', budget: 0, category: 0,);
  return TransactionNotifier(currentTransaction);
});

//Provider that returns [the list of transaction categories from API, current selection for dropdown list]
final futureCategoriesListProvider = FutureProvider.autoDispose<List<dynamic>>((ref) async {
  CategoryList x = await fetchCategories();
  int sel = 1;
  return [x, sel];
});
//Provider for category choice when user adds or updates a transaction in budget
final categoryChoiceProvider = StateProvider((ref) => 0);

final newCategoryProvider = ChangeNotifierProvider<CategoryNotifier>((ref) {
  return CategoryNotifier();
});

// final loggedInProvider =
// StateNotifierProvider<LoggedInNotifier, bool>((ref) {
//   return LoggedInNotifier();
// });