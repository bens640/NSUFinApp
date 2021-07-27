import 'package:flutter/material.dart';
import 'package:nsu_financial_app/models/budget.dart';
import 'package:nsu_financial_app/models/category.dart';

class CategoryNotifier extends ChangeNotifier {
  TransCategory category = TransCategory(id: 0, isIncome: false, isParent: false, name: '');

}