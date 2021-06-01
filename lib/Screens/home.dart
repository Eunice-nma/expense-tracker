import 'package:expense_tracker/customWidget/emptyScreen.dart';
import 'package:expense_tracker/customWidget/slideUpPanel.dart';
import 'package:expense_tracker/utilities/expenseItem.dart';
import 'package:expense_tracker/Screens/addExpenses.dart';
import 'package:flutter/material.dart';
import '../customWidget/appbar.dart';
import '../customWidget/card.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

bool isDay = false;
bool isMonth = false;
bool isYear = false;
bool isWeek = false;

class _HomeState extends State<Home> {
  List<ExpenseItem> expenseItems = [];
  //initial value of the total variable that will be displayed
  double daySum = 0;
  List perDay = [];
  double total = 0;
  bool isActive = false;
  String selectedPeriod = 'Day';


  void updateButton(ButtonType buttonType) {
    if (buttonType == ButtonType.daily) {
      if (isDay) {
        isDay = false;
      } else {
        isDay = true;
        isMonth = false;
        isYear = false;
        isWeek = false;
      }
    } else if (buttonType == ButtonType.weekly) {
      if (isWeek) {
        isWeek = false;
      } else {
        isWeek = true;
        isDay = false;
        isMonth = false;
        isYear = false;
      }
    } else if (buttonType == ButtonType.monthly) {
      if (isMonth) {
        isMonth = false;
      } else {
        isMonth = true;
        isDay = false;
        isYear = false;
        isWeek = false;
      }
    } else if (buttonType == ButtonType.year) {
      if (isYear) {
        isYear = false;
      } else {
        isYear = true;
        isDay = false;
        isMonth = false;
        isWeek = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ETAppBar(
        action: IconButton(
          icon: Icon(
            Icons.add,
          ),
          onPressed: () {
            _awaitReturnValueFromSecondScreen(context);
          },
        ),
        title: 'Expenses',
      ),
      //Ternary operator to check if the expenseItem list is empty
      body: SlidingUpPanel(
        minHeight: 90,
        borderRadius: BorderRadius.circular(20),
        panel: SlideUpPanel(
          selectedPeriod: selectedPeriod,
          total: total.toStringAsFixed(2),
          isDay: isDay,
          isMonth: isMonth,
          isWeek: isWeek,
          isYear: isYear,
          dayFunction: () {
            setState(() {
              updateButton(ButtonType.daily);
              selectedPeriod = 'day';
              total = daySum;
            });
          },
          weekFunction: () {
            setState(() {
              updateButton(ButtonType.weekly);
              selectedPeriod = 'week';
              total = daySum * 7;
            });
          },
          monthFunction: () {
            setState(() {
              updateButton(ButtonType.monthly);
              selectedPeriod = 'month';
              total = daySum * 30.416;
            });
          },
          yearFunction: () {
            setState(() {
              updateButton(ButtonType.year);
              selectedPeriod = 'year';
              total = daySum * 365;
            });
          },
        ),
        body: expenseItems.length == 0
            //Displays instructions if expenseItems list is empty
            ? Center(
                child: EmptyScreen(
                  onPressed: () {
                    _awaitReturnValueFromSecondScreen(context);
                  },
                ),
              )
            //Or display list view of array
            : ListView.builder(
                itemCount: expenseItems.length,
                itemBuilder: (context, i) {
                  return ETCard(
                    expenseItem: expenseItems[i],
                    item: i,
                    onDismissed: (direction) {
                      setState(() {
                        expenseItems.removeAt(i);
                        daySum -= perDay[i];
                        total = daySum;
                        perDay.removeAt(i);
                      });
                    },
                  );
                }),
      ),
    );
  }

  //An asynchronous function that waits for value from the AddExpense screen
  void _awaitReturnValueFromSecondScreen(BuildContext context) async {
    // start the SecondScreen and wait for it to finish with a result
    final retrievedItemList = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddExpenses(),
        ));
    setState(
      () {
        //Calculate the amount per day
        double amountPerDay =
            int.parse(retrievedItemList[1]) / retrievedItemList[2];
        //Add number of days to the perDay list, so the sum of all the amount per days can be gotten
        perDay.add(amountPerDay);
        //Get the sum of all amount per day
        daySum += amountPerDay;
        // Todo: switch statement to check what period button is active and display correct total
        //Todo: for now, the sum will be displayed, giving the illusion that the day button is active
        total = daySum;
        //Add items to the perDay list, so the sum of the list can be gotten
        expenseItems.add(
          ExpenseItem(
            expenseName: retrievedItemList[0],
            expenseCost: int.parse(retrievedItemList[1]),
            //Get the amount per day by dividing the amount by the number of days
            amountPerDay: amountPerDay,
          ),
        );
      },
    );
  }
}
