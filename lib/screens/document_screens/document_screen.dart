import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nsu_financial_app/models/document.dart';
import 'package:nsu_financial_app/widgets/base_widgets/top_app_bar_widget.dart';
import 'package:nsu_financial_app/widgets/base_widgets/bottom_app_bar_widget.dart';
import 'package:nsu_financial_app/widgets/documents_widget/document_list_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';
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

      appBar: TopAppBar(),
      bottomNavigationBar: BottomBaseBar(),
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
