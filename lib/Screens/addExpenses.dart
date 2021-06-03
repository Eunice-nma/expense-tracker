import 'package:expense_tracker/customWidget/CustomButton.dart';
import 'package:expense_tracker/customWidget/datePicker.dart';
import 'package:expense_tracker/customWidget/textField.dart';
import 'package:expense_tracker/utilities/constant.dart';
import 'package:expense_tracker/customWidget/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'home.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
class AddExpenses extends StatefulWidget {
  @override
  _AddExpensesState createState() => _AddExpensesState();
}

class _AddExpensesState extends State<AddExpenses> {
  //Controllers
  final expenseNameController = TextEditingController();
  final costController = TextEditingController();
  final _dateController = TextEditingController();

  //Number of days the user selects
  double period;
  //Current date for date picker
  DateTime _date = DateTime.now();

  bool isDaily = false;
  bool isMonthly = false;
  bool isFortnightly = false;
  bool isWeekly = false;
  bool isCustom = false;
  bool isButtonDisabled = true;
  bool doneButtonActivated = false;

  //Void function to show pop up model
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
            child: Text(
              'Done',
              style: kPurpleText,
            ),
            onPressed: onClicked,
          ),
        ));
  }

  //Function to activate the done button when all fields has been completed
  doneButtonActivation() {
    //Check to see if any of the text field is empty,
    // if yes, deactivate the done button,
    // if none of the text field is empty,
    // proceed to check if any of the any of the period button is active,
    // if yes, activate the done button,
    // and if none of the period button is active, deactivate the done button.
    if (expenseNameController.text != '' &&
        costController.text != '' &&
        _dateController.text != '') {
      if (isDaily || isCustom || isWeekly || isFortnightly || isMonthly) {
        doneButtonActivated = true;
      } else {
        doneButtonActivated = false;
      }
    } else {
      doneButtonActivated = false;
    }
  }

  //Function to change the color of the active button
  void updateButton(ButtonType buttonType) {
    //Compare the enum assigned to the button clicked to see what button what clicked on,
    //check if the button is already active, deactivate if true,
    // else activate it and deactivate every other button that might be activated.
    //TODO: Try and see if this can be converted to a switch Statement
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
            //Check if the done button is active or not, change the style accordingly
            style: doneButtonActivated ? kRegularText : kGreyText,
          ),
          //check if the done button is active,
          // make the onPressed function null if the button is not active,
          // so it doesn't do anything.
          //pop off the current Screen,
          //and send back a list of Data to the previous Screen if the button is active
          onPressed: doneButtonActivated
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
                onChanged: (val) {
                  setState(() {
                    //Track the value of the text field,
                    // so that the done button can be deactivated if it is empty
                    doneButtonActivation();
                  });
                }),
            CustomTextField(
                placeHolder: 'Cost',
                // textInputFormatter:
                // FilteringTextInputFormatter.singleLineFormatter,
                textInputFormatter: ThousandsFormatter(),
                textInputType: TextInputType.number,
                controller: costController,
                onChanged: (val) {
                  setState(() {
                    //Track the value of the text field,
                    // so that the done button can be deactivated if it is empty
                    doneButtonActivation();
                  });
                }),
            GestureDetector(
              //Make this text field clickable so the date picker can be displayed when it is tapped on
              onTap: () {
                _dateController.text="${DateFormat('d MMMM y').format(_date)}";
                //A popup model that contains the date picker as a child,
                // with a done button to remove the model
                showSheet(context,
                    child: DatePicker(
                      //Set the initial date of the date picker to the current date
                      // or the previous that the user has picked
                      date: _date,
                      onTimeChange: (picked) {
                        setState(() {
                          //Format the date that has been picked
                          // by the user to "day month year" format,
                          // with the month in words and store in a variable
                          var date = "${DateFormat('d MMMM y').format(picked)}";
                          //Set the controller of this field to the formatted date
                          _dateController.text = date;
                          //set selected date to the initial date,
                          // so the date picker will show the selected date first,
                          // when next it's clicked on
                          _date = picked;
                          //Function call to update the active state of the done button
                          doneButtonActivation();
                        });
                      },
                    //Function to remove the pop up model
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
                            //Function call to update button color
                            updateButton(ButtonType.daily);
                            period = 1.0;
                            //Function call to check for the activation of the done button
                            doneButtonActivation();
                          });
                        },
                        child: 'Daily',
                        width: 40,
                        isActive: isDaily,
                      ),
                      CustomButton(
                        onPressed: () {
                          setState(() {
                            //Function call to update button color
                            updateButton(ButtonType.weekly);
                            period = 7.0;
                            //Function call to check for the activation of the done button
                            doneButtonActivation();
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
                            //Function call to update button color
                            updateButton(ButtonType.fortnightly);
                            period = 14.0;
                            //Function call to check for the activation of the done button
                            doneButtonActivation();
                          });
                        },
                        child: 'Fortnightly',
                        width: 40,
                        isActive: isFortnightly,
                      ),
                      CustomButton(
                        onPressed: () {
                          setState(() {
                            //Function call to update button color
                            updateButton(ButtonType.monthly);
                            period = 30.4;
                            //Function call to check for the activation of the done button
                            doneButtonActivation();
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
                        //Function call to update button color
                        updateButton(ButtonType.custom);
                        //Function call to check for the activation of the done button
                        doneButtonActivation();
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
}


