import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nsu_financial_app/providers/providers.dart';
import 'package:nsu_financial_app/screens/budget_screens/budget_screen.dart';
import 'package:nsu_financial_app/screens/document_screens/document_screen.dart';
import 'package:nsu_financial_app/screens/home_screens/home_screen.dart';
import 'package:nsu_financial_app/main.dart';
import 'package:nsu_financial_app/screens/loan_screens/loan_screen.dart';
import 'package:nsu_financial_app/screens/rss_screens/rss_screen.dart';


class HomeScreenWidget extends ConsumerWidget {
  //Creates a list of links
  // Map<String, dynamic> naviList = {'Loans': LoanScreen(), 'News':'/RssScreen','Documents': '/docs', 'Budget Tracker': '/budget'};
  Map<String, dynamic> naviList = {'Loans': LoanScreen(), 'News': RssScreen(),'Documents': DocumentScreen(), 'Budget Tracker': BudgetScreen()};

  // dynamic username = await storage.read(key: 'username');
  @override
  Widget build(BuildContext context, ScopedReader watch) {

    final currentLoan = watch(loanProvider);
    final _schedule = currentLoan.loan.schedule;
    String username = '';
    getUser().then((value) => username = value);
    return Container(

      child: Column(
        children: [
          Center(
            child: Stack(alignment: Alignment.center, children: [
              SizedBox(
                width: 275,
                height: 200,
                child: const DecoratedBox(
                  decoration: const BoxDecoration(color: Colors.blueAccent),
                ),
              ),
              Text(
                'NSU Financial App',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              )
            ]),
          ),

          Expanded(
            child: new GridView.builder(
                itemCount: 4,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  String key = naviList.keys.elementAt(index);
                  return new Card(
                    child: new InkResponse(
                      child: Text('$key'),
                      onTap: (){
                        // Navigator.pushNamed(context, '${naviList[key]}');
                        Navigator.push(
                          context,
                          new MaterialPageRoute(builder: (ctxt) =>  naviList[key]),
                        );
                      },
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
