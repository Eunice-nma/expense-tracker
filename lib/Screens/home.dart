import 'package:expense_tracker/customWidget/emptyScreen.dart';
import 'package:expense_tracker/customWidget/slideUpPanel.dart';
import 'package:expense_tracker/utilities/expenseItem.dart';
import 'package:expense_tracker/Screens/addExpenses.dart';
import 'package:expense_tracker/utilities/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../customWidget/appbar.dart';
import '../customWidget/card.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:intl/intl.dart';

enum ButtonType { daily, monthly, fortnightly, weekly, custom, year }
enum Theme { light, dark }

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //List of object for each item
  List<ExpenseItem> expenseItems = [];
  //List of all the day of each item
  List perDay = [];
  //Sum of all the days in each item
  double daySum = 0;
  //Total value to be displayed
  double total = 0;
  //Selected period to be displayed, set to day,
  //so that the default is on day
  //until the user selects another period
  String selectedPeriod = 'Day';
  //Booleans to check what button is currently active,
  //and the day button set to true
  //so that the default active button is day
  //until the user selects another button
  bool isDay = true;
  bool isMonth = false;
  bool isYear = false;
  bool isWeek = false;
  bool isLight = false;
  bool isDark = true;
  bool isDarkModeOn = true;

  //Format numbers to put commas in the appropriate places
  var formatter = NumberFormat('###,###,##0.00');

  //Function to update the current active button based on what was clicked on
  void updateButton(ButtonType buttonType) {
    //Check what button was clicked on and make its boolean true,
    //even if it was true before, so that a button is always active
    if (buttonType == ButtonType.daily) {
      isDay = true;
      isMonth = false;
      isYear = false;
      isWeek = false;
    } else if (buttonType == ButtonType.weekly) {
      isWeek = true;
      isDay = false;
      isMonth = false;
      isYear = false;
    } else if (buttonType == ButtonType.monthly) {
      isMonth = true;
      isDay = false;
      isYear = false;
      isWeek = false;
    } else if (buttonType == ButtonType.year) {
      isYear = true;
      isDay = false;
      isMonth = false;
      isWeek = false;
    }
  }

  //Check what button is active and calculate the total accordingly
  void checkActiveButton() {
    if (isDay) {
      total = daySum;
      selectedPeriod = "Day";
      print("Day: $selectedPeriod");
    } else if (isWeek) {
      total = daySum * 7;
      selectedPeriod = "Week";
      print("week: $selectedPeriod");
    } else if (isMonth) {
      total = daySum * (365 / 12);
      selectedPeriod = "Month";
      print("Month: $selectedPeriod");
    } else if (isYear) {
      total = daySum * 365;
      selectedPeriod = "Year";
      print("year: $selectedPeriod");
    }
  }

  //Function to check what button is active,
  //calculate the total and change the period Text accordingly
  void buttonFunctions(ButtonType buttonType) {
    setState(() {
      updateButton(buttonType);
      checkActiveButton();
    });
  }

  //Function to check what theme button was pressed by
  //comparing it with the enums and updating the theme accordingly
  updateTheme(Theme themeButton) {
    AppTheme appTheme = Provider.of<AppTheme>(context, listen: false);
    setState(() {
      if (themeButton == Theme.dark) {
        isDarkModeOn = true;
        isDark = true;
        isLight = false;
      } else if (themeButton == Theme.light) {
        isDarkModeOn = false;
        isLight = true;
        isDark = false;
      }
    });
    appTheme.swapTheme(isDarkModeOn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: ETAppBar(
        action: IconButton(
          icon: Icon(
            Icons.add,
          ),
          onPressed: () {
            //An async Function that pushes to the next page and wait for values
            _awaitReturnValueFromSecondScreen(context);
          },
        ),
        title: 'Expenses',
      ),
      body: SlidingUpPanel(
        minHeight: 90,
        maxHeight: 380,
        borderRadius: BorderRadius.circular(20),
        panel: SlideUpPanel(
          selectedPeriod: selectedPeriod,
          total: formatter.format(total),
          isDay: isDay,
          isMonth: isMonth,
          isWeek: isWeek,
          isYear: isYear,
          isLight: isLight,
          isDark: isDark,
          lightModeFunction: () {
            updateTheme(Theme.light);
          },
          darkModeFunction: () {
            updateTheme(Theme.dark);
          },
          dayFunction: () {
            buttonFunctions(ButtonType.daily);
          },
          weekFunction: () {
            buttonFunctions(ButtonType.weekly);
          },
          monthFunction: () {
            buttonFunctions(ButtonType.monthly);
          },
          yearFunction: () {
            buttonFunctions(ButtonType.year);
          },
        ),
        //Ternary operator to check if the expenseItem list is empty
        body: expenseItems.length == 0
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
                    //Function to remove item from the list and subtract its amount from the total
                    onDismissed: (direction) {
                      setState(() {
                        expenseItems.removeAt(i);
                        daySum -= perDay[i];
                        checkActiveButton();
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
    // start the secondScreen and wait for it to finish with a list of data(retrievedItemsList)
    final retrievedItemList = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddExpenses(),
        ));
    //Function to run when the second screen is finished
    setState(
      () {
        //storing the items received
        var expenseName = retrievedItemList[0];
        var daysNumber = retrievedItemList[2];
        //Remove the commas if any, from the Cost item
        var expenseCost = "${retrievedItemList[1].replaceAll(',', '')}";
        //Calculate the amount per day
        //by converting the cost item to a double
        //and dividing it by the amount of days the user has selected
        double amountPerDay = double.parse(expenseCost) / daysNumber;
        //Add amount per day to the perDay list, so the sum of all the amount per days can be gotten
        perDay.add(amountPerDay);
        //Get the sum of all amount per day
        daySum += amountPerDay;
        //Check what period button is active and calculate the total value accordingly
        checkActiveButton();
        //Add items to the expense list so it can be display
        expenseItems.add(
          ExpenseItem(
            expenseName: expenseName,
            expenseCost: int.parse(expenseCost),
            amountPerDay: amountPerDay,
          ),
        );
      },
    );
  }
}
