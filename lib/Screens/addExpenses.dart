import 'package:expense_tracker/customWidget/CustomButton.dart';
import 'package:expense_tracker/customWidget/textField.dart';
import 'package:expense_tracker/utilities/constant.dart';
import 'package:expense_tracker/customWidget/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AddExpenses extends StatefulWidget {
  @override
  _AddExpensesState createState() => _AddExpensesState();
}

class _AddExpensesState extends State<AddExpenses> {
  final expenseNameController = TextEditingController();
  final costController = TextEditingController();
  final _dateController = TextEditingController();
  double period;

  DateTime _date = DateTime.now();

  bool isDaily = false;
  bool isMonthly = false;
  bool isFortnightly = false;
  bool isWeekly = false;
  bool isCustom = false;
  bool isButtonDisabled = true;

  void updateButton(ButtonType buttonType) {
    if (buttonType == ButtonType.daily) {
      if (isDaily) {
        isDaily = false;
      } else {
        isDaily = true;
        isMonthly = false;
        isFortnightly = false;
        isWeekly = false;
        isCustom = false;
      }
    } else if (buttonType == ButtonType.weekly) {
      if (isWeekly) {
        isWeekly = false;
      } else {
        isWeekly = true;
        isDaily = false;
        isMonthly = false;
        isFortnightly = false;
        isCustom = false;
      }
    } else if (buttonType == ButtonType.monthly) {
      if (isMonthly) {
        isMonthly = false;
      } else {
        isMonthly = true;
        isDaily = false;
        isFortnightly = false;
        isWeekly = false;
        isCustom = false;
      }
    } else if (buttonType == ButtonType.fortnightly) {
      if (isFortnightly) {
        isFortnightly = false;
      } else {
        isFortnightly = true;
        isDaily = false;
        isMonthly = false;
        isWeekly = false;
        isCustom = false;
      }
    } else if (buttonType == ButtonType.custom) {
      if (isCustom) {
        isCustom = false;
      } else {
        isCustom = true;
        isDaily = false;
        isMonthly = false;
        isFortnightly = false;
        isWeekly = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ETAppBar(
        action: TextButton(
          child: Text(
            'done',
            style: kRegularText,
          ),
          onPressed: expenseNameController.text != '' &&
                      costController.text != '' &&
                      isDaily ||
                  isCustom ||
                  isCustom ||
                  isWeekly ||
                  isFortnightly ||
                  isMonthly
              ? () {
                  Navigator.pop(context, [
                    expenseNameController.text,
                    costController.text,
                    period
                  ]);
                }
              : null,
        ),
        title: 'New Expenses',
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(24, 20, 24, 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              placeHolder: 'Expense Name',
              textInputFormatter:
                  FilteringTextInputFormatter.singleLineFormatter,
              textInputType: TextInputType.text,
              controller: expenseNameController,
            ),
            CustomTextField(
              placeHolder: 'Cost',
              textInputFormatter: FilteringTextInputFormatter.digitsOnly,
              textInputType: TextInputType.number,
              controller: costController,
            ),
            GestureDetector(
              onTap: () {
                showSheet(context,
                    child: DatePicker(
                      date: _date,
                      onTimeChange: (picked) {
                            setState(() {
                              var date =
                                  "${DateFormat('d MMMM y').format(picked)}";
                              _dateController.text = date;
                              _date = picked;
                            });

                      },
                    ), onClicked: () {
                  Navigator.pop(context);
                });
              },
              child: CustomTextField(
                enabled: false,
                placeHolder: 'Last Billing Date',
                textInputFormatter:
                    FilteringTextInputFormatter.singleLineFormatter,
                textInputType: TextInputType.datetime,
                controller: _dateController,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choose a Billing period',
                    style: kLightText,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        onPressed: () {
                          setState(() {
                            updateButton(ButtonType.daily);
                            period = 1.0;
                          });
                        },
                        child: 'Daily',
                        width: 40,
                        isActive: isDaily,
                      ),
                      CustomButton(
                        onPressed: () {
                          setState(() {
                            updateButton(ButtonType.weekly);
                            period = 7.0;
                          });
                        },
                        child: 'Weekly',
                        width: 40,
                        isActive: isWeekly,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        onPressed: () {
                          setState(() {
                            updateButton(ButtonType.fortnightly);
                            period = 14.0;
                          });
                        },
                        child: 'Fortnightly',
                        width: 40,
                        isActive: isFortnightly,
                      ),
                      CustomButton(
                        onPressed: () {
                          updateButton(ButtonType.monthly);
                          setState(() {
                            period = 30.4;
                          });
                        },
                        child: 'Monthly',
                        width: 40,
                        isActive: isMonthly,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  CustomButton(
                    onPressed: () {
                      setState(() {
                        updateButton(ButtonType.custom);
                      });
                    },
                    child: 'Custom Period',
                    width: 100,
                    isActive: isCustom,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void showSheet(
    BuildContext context, {
    Widget child,
    VoidCallback onClicked,
  }) {
    showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
              actions: [child],
              cancelButton: CupertinoActionSheetAction(
                child: Text('Done', style: kPurpleText,),
                onPressed: onClicked,
              ),
            ));
  }
}

enum ButtonType { daily, monthly, fortnightly, weekly, custom, year }

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
          maximumDate: date,
          minimumYear: 1999,
        ),
      ),
    );
  }
}
