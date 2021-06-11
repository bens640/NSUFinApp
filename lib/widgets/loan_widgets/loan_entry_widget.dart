
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nsu_financial_app/main.dart';
import 'package:nsu_financial_app/screens/home_screen.dart';

class LoanEntry extends ConsumerWidget{

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentLoan = watch(loanProvider);
    return Column(
      children: [
        // Text('Loan Calculator', style: TextStyle(
        //   fontSize: 30
        // ),),
        // SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Amount'),
                Container(
                  width: 100,
                  child: TextField(
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    // inputFormatters: [
                    //   FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                    // ],
                    controller: currentLoan.amount,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.blue),
                        hintText: "\$"
                    ),
                  ),
                ),

              ],
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Interest rate'),
                Container(
                  width: 75,
                  child: TextField(
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    controller: currentLoan.interest,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.blue),
                        hintText: "%"
                    ),
                  ),
                ),

              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Term'),
                Container(
                  width: 75,
                  child: TextField(
                    keyboardType: TextInputType.numberWithOptions(decimal: false),
                    controller: currentLoan.term,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.blue),
                        hintText: "Years"
                    ),
                ),
                )
              ],
            ),
          ],
        ),
        SizedBox(height: 20,),
        ElevatedButton(
            onPressed: ()=>{
              // currentLoan.calcAmort(amountController.text,interestController.text,termController.text),
              currentLoan.calcAmort(),
              currentLoan.printAmort()
            },
            child: Text('Calculate'))
      ],
    );

  }
}


