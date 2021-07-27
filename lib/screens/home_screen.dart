import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nsu_financial_app/main.dart';
import 'package:nsu_financial_app/screens/budget_screens/budget_screen.dart';
import 'package:nsu_financial_app/screens/loan_screens/LoanScreen.dart';
import 'package:nsu_financial_app/screens/test_page.dart';
import 'package:nsu_financial_app/widgets/appBar_widget.dart';
import 'package:nsu_financial_app/widgets/home_screen_menu_widget.dart';
import 'package:nsu_financial_app/screens/document_screens/document_screen.dart';
import 'budget_screens/add_category_screen.dart';
import 'budget_screens/add_trans_screen.dart';
import 'login_screen.dart';
import 'rss_screens/rss_screen.dart';

class HomeScreen extends ConsumerWidget {
  bool loggedIn = false;

  HomeScreen({required this.loggedIn});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentSession = watch(curSession);

    // return MaterialApp(
        //Route List for Entire App
        // routes: {
        //   '/home': (context) => HomeScreen(loggedIn: currentSession.loggedIn),
        //   '/loan': (context) => LoanScreen(),
        //   '/docs': (context) => DocumentScreen(),
        //   '/RssScreen': (context) => AddTransactionWidget(),
        //   '/budget': (context) => BudgetScreen(),
        //   '/login': (context) => LoginPage(),
        // },
        // debugShowCheckedModeBanner: false,
        return Scaffold(
          // appBar: BaseAppBar(widgets: [], title: Text('Test1'), appBar: AppBar(),),
          body: SafeArea(
              child: HomeScreenWidget()),
        );
    // );
  }
}
