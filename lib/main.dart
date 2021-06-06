import 'package:expense_tracker/utilities/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Screens/addExpenses.dart';
import 'Screens/home.dart';

// void main() {
//   runApp(MaterialApp(
//     home: Home(),
//     routes: {
//       '/home': (context)=> Home(),
//       '/addExpenses': (context)=> AddExpenses(),
//     },
//   ));
// }

void main() {
  runApp(ChangeNotifierProvider(
    child: MyApp(),
    create: (BuildContext context) => AppTheme(isDarkTheme: true),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppTheme>(
      builder: (context, appTheme, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: appTheme.getTheme,
          home: Home(),
          routes: {
            '/home': (context) => Home(),
            '/addExpenses': (context) => AddExpenses(),
          },
        );
      },
    );
  }
}
