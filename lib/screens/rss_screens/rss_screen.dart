import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:nsu_financial_app/models/rss.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
String rssUrl = 'https://studentloanhero.com/blog/feed';
class RssScreen extends StatefulWidget {


  @override
  _RssScreenState createState() => _RssScreenState();
}

class _RssScreenState extends State<RssScreen> {
  Future<void> _launchInWebViewOrVC(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        enableJavaScript: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void>? _launched;

    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: FutureBuilder(
            future: fetchNews(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<News> _news = snapshot.data as List<News>;
                return ListView.separated(
                  itemBuilder: (context, i) {
                    final News _item = _news[i];
                    String desc = _item.description!;
                    desc = Bidi.stripHtmlIfNeeded(desc);
                    return GestureDetector(
                      onTap: () => setState(() {
                        _launched = _launchInWebViewOrVC(_item.link);
                      }),
                      child: ListTile(
                        title: Text('${_item.title}'),
                        subtitle: Text(
                          '$desc',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, i) => Divider(),
                  itemCount: _news.length,
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Future fetchNews() async {
    final _response = await http.get(Uri.parse(rssUrl));

    if (_response.statusCode == 200) {
      var _decoded = new RssFeed.parse(_response.body);
      return _decoded.items!
          .map((item) => News(
              title: item.title,
              description: item.description,
              link: item.link as String))
          .toList();
    } else {
      throw HttpException('Failed to fetch the data');
    }
  }
}
