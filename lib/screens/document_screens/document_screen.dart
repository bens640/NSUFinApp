import 'dart:async';
import 'dart:io';

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nsu_financial_app/models/document.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../main.dart';
import '../../network_requests.dart';



class DocumentScreen extends StatefulWidget {
  DocumentScreen({Key? key}) : super(key: key);

  @override
  _DocumentScreenState createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Document>>(
        future: fetchDocument(),
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
    return Column(
      children: [
        Stack(children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(10, 36, 99,1),
                Colors.white,
              ],
            )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
            child: Center(child: Text('NSU Documents')),
          )
        ]),
        Expanded(
          child: ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              return ExpansionTile(
                expandedAlignment: Alignment.center,
                title: Text(documents[index].title),
                children: [
                  // Text(documents[index].link),
                  Container(
                    height: screenHeight * .80,
                    child: documents[index].type == 'PDF'
                        ? SfPdfViewer.network(
                        documents[index].link,
                    canShowScrollHead: true,
                    canShowPaginationDialog: false,)
                        : InteractiveViewer(
                      panEnabled: true,

                            child: WebView(initialUrl: documents[index].link, )),

                    // child:Text(documents[index].link)
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
