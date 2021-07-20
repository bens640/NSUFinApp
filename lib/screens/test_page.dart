// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart';
// import 'package:nsu_financial_app/models/category.dart';
// import 'package:nsu_financial_app/models/document.dart';
// import 'package:nsu_financial_app/network_requests.dart';
// import 'package:nsu_financial_app/screens/document_screens/document_screen.dart';
//
//
// final futureP = FutureProvider<BudgetScreenModel>((ref) async {
//   BudgetScreenModel x = await setBudgetAndCategories();
//   int sel = 0;
//   return x;
// });
//
// final futurePS = FutureProvider<List<dynamic>>((ref) async {
//   BudgetScreenModel x = await setBudgetAndCategories();
//   int sel = 1;
//   return [x, sel];
// });
//
//
// class TestPage extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, ScopedReader watch) {
//     final futures = watch(futureP);
//     final fut = watch(futurePS);
//     // final List<dynamic>catsList = futures.data!.value.c.list;
//     return Scaffold(
//       body: Center(
//         child: fut.when(
//             data: (d) =>
//                 Column(
//                   children: [
//                     // ListView.builder(
//                     //   itemCount: d.b.transactions.length,
//                     //   itemBuilder: (context, index) {
//                     //     return Column(
//                     //       children: [
//                     //         Text(d.b.transactions[index].description),
//                     //         Text('[' + d.c.list[d.b.transactions[index].category -
//                     //             1]['name'] + ']')
//                     //       ],
//                     //     );
//                     //   },
//                     //
//                     // ),
// CategoryList(d: d[0], index: d[1])
//           ]
//         ),
//
//             loading: () => CircularProgressIndicator(),
//             error: (d, s) => Text(s.toString())),
//       ),
//       // body: Text(catsList.list.list.length.toString()),
//       // body: Container(),
//     );
//   }
//
//
// }
//
// class CategoryList extends StatefulWidget {
//   CategoryList({Key? key, required this.d, required this.index}) : super(key: key);
//   final BudgetScreenModel d;
//   int index;
//   @override
//   _CategoryListState createState() => _CategoryListState();
// }
//
// class _CategoryListState extends State<CategoryList> {
//   @override
//   Widget build(BuildContext context) {
//     BudgetScreenModel d = widget.d;
//     int dropdownValue = 1;
//     return Container(
//       child: DropdownButton(
//         value: widget.index,
//         items: d.c.list.map((item) {
//
//           return new DropdownMenuItem(
//             // child: Text('1'),
//             child: Text(item['name']),
//             value: item['id'],
//           );
//         }
//         ).toList(),
//         onChanged: (dynamic newVal) {
//           // print(newVal);
//           // d.intSelection = d.c.list[newVal]['id'];
//           d.intSelection = newVal;
//           widget.index = newVal;
//           setState(() {
//             dropdownValue = newVal;
//           });
//           print(d.c.list.firstWhere((element) => element['id']== newVal));
//         },
//       ),
//     );
//   }
// }
