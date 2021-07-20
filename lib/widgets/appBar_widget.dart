import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nsu_financial_app/models/budget.dart';
import 'package:nsu_financial_app/notifiers/general_notifiers.dart';

import '../main.dart';






class BaseAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final Color backgroundColor = Colors.red;
  final String title = 'NSU Fin';
  final AppBar appBar = AppBar();
  final List<Widget> widgets = [];
  bool isLoggedIn = false;


  @override
  Widget build(BuildContext context, ScopedReader watch) {
    String token = '';
    final currentSession = watch(curSession);
    var curBudget = watch(budgetProvider);
    var loggedIn = watch(loggedInProvider);
    Future<Null> logout() async {
      await storage.write(key: 'jwt', value: null);
      storage.read(key: 'jwt').then((value) => print(value));
      await storage.write(key: 'username', value: null);
      curBudget.budget = Budget(user: 0, transactions: [], balance: 0);

    }
    getToken().then((value) => token.isNotEmpty  ? token = value: 0);
    widgets.add(GestureDetector(onTap: () =>{
      if(loggedIn)
        { print( loggedIn),
          // Navigator.pushNamed(context, '/login'),
          logout(),

          print('logged-in'),
          curBudget.budget = Budget(balance: 0, transactions: [],user: 0),
          loggedIn = !loggedIn,
        }
      else {
        Navigator.of(context).pushNamed('/login'),
        print('logged-out'),
        print( loggedIn),
        loggedIn = !loggedIn,

      }
    },
        child: Icon(Icons.account_circle)
    ));



    return AppBar(
      title: Text(title),
      backgroundColor: backgroundColor,
      actions: widgets,
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}