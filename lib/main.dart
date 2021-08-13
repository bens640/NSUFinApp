import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nsu_financial_app/screens/budget_screens/add_category_screen.dart';
import 'package:nsu_financial_app/screens/budget_screens/budget_screen.dart';
import 'package:nsu_financial_app/screens/document_screens/document_screen.dart';
import 'package:nsu_financial_app/screens/home_screens/home_screen.dart';
import 'package:nsu_financial_app/screens/loan_screens/loan_screen.dart';
import 'package:nsu_financial_app/screens/login_screen/login_screen.dart';


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






class MyApp extends ConsumerWidget {

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    String token = '';
    getToken().then((value) => token.isNotEmpty  ? token = value: 0);

    return ProviderScope(
      child: MaterialApp(
        initialRoute: '/',
        routes: {

          '/loan': (context) => LoanScreen(),
          '/docs': (context) => DocumentScreen(),
          '/RssScreen': (context) => AddTransactionWidget(),
          '/budget': (context) => BudgetScreen(),
          '/login': (context) => LoginPage(),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color.fromRGBO(10, 36, 99,1),
          scaffoldBackgroundColor: Color.fromRGBO(176, 212, 232, 1)
        ),
        home: Scaffold(
                    body: Container(child: HomeScreen()),
        ),
      ),
    );
  }
}