import 'package:expense_tracker/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'CustomButton.dart';
import 'dragHandler.dart';

class SlideUpPanel extends StatelessWidget {
  final String total;
  final bool isDay;
  final bool isMonth;
  final bool isWeek;
  final bool isYear;
  final bool isLight;
  final bool isDark;
  final String selectedPeriod;
  final Function dayFunction;
  final Function weekFunction;
  final Function monthFunction;
  final Function yearFunction;
  final Function lightModeFunction;
  final Function darkModeFunction;

  SlideUpPanel(
      {this.total,
      this.isDay,
      this.isMonth,
      this.isWeek,
      this.isYear,
      this.selectedPeriod,
      this.dayFunction,
      this.monthFunction,
      this.weekFunction,
      this.yearFunction,
      this.darkModeFunction,
        this.lightModeFunction,
        this.isLight,
        this.isDark
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      color:Theme.of(context).primaryColor,
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          DragHandler(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Expenses',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    'per $selectedPeriod',
                    style: kGreyText,
                  ),
                ],
              ),
              Text(
                'N$total',
                style: Theme.of(context).textTheme.bodyText1,
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                child: 'Day',
                width: 40,
                onPressed: dayFunction,
                isActive: isDay,
              ),
              CustomButton(
                child: 'Week',
                width: 40,
                onPressed: weekFunction,
                isActive: isWeek,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                child: 'Month',
                width: 40,
                onPressed: monthFunction,
                isActive: isMonth,
              ),
              CustomButton(
                child: 'Year',
                width: 40,
                onPressed: yearFunction,
                isActive: isYear,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),

          Row(
            children: [
              Text('Theme:', style: Theme.of(context).textTheme.bodyText1,),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Theme.of(context).accentColor,
                ),
                // constraints: BoxConstraints(
                //   maxWidth: MediaQuery.of(context).size.width / 100 * 62.5,
                // ),
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomButton(
                      child: 'Light',
                      width: 30,
                      onPressed: lightModeFunction,
                      isActive: isLight,
                    ),
                    CustomButton(
                      child: 'Dark',
                      width: 30,
                      onPressed: darkModeFunction,
                      isActive: isDark,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
