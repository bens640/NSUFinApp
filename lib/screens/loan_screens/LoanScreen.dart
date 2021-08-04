import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nsu_financial_app/providers/providers.dart';
import 'package:nsu_financial_app/widgets/appBar_widget.dart';
import 'package:nsu_financial_app/widgets/bottom_app_bar_widget.dart';
import 'package:nsu_financial_app/widgets/loan_widgets/loan_chart_widget.dart';
import 'package:nsu_financial_app/widgets/loan_widgets/loan_entry_widget.dart';
import 'package:nsu_financial_app/widgets/loan_widgets/loan_portrait_details_widget.dart';


class LoanScreen extends ConsumerWidget {


  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final currentLoan = watch(loanProvider);
    return  Scaffold(
        appBar: BaseAppBar(),
        bottomNavigationBar: BottomBaseBar(),
          body: SafeArea(
            child: Container(
                child: ListView(
                    children:
                    [
                      LoanEntry(),
                      isPortrait? LoanShortDetail(): LoanChart()
                    ]
                )
            ),
          )




    );
  }
}
