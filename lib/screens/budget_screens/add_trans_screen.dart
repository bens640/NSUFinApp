import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:nsu_financial_app/network_requests.dart';

import 'package:nsu_financial_app/providers/providers.dart';
import 'package:nsu_financial_app/screens/budget_screens/budget_screen.dart';
import 'package:nsu_financial_app/widgets/appBar_widget.dart';
import 'package:nsu_financial_app/widgets/category_dropdown_list_widget.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nsu_financial_app/models/budget.dart';

void _showToast(BuildContext context) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: const Text('Cant be empty'),
    ),
  );
}

final textController = TextEditingController();

void displayNewCategoryDialog(context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Category'),
        content: Container(
          height: 150,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: Column(
                children: [
                  Text('Name of category'),
                  TextField(
                    controller: textController,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('Cancel')),
                      ElevatedButton(
                          onPressed: () => {
                                if (textController.text == '')
                                  {_showToast(context)}
                                else
                                  {
                                    context
                                            .read(newCategoryProvider)
                                            .category
                                            .name =
                                        toBeginningOfSentenceCase(
                                            textController.text)!,
                                    postCategory(context
                                        .read(newCategoryProvider)
                                        .category),
                                    Navigator.of(context).pop(),

                                  },
                              },
                          child: Text('Add')),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );

class AddOrEditTransaction extends ConsumerWidget {
  bool isAdd = true;
  Transaction t = Transaction(
      id: 0,
      description: '',
      amount: 0,
      transactionDate: DateTime.now(),
      budget: 0,
      category: 0);

  AddOrEditTransaction({
    required this.isAdd,
    required this.t,
  });

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final descriptionController = TextEditingController();
    final currentTrans = watch(transProvider);
    final futureCategoriesList = watch(futureCategoriesListProvider);
    final futureBudget = watch(futureBudgetProvider);
    //If isAdd is false, then initialize all controllers and notifiers to Transaction object that is being edited
    if (isAdd) {
      // currentTrans.totalAmount = t.amount;
      currentTrans.resetNotifier();
    } else {
      descriptionController.text = t.description;
      currentTrans.descriptionController.text = t.description;
      currentTrans.categoryController.text = t.category.toString();
      currentTrans.totalAmount = t.amount;
      currentTrans.transactionDateController = t.transactionDate;
      // currentTrans.transaction = t;
    }

    _onKeyboardTap(String value) {
      var _newValue = int.parse(value);
      currentTrans.updateAmount(_newValue);
    }

    _onBackTap() {
      currentTrans.backSpace();
    }

    Future<void> _selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2015),
          lastDate: DateTime(2050));
      if (pickedDate != null && pickedDate != DateTime.now()) {
        print('*****************' + pickedDate.toString());
        currentTrans.transactionDateController = pickedDate;
        currentTrans.setDate(pickedDate);
      }
    }

    return Scaffold(
      appBar: BaseAppBar(),
      body: ListView(padding: EdgeInsets.fromLTRB(0, 15, 0, 0), children: [
        Container(
          height: 40,
          child: Center(
            heightFactor: 1,
            child: Text(
              isAdd ? "Add Transaction" : "Edit Transaction",
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
                  child:
                      Text('\$' + currentTrans.totalAmount.toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                          )),
                ))
          ],
        ),
        Divider(
          thickness: 2,
          height: 0,
        ),
        TextField(
          controller: descriptionController,

          // controller: currentTrans.descriptionController,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              hintStyle: TextStyle(color: Colors.blue),
              hintText: "Description"),
        ),
        Divider(
          thickness: 2,
          height: 0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            futureCategoriesList.when(
                data: (data) =>
                    CategoryListDropdown(catList: data[0], index: data[1]),
                loading: () => CircularProgressIndicator(),
                error: (d, s) => Text(s.toString())),
            ElevatedButton(
                onPressed: () => displayNewCategoryDialog(context),
                child: Icon(Icons.add_rounded)),
          ],
        ),
        Divider(
          thickness: 2,
          height: 0,
        ),
        Container(
            height: 50,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () => {
                            _selectDate(context),
                            // print(currentTrans.transactionDateController)
                          },
                      child: Icon(Icons.date_range)),
                  Text(DateFormat.yMMMd()
                      .format(currentTrans.transactionDateController)),
                ])),
        Divider(
          thickness: 2,
          height: 0,
        ),
        Container(
          height: 300,
          child: NumericKeyboard(
            onKeyboardTap: _onKeyboardTap,
            leftIcon: Icon(Icons.backspace),
            leftButtonFn: () {
              _onBackTap();
            },
            rightIcon: Icon(Icons.arrow_forward_sharp),
            rightButtonFn: () {
              fetchBudget();
              currentTrans.transaction.description = descriptionController.text;
              currentTrans.transaction.category =
                  context.read(categoryChoiceProvider).state == 0
                      ? 1
                      : context.read(categoryChoiceProvider).state;
              currentTrans.addTrans();
              isAdd
                  ? postTrans(currentTrans.transaction)
                  : putTrans(currentTrans.transaction);
              currentTrans.reset();
              setBudgetAndCategories();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BudgetScreen()),
              );
            },
          ),
        )
      ]),
    );
  }
}
