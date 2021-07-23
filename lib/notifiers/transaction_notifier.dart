import 'package:flutter/material.dart';
import 'package:nsu_financial_app/models/budget.dart';

class TransactionNotifier extends ChangeNotifier {

  late Transaction trans;
  TransactionNotifier(this.trans);
  var descriptionController = TextEditingController();
  DateTime transactionDateController = DateTime.now();
  var budget = 0;
  var categoryController = TextEditingController();
  double totalAmount = 0;
  int tempAmount = 0;



  addTrans(){
  trans.description = descriptionController.text;
  trans.amount = totalAmount;
  trans.transactionDate =  transactionDateController ;
  // trans.category = int.parse(categoryController.text);
  notifyListeners();
  }


  updateAmount(int value){
    if (tempAmount >= 0.001) tempAmount = tempAmount *10;
    tempAmount += value;
    print(tempAmount);
    totalAmount = tempAmount *.01 ;
    notifyListeners();
  }
  resetNotifier(){
    descriptionController.clear();
    categoryController.clear();
    // totalAmount = 0;
    // tempAmount = 0;

    // trans = new Transaction(id: 0, description: '', amount: totalAmount, transactionDate: DateTime.now(), budget: budget, category: 0);

    // notifyListeners();
  }
  backSpace(){
    if(tempAmount > 0){
      String _temp = tempAmount.toString();
    if (_temp.length == 1) _temp = '0';
    else _temp = _temp.substring(0, _temp.length-1);
    tempAmount = int.parse(_temp);
    totalAmount = tempAmount *.01 ;
  }
        notifyListeners();

  }

  reset(){
    descriptionController.text = '';
    categoryController.text = '';
    totalAmount = 0;
    tempAmount = 0;

    trans = new Transaction(id: 0, description: '', amount: totalAmount, transactionDate: DateTime.now(), budget: budget, category: 0);

    notifyListeners();
  }

  setDate(DateTime entry){
    transactionDateController = entry;
    trans.transactionDate = entry;
    notifyListeners();
  }


}