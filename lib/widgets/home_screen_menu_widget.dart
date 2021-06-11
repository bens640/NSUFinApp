import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nsu_financial_app/screens/home_screen.dart';
import 'package:nsu_financial_app/main.dart';


class HomeScreenWidget extends ConsumerWidget {
  //Creates a list of links
  Map<String, String> naviList = {'Loans': '/loan', 'Salary Calc':'/login','Documents': '/docs', 'Budget Tracker': '/budget'};
  @override
  Widget build(BuildContext context, ScopedReader watch) {

    final currentLoan = watch(loanProvider);
    final _schedule = currentLoan.loan.schedule;



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
                        Navigator.pushNamed(context, '${naviList[key]}');
                        print(index);
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
