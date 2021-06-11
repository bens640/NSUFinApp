import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nsu_financial_app/models/document.dart';

import '../../main.dart';




Future<List<Document>> fetchDocument(http.Client client) async {
  final response = await client
      .get(Uri.parse(SERVER_IP+'/document'));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseDocuments, response.body);
}





List<Document> parseDocuments(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Document>((json) => Document.fromJson(json)).toList();
}



class MyApp2 extends StatelessWidget {


  MyApp2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: FutureBuilder<List<Document>>(
        future: fetchDocument(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? DocumentList(documents: snapshot.data!)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class DocumentList extends StatelessWidget {
  final List<Document> documents;

  DocumentList({Key? key, required this.documents}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return ListView.builder(

      itemCount: documents.length,
      itemBuilder: (context, index) {


        return ExpansionTile(
                           title: Text(documents[index].title),
                        children: [
                           Container(
                            height: screenHeight*.60,
                              child:Text(documents[index].link)
                           ),

                        ],
                      );
      },
    );
  }
}
