import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nsu_financial_app/models/budget.dart';
import 'package:nsu_financial_app/providers/providers.dart';
import 'package:nsu_financial_app/widgets/appBar_widget.dart';
import 'package:nsu_financial_app/widgets/bottom_app_bar_widget.dart';
import 'package:nsu_financial_app/widgets/budget_widgets/transaction_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'add_trans_screen.dart';

class BudgetScreen extends ConsumerWidget {
  const BudgetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var loggedIn = watch(loggedInProvider);
    final futureBudget = watch(futureBudgetProvider);
    final apiChange = watch(APIChangeProvider);

    return  Scaffold(
      appBar: BaseAppBar(),
      bottomNavigationBar: BottomBaseBar(),
      body:
      !loggedIn.loggedIn ? Center(

        child: Text('Please login to use this feature',
          textAlign: TextAlign.center,
          style: TextStyle(
          fontSize: 30
        ),
        ),
      ) :
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
                SfCircularChart(
                  series: <CircularSeries>[
                    PieSeries<BudgetTotalData, int>(
                      dataSource: d[0].budget.budgetTotals,
                      xValueMapper: (BudgetTotalData data,_)=> data.category,
                      yValueMapper: (BudgetTotalData data,_)=> data.amount,
                      explode: true,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                      dataLabelMapper: (BudgetTotalData data, _) => '${d[0].category.list[data.category-1]['name']} - \$${data.amount }',
                      enableTooltip: true,
                      enableSmartLabels: true,

                    )
                  ],
                ),

                 Text('Transactions', style: TextStyle(
                  fontSize: 20
                ),),
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
                (d[0].budget.transactions.length >= 1) ? Container(
                    height: 320,
                    child: TransactionsWidget(d[0], d[0].budget)
                ) :
                    Container()
              ],
              ),
          ]),
          loading: () => CircularProgressIndicator(),
          error: (d, s) => Column(
            children: [
              Center(child: Text(d.toString())),
              Center(child: Text(s.toString())),
            ],
          )),



    );
  }
}
