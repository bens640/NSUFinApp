import 'dart:math';

class Loan {
  String name;
  double amount;
  double interest;
  int term;
  double monthlyPayment = 0;
  double totalInterest = 0;
  double extraPayments = 0;
  List<dynamic> schedule = [];

  Loan({
    required this.name,
    required this.amount,
    required this.interest,
    required this.term,
  })  : monthlyPayment = 0,
        totalInterest = 0;

  void calcLoan() {
    List<dynamic> current = [];
    var balanceLeft = amount;
    var tInterest = 0.0;
    var currentInterest = 0.0;
    var currentPrincipal = 0.0;
    var j = (interest / 100) / 12;
    num x = pow(1 + j, -term);

    monthlyPayment = amount * (j / (1 - x));

    for (int i = 0; i < term; i++) {
      currentInterest = (j * balanceLeft);
      tInterest += currentInterest;
      currentPrincipal = monthlyPayment - currentInterest;
      balanceLeft -= currentPrincipal;
      current = [
        i + 1,
        monthlyPayment,
        currentPrincipal,
        currentInterest,
        tInterest,
        balanceLeft
      ];
      schedule.add(current);
    }

    totalInterest = tInterest;
  }
}
