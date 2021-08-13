import 'package:flutter/material.dart';
import 'package:nsu_financial_app/models/budget.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:nsu_financial_app/models/budget_screen.dart';
import 'package:nsu_financial_app/screens/budget_screens/add_trans_screen.dart';
import 'package:nsu_financial_app/widgets/budget_widgets/trans_row_widget.dart';
import '../../network_requests.dart';



class TransactionsWidget extends StatelessWidget {
  final Budget b;
  final BudgetScreenModel budget;
  const TransactionsWidget(this.budget, this.b, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(

      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
          margin: new EdgeInsets.fromLTRB(10, 4, 10, 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white70,
          ),
          child: ListView.builder(

              padding: EdgeInsets.zero,
              itemCount: b.transactions.length,
              itemBuilder: (BuildContext context, int index) {
                return Slidable(
                  startActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    extentRatio: 0.25,
                    children: [
                      SlidableAction(
                        label: 'Edit',
                        backgroundColor: Colors.green,
                        icon: Icons.edit,
                        onPressed: (context) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AddOrEditTransaction(
                                      t: b.transactions[index],
                                      isAdd: false,
                                    ),
                              ));
                        },
                      ),
                    ],
                  ),
                  endActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    extentRatio: 0.25,
                    children: [
                      SlidableAction(
                        label: 'Delete',
                        backgroundColor: Colors.red,
                        icon: Icons.delete,
                        onPressed: (context) {

                          deleteTrans(b.transactions[index].id);

                          Navigator.popAndPushNamed(context, '/budget') ;
    },
                      ),
                    ],
                  ),
                  child: TransRow(
                    b: b.transactions,
                    index: index,
                    budget: budget,
                  ),
                );
              }
              )
      ),
    );
  }
}


