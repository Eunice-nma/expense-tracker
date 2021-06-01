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
  final String selectedPeriod;
  final Function dayFunction;
  final Function weekFunction;
  final Function monthFunction;
  final Function yearFunction;

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
      this.yearFunction});
  @override
  Widget build(BuildContext context) {
    return Container(
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
                    style: kRegularText,
                  ),
                  Text(
                    'per $selectedPeriod',
                    style: kGreyText,
                  ),
                ],
              ),
              Text(
                'N$total',
                style: kRegularText,
              )
            ],
          ),
          SizedBox(
            height: 20,
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
        ],
      ),
    );
  }
}
