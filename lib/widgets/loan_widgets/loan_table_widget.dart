import 'package:flutter/material.dart';
import 'package:nsu_financial_app/providers/providers.dart';
import 'package:nsu_financial_app/screens/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../main.dart';
class LoanTable extends ConsumerWidget {

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentLoan = watch(loanProvider);

      return DataTable(
        columnSpacing: 10,
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              'Month',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Payment',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Principle',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Interest',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Total Interest',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Balance Left',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
        rows:  _getSchedule(currentLoan.loan.schedule)



      );
    }
  }

_getSchedule(List schedule) {
  List<DataRow> rows = [];

  schedule.forEach((stat){

      rows.add(
          DataRow(
              cells: [
                DataCell(Text(stat[0].toString())),
                DataCell(Text(stat[1].toStringAsFixed(2)),),
                DataCell(Text(stat[2].toStringAsFixed(2)),),
                DataCell(Text(stat[3].toStringAsFixed(2)),),
                DataCell(Text(stat[4].toStringAsFixed(2)),),
                DataCell(Text(stat[5].toStringAsFixed(2)),),

              ]
          )
      );


  });

  return rows;

}