import 'package:expense_tracker/utilities/constant.dart';
import 'package:flutter/material.dart';


class DragHandler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      constraints: BoxConstraints(minWidth: 35.0, maxWidth: 35.0,maxHeight: 4.0, minHeight: 4.0),
    );
  }
}
