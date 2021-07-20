import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nsu_financial_app/main.dart';
import 'package:nsu_financial_app/providers/providers.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/src/date_format_internal.dart';
import 'package:intl/src/intl/number_format.dart';

import 'loan_table_widget.dart';
class LoanChart extends ConsumerWidget {


  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentLoan = watch(loanProvider);
    final _schedule = currentLoan.loan.schedule;
    return Column(
      children: [
        Center(
            child: InteractiveViewer(
              child: Container(
                  child: SfCartesianChart(
                    zoomPanBehavior: currentLoan.zoomPan,
                      trackballBehavior: currentLoan.trackBall,
                      primaryXAxis: NumericAxis(
                        minimum: 0,
                        interval: 12,

                      ),
                      primaryYAxis: NumericAxis(
                          minimum: 0,
                          numberFormat: NumberFormat.simpleCurrency()
                      ),
                      legend: Legend(
                        isVisible: true,

                      ),
                      series: <LineSeries>[
                        LineSeries<dynamic, dynamic>(
                          name: 'Balance',
                          color: Colors.black,
                          dataSource: _schedule,
                          xValueMapper: (dynamic _schedule, _) => _schedule[0],
                          yValueMapper: (dynamic _schedule, _) => _schedule[5],
                        ),
                        LineSeries<dynamic, dynamic>(
                            color: Colors.amber,
                            name: 'Interest Paid',
                            dataSource: _schedule,
                            xValueMapper: (dynamic _schedule, _) => _schedule[0],
                            yValueMapper: (dynamic _schedule, _) => _schedule[4]
                        ),
                        LineSeries<dynamic, dynamic>(
                            color: Colors.blue,
                            name: 'Total Paid',
                            dataSource: _schedule,
                            xValueMapper: (dynamic _schedule, _) => _schedule[0],
                            yValueMapper: (dynamic _schedule, _) => _schedule[0]* _schedule[1]
                        )

                      ]

                  )
              ),
            )
        ),
        LoanTable(),
      ],
    );
  }
}
