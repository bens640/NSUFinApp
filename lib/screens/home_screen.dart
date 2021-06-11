import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nsu_financial_app/main.dart';
import 'package:nsu_financial_app/screens/budget_screens/budget_screen.dart';
import 'package:nsu_financial_app/screens/document_screens/document_screen.dart';

import 'package:nsu_financial_app/screens/loan_screens/LoanScreen.dart';
import 'package:nsu_financial_app/widgets/home_screen_menu_widget.dart';

import 'package:nsu_financial_app/screens/document_screens/document_screen_api_test.dart';

import 'login_screen.dart';


// class HomeScreen extends StatelessWidget {
  // HomeScreen(this.jwt, this.payload);
  //
  // factory HomeScreen.fromBase64(String jwt) =>
  //     HomeScreen(
  //         jwt,
  //         json.decode(
  //             ascii.decode(
  //                 base64.decode(base64.normalize(jwt.split(".")[0]))
  //             )
  //         )
  //     );

  // final String jwt;
  // final Map<String, dynamic> payload;

  // @override
  // Widget build(BuildContext context) =>
  //
  //
  //     Scaffold(
  //       appBar: AppBar(title: Text("Secret Data Screen")),
  //       body: Center(
  //         child: FutureBuilder(
  //
  //             future: getjwt(),
  //             builder: (context, snapshot) =>
  //           Text(snapshot.data.toString()),
  //
  //         )
  //       ),
          // child: FutureBuilder(
          //     // future: http.read(Uri.parse(SERVER_IP+'/budget/1'), headers: {"Authorization": jwt}),
          //     builder: (context, snapshot) =>
          //     snapshot.hasData ?
          //     Column(children: <Widget>[
          //       Text("${payload['user']}, here's the data:"),
          //       Text(payload['id'], style: Theme.of(context).textTheme.display1)
          //     ],)
          //         :
          //     snapshot.hasError ? Text("An error occurred") : CircularProgressIndicator()
          // ),
      //   ),
      // );
      // );}






class HomeScreen extends ConsumerWidget {
 bool loggedIn = false;
 HomeScreen({required this.loggedIn});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentSession = watch(curSession);

    return MaterialApp(
        //Route List for Entire App
        routes: {
          '/home': (context) => HomeScreen(loggedIn: currentSession.loggedIn),
          '/loan': (context) => LoanScreen(),
          '/docs': (context) => MyApp2(),
          '/login': (context) => LoginPage(),
          '/budget': (context) => BudgetScreen()
        },
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          // appBar: AppBar(
          //   title: Text(_title),
          //   actions: [
          //
          //     PopupMenuButton(
          //       onSelected: (route) => Navigator.pushNamed(context, route),
          //       itemBuilder: (BuildContext context) {
          //         return _menuItems.map((choice) {
          //           return PopupMenuItem<String>(
          //             value: '/${choice.toLowerCase()}',
          //             child: Text(choice),
          //           );
          //         }).toList();
          //       },
          //     )
          //   ],
          // ),
          body: SafeArea(
            child: Container(
                child: HomeScreenWidget()


    )
          ),
            )

        );
  }


}

