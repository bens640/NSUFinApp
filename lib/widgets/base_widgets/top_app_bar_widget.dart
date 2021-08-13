import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nsu_financial_app/models/budget.dart';
import 'package:nsu_financial_app/notifiers/general_notifiers.dart';
import 'package:nsu_financial_app/providers/providers.dart';

import '../../main.dart';

class TopAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title = 'NSU Fin';
  final AppBar appBar = AppBar();
  final List<Widget> widgets = [];
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    String token = '';

    var curBudget = watch(budgetProvider);
    var loggedIn = watch(loggedInProvider);

    Future<Null> logout() async {
      await storage.write(key: 'jwt', value: null);
      storage.read(key: 'jwt').then((value) => print(value));
      await storage.write(key: 'username', value: null);
      curBudget.budget = Budget(user: 0, transactions: [], balance: 0);
    }

    getToken().then((value) => token.isNotEmpty ? token = value : 0);
    var accountWidget = GestureDetector(
        onTap: () => {
              if (loggedIn.loggedIn)
                {
                  logout(),
                  loggedIn.flip(),
                }
              else Navigator.of(context).pushNamed('/login'),
            },
        child: Container(
            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: loggedIn.loggedIn ?
            Icon(Icons.account_circle, color: Colors.green,  ) :
            Icon(Icons.account_circle, color: Colors.red,  )
        )
    );


    return AppBar(
      title: Text(title),
      // backgroundColor: backgroundColor,
      actions:[accountWidget],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
