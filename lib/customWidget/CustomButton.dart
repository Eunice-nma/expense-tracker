import 'package:expense_tracker/utilities/constant.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final String child;
  final int width;
  final bool isActive;

  CustomButton({this.child, this.onPressed, this.width, this.isActive});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width / 100 * width,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 15,
      ),
      child: Text(
        child,
        style: isActive ? kPurpleText : kRegularText,
      ),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      fillColor: isActive ? kLightPurple : kLightGrey,
      onPressed: onPressed,
    );
  }
}