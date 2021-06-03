import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatePicker extends StatelessWidget {
  final DateTime date;
  final Function onTimeChange;

  DatePicker({this.date, this.onTimeChange});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        height: 200,
        child: CupertinoDatePicker(
          initialDateTime: date,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: onTimeChange,
          maximumDate: DateTime.now(),
          minimumYear: 1999,
        ),
      ),
    );
  }
}