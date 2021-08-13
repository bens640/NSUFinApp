import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nsu_financial_app/main.dart';
import 'package:nsu_financial_app/providers/providers.dart';
import 'package:url_launcher/url_launcher.dart';

class LoanShortDetail extends ConsumerWidget{


  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentLoan = watch(loanProvider);
    final String _studentLoanRateLink = 'https://studentloanhero.com/marketplace/private-student-loans';
    Future<void> _launchInWebViewOrVC(String url) async {
      if (await canLaunch(url)) {
        await launch(
          url,
          forceSafariVC: true,
          forceWebView: true,
          enableJavaScript: true,
          headers: <String, String>{'my_header_key': 'my_header_value'},
        );
      } else {
        throw 'Could not launch $url';
      }
    }
    Future<void>? _launched;
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
          ElevatedButton(
              onPressed: ()=>
                _launched = _launchInWebViewOrVC(_studentLoanRateLink),

              child: Text('Find Student Loan Rates')),
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