import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:nsu_financial_app/models/budget.dart';
import 'package:http/http.dart' as http;
import '../../main.dart';
import 'dart:async';

Future<Budget> fetchBudget(http.Client client) async {

  final response = await http.get(Uri.parse(SERVER_IP+'/budget/1'), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Token c77a22d25625664fe96a50746bf80c3a631a54d6',
  });

  final responseJson = jsonDecode(response.body);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Budget.fromJson(responseJson);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Budget');
  }
}

Future<Transaction> fetchTrans(http.Client client) async {

  final response = await http.get(Uri.parse(SERVER_IP+'/transaction/1'),
  //     headers: {
  //   'Content-Type': 'application/json',
  //   'Accept': 'application/json',
  //   'Authorization': 'Token: c77a22d25625664fe96a50746bf80c3a631a54d6',
  // }
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Transaction.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}




List<Budget> parseBudget(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Budget>((json) => Budget.fromJson(json)).toList();
}

class BudgetScreen extends ConsumerWidget {
  const BudgetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {

  return Column(
      children: [
        Text('Hello'),
        Expanded(
          child: FutureBuilder(
            future: fetchBudget(http.Client()),
            builder: (context, snapshot) {
              // final Transaction trans =context.owner;
              Budget t = snapshot.data as Budget;
              print(t.transactions[0].description);

              if (snapshot.hasError) print(snapshot.error);

              return snapshot.hasData
                  ? ListView.builder(
                    itemCount: t.transactions.length,
                    itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                    title: Text('Item ${t.transactions[index].description }'),
                  );
                },
              )
                  : Center(child: CircularProgressIndicator());
            },
          ),
        )
      ],
    );
  }
}

