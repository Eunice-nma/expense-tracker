import 'package:expense_tracker/utilities/constant.dart';
import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {
  final Function onPressed;

  EmptyScreen({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 150),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: onPressed,
            elevation: 0,
            fillColor: kLightPurple,
            child: Icon(
              Icons.add,
              color: kPurple,
              size: 50.0,
            ),
            padding: EdgeInsets.all(15.0),
            shape: CircleBorder(),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Looks like you haven\'t added \n any expense',
            style: kRegularText,
            textAlign: TextAlign.center,
          ),
          Text(
            'Tap on the + to add',
            style: kGreyText,
          )
        ],
      ),
    );
  }
}