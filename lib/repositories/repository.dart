import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nsu_financial_app/models/budget.dart';

import 'package:nsu_financial_app/models/category.dart';

import '../main.dart';

abstract class Repository {

  List<Transaction> findAllTransactions();

// 2
  Transaction findTransactionById(int id);

// 3
  List<TransCategory> findAllCategories();

// 4
  List<TransCategory> findCategoryById(int recipeId);
  int insertTransaction(Transaction transaction);
  int insertCategory(TransCategory transCategory);
  void deleteTransaction(Transaction transaction);
  Future init();
  void close();
}

