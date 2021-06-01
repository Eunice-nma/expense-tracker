import 'package:flutter/material.dart';
import 'Screens/addExpenses.dart';
import 'Screens/home.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    routes: {
      '/home': (context)=> Home(),
      '/addExpenses': (context)=> AddExpenses(),
    },
  ));
}

