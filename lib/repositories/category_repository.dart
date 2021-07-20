import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:nsu_financial_app/models/category.dart';

import '../main.dart';

abstract class ICategoryRepository {
  Future<TransCategory> getCategories();
}

class CategoryRepository implements ICategoryRepository {


  @override
  Future<TransCategory> getCategories() async {
    dynamic jwt = await storage.read(key: 'jwt');
    final response = await http.get(Uri.parse(SERVER_IP + '/category/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token ' + jwt,
        });
    final responseJson = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // print(responseJson);

      return TransCategory.fromJson(responseJson);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Categories');
    }
  }

}