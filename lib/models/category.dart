import 'dart:convert';

List<TransCategory> categoriesFromJson(String str) => List<TransCategory>.from(json.decode(str).map((x) => TransCategory.fromJson(x)));

class TransCategory{
  int id;
  String name;
  bool isParent;
  bool isIncome;
  int parentCat = 0;
  TransCategory({required this.id,required this.isIncome,
    required this.isParent, required this.name, parentCat,});

  //Returns an instance of the TransCategory class with given JSON data
  factory TransCategory.fromJson(Map<String, dynamic> json) {
    return TransCategory(
      id: json["id"],
      name: json["name"],
      isParent:json["isParent"],
      isIncome: json["isIncome"],
      parentCat: json["parent_cat_id"]
    );
  }
//Returns a JSON string from the supplied TransCategory instance
Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "isParent": isParent,
    "isIncome": isIncome,
    "parent_cat_id": parentCat
  };
}

class CategoryList{
  List<dynamic> list;
  CategoryList({required this.list});

  factory CategoryList.fromJson(Map<String, dynamic> json) =>
      CategoryList(list: List<TransCategory>.from(json[0].map((x) => TransCategory.fromJson(x))),
  );



}