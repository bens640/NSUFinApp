

import 'package:flutter/material.dart';
import 'package:nsu_financial_app/models/document.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DocumentList extends StatelessWidget {
  final List<Document> documents;

  DocumentList({Key? key, required this.documents}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(

      body: Column(
        children: [
          Stack(children: [
            Container(
              height: 100,
              // decoration: BoxDecoration(
              //     gradient: LinearGradient(
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              //   colors: [
              //     Color.fromRGBO(10, 36, 99,1),
              //     Color.fromRGBO(176, 212, 232, 1)
              //   ],
              // )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
              child: Center(child: Text(
                'NSU Publications',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600
                ),
              ),),
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
      ),
    );
  }
}