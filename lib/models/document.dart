
class Document{
  String title;
  String type;
  String link;

  Document({required this.title,required  this.type,required  this.link});

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
        title: json['title'],
        type: json['type'],
        link: json['link'],
    );
  }
}