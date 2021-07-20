import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nsu_financial_app/main.dart';
import 'package:nsu_financial_app/providers/providers.dart';
import 'package:nsu_financial_app/widgets/loan_widgets/loan_chart_widget.dart';
import 'package:nsu_financial_app/widgets/loan_widgets/loan_entry_widget.dart';
import 'package:nsu_financial_app/widgets/loan_widgets/loan_portrait_details_widget.dart';
import 'package:nsu_financial_app/widgets/loan_widgets/loan_table_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/src/date_format_internal.dart';
import 'package:intl/src/intl/number_format.dart';

class LoanScreen extends ConsumerWidget {


  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final currentLoan = watch(loanProvider);
    final _schedule = currentLoan.loan.schedule;
    return MaterialApp(
          home: Scaffold(
          body: Container(
              child: ListView(
                  children:
                  [
                    LoanEntry(),
                    isPortrait? LoanShortDetail(): LoanChart()
                  ]
              )
          )




    ));
  }
}
