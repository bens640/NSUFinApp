import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nsu_financial_app/notifiers/general_notifiers.dart';
import 'package:nsu_financial_app/notifiers/loan_notifier.dart';
import 'package:nsu_financial_app/screens/budget_screens/budget_screen.dart';
import 'package:nsu_financial_app/screens/document_screens/document_screen.dart';
import 'package:nsu_financial_app/screens/document_screens/document_screen_api_test.dart';

import 'package:nsu_financial_app/screens/home_screen.dart';
import 'package:nsu_financial_app/screens/loan_screens/LoanScreen.dart';
import 'package:nsu_financial_app/screens/login_screen.dart';
import 'models/loan.dart';
// import 'notifiers/order_notifier.dart';

const SERVER_IP = 'http://192.168.1.154:8000/API';

final storage = FlutterSecureStorage();

Future<dynamic> getToken() async{
  var jwt = await storage.read(key: 'jwt');
  // Map valueMap = json.decode(jwt!);
  return jwt;
}


void main() => runApp(ProviderScope(child: MyApp()));

final loanProvider = ChangeNotifierProvider<LoanChangeNotifier>((ref) {
  var currentLoan = Loan(name:"",amount:0,interest:0,term:0,);
  return LoanChangeNotifier(currentLoan);
});

final curSession = ChangeNotifierProvider<GeneralNotifier>((ref) {
  return GeneralNotifier();
});

class MyApp extends ConsumerWidget {

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    String token = '';
    final currentSession = watch(curSession);
    getToken().then((value) => token = value);
    return ProviderScope(
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/home': (context) => HomeScreen(loggedIn: currentSession.loggedIn,),
          '/loan': (context) => LoanScreen(),
          '/docs': (context) => MyApp2(),
          '/budget': (context) => BudgetScreen()
        },
        title: 'NSU Financial App',
        debugShowCheckedModeBanner: false,

        home: Scaffold(

          appBar: AppBar(
            title: Text('Test'),

          ),
          body: HomeScreen(loggedIn: currentSession.loggedIn),
        ),
      ),
    );
  }
}