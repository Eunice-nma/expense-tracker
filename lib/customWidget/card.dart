import 'package:expense_tracker/customWidget/dismissibleWidget.dart';
import 'package:expense_tracker/utilities/expenseItem.dart';
import 'package:flutter/material.dart';
import '../utilities/constant.dart';

class ETCard extends StatelessWidget {
 final ExpenseItem expenseItem;
 final int item;
 final DismissDirectionCallback onDismissed;

 ETCard({this.expenseItem, this.item, this.onDismissed});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Card(
        color: kOffWhite,
        child: DismissibleWidget(
          onDismissed: onDismissed,
          item: item,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(expenseItem.expenseName, style: kRegularText,),
                Text('N${expenseItem.expenseCost}', style: kRegularText,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
