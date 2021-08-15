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


  void calcAmort() { // gets data from notifier and calculates loan
    reset();
    loan.amount = double.parse(amount.text);
    loan.interest = double.parse(interest.text);
    loan.term = int.parse(term.text)*12;
    loan.calcLoan();
    notifyListeners();
  }

  void reset(){ // Resets all inputs to 0
    loan.amount = 0;
    loan.interest = 0;
    loan.term = 0;
    loan.schedule = [];
  }



}
