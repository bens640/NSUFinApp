import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nsu_financial_app/models/budget.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:nsu_financial_app/screens/budget_screens/add_trans_screen.dart';
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

class TransRow extends StatelessWidget {
  final List<Transaction> b;
  final BudgetScreenModel budget;
  final int index;
  const TransRow({Key? key, required this.b, required this.index, required this.budget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    getName(List list, int id){
      for (var c in list){
        if (c['id'] == id) return c['name'];

      }
      return 'Uncategorized';
    };
    String? name = getName(budget.category.list, budget.budget.transactions[index].category);
    return Container(
      margin: EdgeInsets.fromLTRB(0, 3, 0, 3),
      // color: Colors.blueAccent,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.5),
            spreadRadius: 5,
            blurRadius: 4,
            offset: Offset(4 , 8), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(b[index].description, style: TextStyle(
                    fontWeight: FontWeight.w700,
                  fontSize: 18
                ),),
                Text(
                  NumberFormat.currency(symbol: '\$').format(b[index].amount),
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    '${name!}'
                ),
                // Text(budget.budget.transactions[index].category.toString()),
                Text(DateFormat.yMMMd().format(b[index].transactionDate)),
              ],
            ),
            // Divider(
            //   thickness: 2,
            //   indent: 10,
            //   endIndent: 10,
            // )
          ],
        ),
      ),
    );
  }
}
