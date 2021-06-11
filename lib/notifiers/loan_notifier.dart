import 'package:flutter/material.dart';
import 'package:nsu_financial_app/models/loan.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class LoanChangeNotifier extends ChangeNotifier {
  LoanChangeNotifier(this.loan);

  Loan loan;
  List<Loan> LoanList = [];
  var amount = TextEditingController();
  var interest = TextEditingController();
  var term = TextEditingController();

  ZoomPanBehavior zoomPan = ZoomPanBehavior(
    enablePinching: true
  );

  TrackballBehavior trackBall = TrackballBehavior(
      enable: true,
      tooltipSettings: InteractiveTooltip(
          enable: true,
          color: Colors.red
  ));


  void calcAmort() {
    // String amountString = amount.toString();
    // String interestString = interest.toString();
    // String termString = term.toString();
    reset();
    loan.amount = double.parse(amount.text);
    loan.interest = double.parse(interest.text);
    loan.term = int.parse(term.text)*12;
    loan.calcLoan();


    notifyListeners();
  }

  void reset(){
    loan.amount = 0;
    loan.interest = 0;
    loan.term = 0;
    loan.schedule = [];
  }

  void printAmort(){
    print('Total loan amount:\t${loan.amount}');
    print("Interest rate:\t\t${loan.interest}%");
    print("Term:\t\t\t\t${loan.term} months");
    print('Monthly payment:\t${loan.monthlyPayment}');
    print('Annual payment:\t\t${loan.monthlyPayment * 12}');
    print('Total Interest:\t\t${loan.monthlyPayment * loan.term - loan.amount}');
    print("Total Payment:\t\t${loan.totalInterest + loan.amount} ");

  ;

  }


}
