import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nsu_financial_app/models/budget.dart';
import 'package:nsu_financial_app/models/budget_screen.dart';
import 'package:nsu_financial_app/models/transaction.dart';

import '../../network_requests.dart';

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
                ),
                ),
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
                Text(DateFormat.yMMMd().format(b[index].transactionDate)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}