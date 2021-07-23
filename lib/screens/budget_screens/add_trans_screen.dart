import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:intl/intl.dart';

import 'package:nsu_financial_app/models/category.dart';
import 'package:nsu_financial_app/notifiers/category_notifier.dart';
import 'package:nsu_financial_app/providers/providers.dart';
import 'package:nsu_financial_app/screens/budget_screens/budget_screen.dart';
import 'package:nsu_financial_app/widgets/category_dropdown_list_widget.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nsu_financial_app/models/budget.dart';
import 'package:http/http.dart' as http;
import 'package:nsu_financial_app/notifiers/transaction_notifier.dart';
import '../../main.dart';





Future postTrans( Transaction currentTrans) async {
  dynamic jwt = await storage.read(key: 'jwt');
  dynamic id = await storage.read(key: 'id');
  int idInt = int.parse(id);

  var data =currentTrans.toJson(idInt);
  print(data);
  final response = await http.post(Uri.parse(SERVER_IP+'/transaction/'),
        headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token: '+ jwt,
    },
      body: jsonEncode(data)


  );
  if(response.statusCode == 200)
    print(response.body);
    return response.body;


  }

Future putTrans( Transaction currentTrans) async {
  dynamic jwt = await storage.read(key: 'jwt');
  dynamic id = await storage.read(key: 'id');
  int idInt = int.parse(id);

  var data =currentTrans.toJson(idInt);
  print(data);
  final response = await http.put(Uri.parse(SERVER_IP+'/transaction/'+currentTrans.id.toString()+'/'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token: '+ jwt,
      },
      body: jsonEncode(data)


  );
  if(response.statusCode == 200)
    print(response.body);
  return response.body;


}


class AddOrEditTransaction extends ConsumerWidget {
  bool isAdd = true;
  Transaction t = Transaction(id: 0, description: '', amount: 0, transactionDate: DateTime.now(), budget: 0, category: 0);
  AddOrEditTransaction({required this.isAdd, required this.t,} );
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentTrans = watch(transProvider);
    final futureCategoriesList = watch(futureCategoriesListProvider);
    //If isAdd is false, then initialize all controllers and notifiers to Transaction object that is being edited
    if (isAdd){
      // currentTrans.totalAmount = t.amount;
      currentTrans.resetNotifier();
    }
    else{
      currentTrans.descriptionController.text = t.description;
      currentTrans.categoryController.text = t.category.toString();
      // currentTrans.amount = t.amount;
      currentTrans.totalAmount = t.amount;
      currentTrans.transactionDateController = t.transactionDate;
      currentTrans.trans = t;
    }
    // New Object if addTrans is true, else passed in argument
    // if (isAdd)currentTrans.trans = t;

    _onKeyboardTap(String value) {
      var _newValue = int.parse(value);
      currentTrans.updateAmount(_newValue)  ;
    }
    _onBackTap(){
      currentTrans.backSpace();

    }
    Future<void> _selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2015),
          lastDate: DateTime(2050));
      if (pickedDate != null && pickedDate != DateTime.now()){
        print('*****************'+pickedDate.toString());
        currentTrans.transactionDateController = pickedDate;
        currentTrans.setDate(pickedDate);
      }
    }

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
        children: [
          Container(
            height: 40,
            child: Center(
              heightFactor: 1,
              child: Text( isAdd ? "Add Transaction": "Edit Transaction",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Divider(
            thickness: 2,
            height: 0,
          ),
          Stack(
            children: [
              Container(
                height: 100,
                width: 400,
                color: Colors.blue,
                child: Center(
                    child: Text('\$' + currentTrans.totalAmount.toStringAsFixed(2),
                        style: TextStyle(
                          fontSize:45,
                          fontWeight: FontWeight.bold,)
                ),
              ))
            ],
          ),
          Divider(
            thickness: 2,
            height: 0,
          ),
          TextField(

            controller: currentTrans.descriptionController,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.blue),
                hintText: "Description"
            ),
          ),
          Divider(
            thickness: 2,
            height: 0,
          ),
        futureCategoriesList.when(
            data: (data) => CategoryListDropdown(catList: data[0], index: data[1]),
            loading: ()=>CircularProgressIndicator(),
            error: (d, s) => Text(s.toString())),

          // TextField(
          //   controller: currentTrans.categoryController,
          //   textAlign: TextAlign.center,
          //   decoration: InputDecoration(
          //       hintStyle: TextStyle(color: Colors.blue),
          //       hintText: "Category"
          //   ),
          // ),
          Divider(
            thickness: 2,
            height: 0,
          ),
          Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: ()=>{
                    _selectDate(context),
                    // print(currentTrans.transactionDateController)
                  },
                      child: Icon(Icons.date_range)),
                  Text(DateFormat.yMMMd().format(currentTrans.transactionDateController)),
                  ElevatedButton(onPressed: ()=>{},
                      child: Icon(Icons.add_rounded)),
                ],
              )),
          Divider(
            thickness: 2,
            height: 0,
          ),
        Container(
          height: 300,
          child: NumericKeyboard(
              onKeyboardTap: _onKeyboardTap,
            leftIcon: Icon(Icons.backspace),

            leftButtonFn:() {
                _onBackTap();
            },
            rightIcon: Icon(Icons.arrow_forward_sharp),
            rightButtonFn: (){
                currentTrans.trans.category = context.read(categoryChoiceProvider).state;
                currentTrans.addTrans();
              isAdd ? postTrans(currentTrans.trans): putTrans(currentTrans.trans);
              currentTrans.reset();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BudgetScreen()),
                );
            },
          ),
        )


          ]
      ),
    );
  }
}
