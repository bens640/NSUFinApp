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


  factory TransCategory.fromJson(Map<String, dynamic> json) {
    return TransCategory(
      id: json["id"],
      name: json["name"],
      isParent:json["isParent"],
      isIncome: json["isIncome"],
      parentCat: json["parent_cat_id"]
    );
  }

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
  // factory CategoryList.fromJson(Map<String, dynamic> json) {
  //   return CategoryList(
  //     list: List<TransCategory>.from(json.map((x) => TransCategory.fromJson(x))),
  //   );
  // }
  factory CategoryList.fromJson(Map<String, dynamic> json) =>
      CategoryList(list: List<TransCategory>.from(json[0].map((x) => TransCategory.fromJson(x))),
  );



}