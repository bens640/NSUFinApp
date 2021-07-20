import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:nsu_financial_app/models/rss.dart';
import 'package:webfeed/domain/rss_feed.dart';

import 'package:http/http.dart' as http;

class RssScreen extends StatelessWidget {
  static String rssUrl = 'https://studentloanhero.com/blog/feed';
  @override
  Widget build(BuildContext context) {
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
                    return ListTile(

                      title: Text('${_item.title}'),
                      subtitle: Text(
                        '$desc',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
      ))
          .toList();
    } else {
      throw HttpException('Failed to fetch the data');
    }
  }
}