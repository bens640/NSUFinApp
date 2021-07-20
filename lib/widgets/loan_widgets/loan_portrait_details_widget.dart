import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nsu_financial_app/main.dart';
import 'package:nsu_financial_app/providers/providers.dart';

class LoanShortDetail extends ConsumerWidget{


  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentLoan = watch(loanProvider);
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // SizedBox(height: 50,),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Amount'),
                  Text(NumberFormat.currency(symbol: '\$').format(currentLoan.loan.amount)),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Interest rate'),
                  Text(NumberFormat.decimalPattern().format(currentLoan.loan.interest)+'%'),

                ],),
              Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Term'),

                  Text(((currentLoan.loan.term)/12 ).toString() + ' years')
                ],),


            ],
          ),
          SizedBox(height: 50,),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Monthly payment'),
              Text(NumberFormat.currency(symbol: '\$').format(currentLoan.loan.monthlyPayment), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ],),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Total Interest '),
              Text(NumberFormat.currency(symbol: '\$').format(currentLoan.loan.totalInterest), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),

            ],),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Total Payment'),
              Text(NumberFormat.currency(symbol: '\$').format((currentLoan.loan.monthlyPayment*currentLoan.loan.term)), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)
            ],),],
      ),
    );
  }
}