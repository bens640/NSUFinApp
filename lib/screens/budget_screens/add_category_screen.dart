import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nsu_financial_app/models/category.dart';
import 'package:http/http.dart' as http;
import 'package:nsu_financial_app/providers/providers.dart';
import '../../main.dart';
import '../../network_requests.dart';

class AddTransactionWidget extends ConsumerWidget {
  const AddTransactionWidget({Key? key}) : super(key: key);

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Cant be empty'),
      ),
    );
  }

  showOverlay(BuildContext context) async {
    final textController = TextEditingController();
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry entry;

    entry = OverlayEntry(
        opaque: true,
        builder: (context) => Material(
              child: Center(
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                    child: Column(
                      children: [
                        Text(
                          'Add a new category',
                          style: TextStyle(fontSize: 30),
                        ),
                        Text('Name of category'),
                        TextField(
                          controller: textController,
                        ),
                        // Text('Is this category income?', style: TextStyle(
                        //     fontSize: 20
                        // ),
                        // ),
                        // Checkbox(value: context.read(newCategoryProvider).category.isIncome,
                        //   onChanged: (value) => context.read(newCategoryProvider).category.isIncome = value!,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                onPressed: () => {}, child: Text('Cancel')),
                            ElevatedButton(
                                onPressed: () => {
                                      if (textController.text == '')
                                        {_showToast(context)}
                                      else
                                        {
                                          setBudgetAndCategories(),
                                          context
                                                  .read(newCategoryProvider).category.name =
                                              toBeginningOfSentenceCase(textController.text)!,
                                          postCategory(context.read(newCategoryProvider).category)
                                          // print(context.read(newCategoryProvider).category.name),
                                          // print(context.read(newCategoryProvider).category.isIncome)
                                        },
                                    },
                                child: Text('Add')),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));

    overlayState!.insert(entry);
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 800,
          decoration: BoxDecoration(color: Colors.red),
          child: Column(
            children: [
              Text(
                'Add category!',
                style: TextStyle(fontSize: 50),
              ),
              ElevatedButton(
                  onPressed: () => showOverlay(context),
                  child: Text('Click Me'))
            ],
          ),
        ),
      ),
    );
  }
}
