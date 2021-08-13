import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nsu_financial_app/widgets/base_widgets/top_app_bar_widget.dart';
import 'package:nsu_financial_app/widgets/base_widgets/bottom_app_bar_widget.dart';
import 'package:nsu_financial_app/widgets/loan_widgets/loan_chart_widget.dart';
import 'package:nsu_financial_app/widgets/loan_widgets/loan_entry_widget.dart';
import 'package:nsu_financial_app/widgets/loan_widgets/loan_portrait_details_widget.dart';


class LoanScreen extends ConsumerWidget {

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return  Scaffold(
        appBar: TopAppBar(),
        bottomNavigationBar: BottomBaseBar(),
          body: SafeArea(
            child: Container(
                child: ListView(
                    children:
                    [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                        child: Center(
                          child: Text(
                            'Loan Calculator',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                      ),
                      LoanEntry(),
                      isPortrait? LoanShortDetail(): LoanChart()
                    ]
                )
            ),
          )




    );
  }
}
