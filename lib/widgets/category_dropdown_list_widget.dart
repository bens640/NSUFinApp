import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nsu_financial_app/models/category.dart';
import 'package:nsu_financial_app/providers/providers.dart';

import '../network_requests.dart';

class CategoryListDropdown extends StatefulWidget {
  CategoryListDropdown({Key? key, required this.catList, required this.index}) : super(key: key);
  final CategoryList catList;
  int index;
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryListDropdown> {
  @override
  Widget build(BuildContext context) {
    CategoryList catList = widget.catList;
    int dropdownValue = 1;
    return Consumer(
      builder: (context, ref, child){
        // int categoryChoice = ref(categoryChoiceProvider).state.choice;
        final count = ref(categoryChoiceProvider).state;
      return Container(
        child: Center(
          child: DropdownButton(
            value: widget.index,
            items: catList.list.map((item) {

              return new DropdownMenuItem(
                // child: Text('1'),
                child: Text(item['name']),
                value: item['id'],
              );
            }
            ).toList(),
            onChanged: (dynamic newVal) {
              // print(newVal);
              // d.intSelection = d.c.list[newVal]['id'];
              // d.intSelection = newVal;
              widget.index = newVal;
              context.read(categoryChoiceProvider).state = newVal;
              setState(() {
                dropdownValue = newVal;
              });

            },
          ),
        ),
      );
      }
    );
  }
}