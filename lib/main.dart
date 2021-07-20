import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nsu_financial_app/models/category.dart';
// import 'package:nsu_financial_app/notifiers/category_notifier.dart';
import 'package:nsu_financial_app/notifiers/general_notifiers.dart';
import 'package:nsu_financial_app/notifiers/loan_notifier.dart';
import 'package:nsu_financial_app/screens/budget_screens/add_trans_screen.dart';
import 'package:nsu_financial_app/screens/budget_screens/budget_screen.dart';
import 'package:nsu_financial_app/screens/test_page.dart';
import 'package:nsu_financial_app/screens/document_screens/document_screen.dart';

import 'package:nsu_financial_app/screens/home_screen.dart';
import 'package:nsu_financial_app/screens/loan_screens/LoanScreen.dart';
import 'package:nsu_financial_app/screens/login_screen.dart';
import 'package:nsu_financial_app/widgets/appBar_widget.dart';
import 'package:nsu_financial_app/widgets/home_screen_menu_widget.dart';
import 'models/budget.dart';
import 'models/loan.dart';
import 'notifiers/budget_notifier.dart';
void main() => runApp(ProviderScope(child: MyApp()));


//Base address for API
const SERVER_IP = 'http://192.168.1.154:8000/API';
// Initialize secure storage for jwt and user id
final storage = FlutterSecureStorage();
// Function to get token for API calls






Future<dynamic> getToken() async{
  var jwt = await storage.read(key: 'jwt');
  return jwt;
}
// Function to get user ID for API calls
Future<dynamic> getUser() async{
  var id = await storage.read(key: 'id');
  return id;
}
final curSession = ChangeNotifierProvider<GeneralNotifier>((ref) {
  return GeneralNotifier();
});

final budgetProvider = ChangeNotifierProvider<BudgetNotifier>((ref) {
  Budget curBudget = Budget(user: 0, transactions: [], balance: 0);
  return BudgetNotifier(curBudget);
});


final loggedInProvider =
StateNotifierProvider<LoggedInNotifier, bool>((ref) {
  return LoggedInNotifier();
});


class MyApp extends ConsumerWidget {

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    String token = '';
    final currentSession = watch(curSession);
    getToken().then((value) => token.isNotEmpty  ? token = value: 0);

    final loggedIn = watch(loggedInProvider);


    return ProviderScope(
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/home': (context) => HomeScreen(loggedIn: currentSession.loggedIn,),
          '/loan': (context) => LoanScreen(),
          '/docs': (context) => MyApp2(),
          '/budget': (context) => BudgetScreen(),
          '/login': (context) => LoginPage()
        },
        title: 'NSU Financial App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color.fromRGBO(10, 36, 99,1),
          scaffoldBackgroundColor: Color.fromRGBO(176, 212, 232, 1)
        ),
        home: Scaffold(
          appBar: BaseAppBar(
            // title: Text('NSU Fin'),
            // appBar: AppBar(),

      ),

          body: HomeScreen(loggedIn: loggedIn),
          // body: HomeScreen(loggedIn: currentSession.loggedIn),
        ),
      ),
    );
  }
}