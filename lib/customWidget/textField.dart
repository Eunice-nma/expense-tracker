import 'package:expense_tracker/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CustomTextField extends StatelessWidget {
  final String placeHolder;
  final TextInputType textInputType;
  final TextInputFormatter textInputFormatter;
  final String label;
  final TextEditingController controller;
  final bool enabled;
  final Function onChanged;


  CustomTextField({this.placeHolder, this.textInputType, this.textInputFormatter, this.label, this.controller, this.enabled, this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: TextFormField(
        onChanged: onChanged,
        enabled: enabled,
        controller: controller,
        inputFormatters: [textInputFormatter],
        keyboardType: textInputType,
        cursorColor: kDarkGrey,
        decoration: InputDecoration(
          // labelText: label,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          filled: true,
          hintText: placeHolder,
          hintStyle: kLightText,
          fillColor: kLightGrey,
        ),
      ),
    );
  }
}