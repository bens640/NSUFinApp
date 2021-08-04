import 'package:flutter/material.dart';
import 'package:nsu_financial_app/screens/budget_screens/budget_screen.dart';
import 'package:nsu_financial_app/screens/document_screens/document_screen.dart';
import 'package:nsu_financial_app/screens/home_screen.dart';
import 'package:nsu_financial_app/screens/loan_screens/LoanScreen.dart';
import 'package:nsu_financial_app/screens/rss_screens/rss_screen.dart';
import 'package:nsu_financial_app/main.dart';

class BottomBaseBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BottomBaseBar();
  }
}

class _BottomBaseBar extends State<BottomBaseBar> {
  int _currentIndex = 0;
 Map<String, dynamic> _naviList = {'home':HomeScreen(),'Loans': LoanScreen(), 'News': RssScreen(),'Documents': DocumentScreen(), 'Budget Tracker': BudgetScreen()};
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(

        onTap: onTabTapped,
        currentIndex: _currentIndex,
        backgroundColor: Colors.blue,
        fixedColor:Color.fromRGBO(10, 36, 99,1) ,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.blueGrey,),
            label: 'Home',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money, color: Colors.blueGrey,),
            label: 'Loan Calculator',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.new_releases_sharp, color: Colors.blueGrey,),
              label: 'Publications'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.rss_feed, color: Colors.blueGrey,),
              label: 'News'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on_rounded, color: Colors.blueGrey,),
              label: 'Budget',

          )
        ],
      );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushNamed(context, "/home");
        break;
      case 1:
        _navigatorKey.currentState!.pushReplacementNamed("Account");
        break;
      case 2:
        _navigatorKey.currentState!.pushReplacementNamed("Settings");
        break;
      case 3:
        _navigatorKey.currentState!.pushReplacementNamed("Settings");
        break;
      case 4:
        _navigatorKey.currentState!.pushReplacementNamed("Settings");
        break;

    }
  }


}


