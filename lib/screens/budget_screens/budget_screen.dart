import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nsu_financial_app/models/budget.dart';
import 'package:http/http.dart' as http;
import 'package:nsu_financial_app/models/category.dart';
import 'package:nsu_financial_app/notifiers/budget_notifier.dart';
import 'package:nsu_financial_app/notifiers/category_notifier.dart';
import 'package:nsu_financial_app/providers/providers.dart';
import 'package:nsu_financial_app/widgets/budget_widgets/transaction_widget.dart';
import '../../main.dart';
import 'dart:async';

import '../../network_requests.dart';
import 'add_trans_screen.dart';

class BudgetScreen extends ConsumerWidget {
  const BudgetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // String tk = '';
    // getToken().then((value) => tk = value);
    // var curBudget = watch(budgetProvider);
    // final currentSession = watch(curSession);
    final futureBudget = watch(futureBudgetProvider);
    return Scaffold(
      body:
          // FutureBuilder(
          //     future: (fetchBudget()),
          //     builder: (context, snapshot) {
          //       print(snapshot);
          //       if (snapshot.hasData) print(snapshot);
          //       if (snapshot.hasData)
          //         curBudget.budget = snapshot.data as Budget;
          //       if (snapshot.hasError) print(snapshot.error);
          //       if (snapshot.hasData) {
          //         return ListView(
          //             padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          //             children: [
          //               Column(
          //                 children: [
          //                   Text(
          //                     'Budget Tracker',
          //                     style: TextStyle(fontSize: 25),
          //                   ),
          //                   Text(
          //                     "Current Balance",
          //                     style: TextStyle(fontSize: 19),
          //                   ),
          //                   Text(
          //                     NumberFormat.currency(symbol: '\$')
          //                         .format(curBudget.budget.balance),
          //                     style: TextStyle(
          //                         fontSize: 21, fontWeight: FontWeight.bold),
          //                   ),
          //                   Text('Transactions'),
          //                   ElevatedButton(
          //                       onPressed: () => {
          //
          //                             Navigator.push(
          //                                 context,
          //                                 MaterialPageRoute(
          //                                   builder: (context) =>
          //                                       AddOrEditTransaction(
          //                                         t: Transaction(description: '', category: 0, amount: 0, budget: 0, id: 0, transactionDate: DateTime.now()),
          //                                         isAdd: true,
          //                                   ),
          //                                 ))
          //                           },
          //                       child: Text('Add')),
          //                   Container(
          //                       height: 500,
          //                       child: TransactionsWidget(curBudget.budget))
          //                 ],
          //               ),
          //             ]);
          //       } else {
          //         return Center(child: CircularProgressIndicator());
          //       }
          //     } //builder
          //     ),




      futureBudget.when(
          data: (d) =>
              ListView(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          children: [
            Column(
              children: [
                Text(
                  'Budget Tracker',
                  style: TextStyle(fontSize: 25),
                ),
                Text(
                  "Current Balance",
                  style: TextStyle(fontSize: 19),
                ),
                Text(
                  NumberFormat.currency(symbol: '\$')
                      .format(d[0].budget.balance),
                  style: TextStyle(
                      fontSize: 21, fontWeight: FontWeight.bold),
                ),
                Text('Transactions'),
                ElevatedButton(
                    onPressed: () => {

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AddOrEditTransaction(
                                  t: Transaction(description: '', category: 0, amount: 0, budget: 0, id: 0, transactionDate: DateTime.now()),
                                  isAdd: true,
                                ),
                          ))
                    },
                    child: Text('Add')),
                Container(
                    height: 500,
                    child: TransactionsWidget(d[0], d[0].budget))
              ],
              ),
          ]),
          loading: () => CircularProgressIndicator(),
          error: (d, s) => Text(s.toString())),


      // FutureBuilder(
      //     future: (fetchBudget()),
      //     builder: (context, snapshot) {
      //       print(snapshot);
      //       if (snapshot.hasData) print(snapshot);
      //       if (snapshot.hasData)
      //         curBudget.budget = snapshot.data as Budget;
      //       if (snapshot.hasError) print(snapshot.error);
      //       if (snapshot.hasData) {
      //         return ListView(
      //             padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      //             children: [
      //               Column(
      //                 children: [
      //                   Text(
      //                     'Budget Tracker',
      //                     style: TextStyle(fontSize: 25),
      //                   ),
      //                   Text(
      //                     "Current Balance",
      //                     style: TextStyle(fontSize: 19),
      //                   ),
      //                   Text(
      //                     NumberFormat.currency(symbol: '\$')
      //                         .format(curBudget.budget.balance),
      //                     style: TextStyle(
      //                         fontSize: 21, fontWeight: FontWeight.bold),
      //                   ),
      //                   Text('Transactions'),
      //                   ElevatedButton(
      //                       onPressed: () => {
      //
      //                         Navigator.push(
      //                             context,
      //                             MaterialPageRoute(
      //                               builder: (context) =>
      //                                   AddOrEditTransaction(
      //                                     t: Transaction(description: '', category: 0, amount: 0, budget: 0, id: 0, transactionDate: DateTime.now()),
      //                                     isAdd: true,
      //                                   ),
      //                             ))
      //                       },
      //                       child: Text('Add')),
      //                   Container(
      //                       height: 500,
      //                       child: TransactionsWidget(curBudget.budget))
      //                 ],
      //               ),
      //             ]);
      //       } else {
      //         return Center(child: CircularProgressIndicator());
      //       }
      //     } //builder
      // ),





    );
  }
}
