// // import 'dart:convert';
// //
// // import 'package:flutter/material.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:nsu_financial_app/main.dart';
// // import 'package:native_pdf_view/native_pdf_view.dart';
// // import 'package:http/http.dart' as http;
// //
// //
// // class DocumentScreen1 extends ConsumerWidget {
// //   final pdfController1 = PdfController(
// //     document: PdfDocument.openAsset('assets/1.pdf'),
// //   );
// //   final pdfController2 = PdfController(
// //     document: PdfDocument.openAsset('assets/2.pdf'),
// //   );
// //
// //
// //   @override
// //   Widget build(BuildContext context, ScopedReader watch) {
// //     double screenHeight = MediaQuery.of(context).size.height;
// //
// //       return MaterialApp(
// //           home: Scaffold(
// //             body: Container(
// //               child: Column(
// //                 children: [
// //                   Text('Documents',
// //                       style: TextStyle(
// //                           fontWeight: FontWeight.bold,
// //                           fontSize: 30
// //                       )
// //                   ),
// //
// //                   ListView(
// //                     shrinkWrap: true,
// //                     padding: EdgeInsets.all(10.0),
// //                     children: [
// //                       ExpansionTile(
// //                           title: Text('US Veterans Educational Benefits'),
// //                         children: [
// //                           Container(
// //                             height: screenHeight*.60,
// //                               child: PdfView(
// //                                   controller: pdfController1,
// //                               )
// //                           ),
// //
// //                         ],
// //                       ),
// //                       ExpansionTile(
// //                         title: Text('Financial Aid Process'),
// //                         children: [
// //                           Container(
// //                               height: 500,
// //                               child: PdfView(
// //                                   controller: pdfController2
// //                               )
// //                           ),
// //
// //                         ],
// //                       ),
// //                     ],
// //                   ),
// //
// //                 ],
// //
// //               ),
// //           ),
// //         )
// //       );
// //
// //     }
// //
// //   }
// //
//
//
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:nsu_financial_app/main.dart';
// import 'package:native_pdf_view/native_pdf_view.dart';
// import 'package:http/http.dart' as http;
// import 'package:nsu_financial_app/models/document.dart';
//
// Future<Document> fetchLoan() async {
//   final response =
//   // await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
//   await http.get(Uri.parse('http://192.168.1.154:8000/viewset/document'));
//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return Document.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load Document');
//   }
// }
//
//
//
//
// class DocumentScreen extends ConsumerWidget {
//   final String apiUrl = "http://192.168.1.154:8000/viewset/document/";
//
//   Future<List<dynamic>> fetchDocuments() async {
//     var result = await http.get(apiUrl as Uri);
//     return json.decode(result.body)['results'];
//   }
//
//   String _title(dynamic document) {
//     return document['title'];
//   }
//
//   String _type(dynamic document) {
//     return document['type'];
//   }
//
//   String _link(dynamic document) {
//     return document['link'];
//   }
//
//   @override
//   Widget build(BuildContext context, ScopedReader watch) {
//     Future<Document> futureDocument = fetchDocuments() as Future<Document>;
//     double screenHeight = MediaQuery.of(context).size.height;
//     return MaterialApp(
//       home: Scaffold(
//           body: Container(
//               child: Column(
//                 children: [
//                   Text('Documents',
//                       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
//                   FutureBuilder<List<dynamic>>(
//                       future: fetchDocuments(),
//                       builder: (BuildContext context, AsyncSnapshot snapshot) {
//                         if (snapshot.hasData) {
//                           return ListView.builder(
//                               padding: EdgeInsets.all(8),
//                               itemCount: snapshot.data.length,
//                               itemBuilder: (BuildContext context, int index) {
//                                 return ExpansionTile(
//                                   title: Text(_title(snapshot.data[index])),
//                                 );
//                               });
//                         }else {
//                           return Center(child: CircularProgressIndicator());
//                         }
//                       })
//                 ],
//               ))),
//     );
//   }
// }
