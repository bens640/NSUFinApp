
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'main.dart';
import 'models/budget.dart';
import 'package:http/http.dart' as http;
import 'models/budget_screen.dart';
import 'models/category.dart';
import 'models/document.dart';
import 'models/transaction.dart';


Future attemptLogIn(String username, String password) async {
  var res = await http.post(
      Uri.parse(SERVER_IP+'/login/'),
      body: {
        "username": username,
        "password": password
      }
  );
  if(res.statusCode == 200) return res.body;
  return null;
}


Future<int> attemptSignUp(String username, String password) async {
  var res = await http.post(
      Uri.parse(SERVER_IP+'/signup/'),
      body: {
        "username": username,
        "password": password
      }
  );
  return res.statusCode;

}


Future<Budget> fetchBudget() async {
  dynamic jwt = await storage.read(key: 'jwt');
  dynamic id = await storage.read(key: 'id');
  final response =
  await http.get(Uri.parse(SERVER_IP + '/budget/' + id), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Token ' + jwt,
  });

  final responseJson = jsonDecode(response.body);
  print(id);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // print(responseJson);
    return Budget.fromJson(responseJson);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Budget');
  }
}

Future deleteTrans(int id) async {
  dynamic jwt = await storage.read(key: 'jwt');
  final response = await http.delete(Uri.parse(SERVER_IP+'/transaction/'+id.toString()+'/'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token '+ jwt,
      });
  if (response.statusCode == 204) {
  } else {
    throw Exception('Failed to delete transaction');
  }
}



Future fetchCategories() async {
  dynamic jwt = await storage.read(key: 'jwt');
  final response =
  await http.get(Uri.parse(SERVER_IP + '/category/'), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Token ' + jwt,
  });
  final responseJson = jsonDecode(response.body);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // print(responseJson);
    // return CategoryList.fromJson(responseJson);
    return CategoryList(list: responseJson);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Categories');
  }
}




Future setBudgetAndCategories() async{
   Budget budget = await fetchBudget();
  CategoryList catList =await  fetchCategories();
  BudgetScreenModel x = BudgetScreenModel(budget: budget, category: catList);
  return x;
}



Future<List<Document>> fetchDocument() async {
  final response = await http
      .get(Uri.parse(SERVER_IP+'/document'));

  return compute(parseDocuments, response.body);
}

List<Document> parseDocuments(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Document>((json) => Document.fromJson(json)).toList();
}


Future postCategory( TransCategory cat) async {
  dynamic jwt = await storage.read(key: 'jwt');
  dynamic id = await storage.read(key: 'id');
  int idInt = int.parse(id);

  var data = cat.toJson();
  print(data);
  final response = await http.post(Uri.parse(SERVER_IP+'/category/'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token: '+ jwt,
      },
      body: jsonEncode(data)


  );
  if(response.statusCode == 200)
    print(response.body);
  return response.body;


}





Future postTrans( Transaction currentTrans) async {
  dynamic jwt = await storage.read(key: 'jwt');
  dynamic id = await storage.read(key: 'id');
  int idInt = int.parse(id);
  var data = currentTrans.toJson(idInt);
  final response = await http.post(Uri.parse(SERVER_IP+'/transaction/'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token: '+ jwt,
      },
      body: jsonEncode(data)


  );
  if(response.statusCode == 200)
    print(response.body);
  return response.body;


}

Future putTrans( Transaction currentTrans) async {
  dynamic jwt = await storage.read(key: 'jwt');
  dynamic id = await storage.read(key: 'id');
  int idInt = int.parse(id);

  var data =currentTrans.toJson(idInt);
  print(data);
  final response = await http.put(Uri.parse(SERVER_IP+'/transaction/'+currentTrans.id.toString()+'/'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token: '+ jwt,
      },
      body: jsonEncode(data)


  );
  if(response.statusCode == 200)
    print(response.body);
  return response.body;


}