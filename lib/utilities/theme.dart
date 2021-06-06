import 'package:flutter/material.dart';
import 'constant.dart';

class AppTheme extends ChangeNotifier {
  ThemeData _selectedTheme;

  ThemeData light = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    accentColor: kOffWhite,
    primaryColor: Colors.white,
    cardColor: kOffWhite,
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    buttonColor: kLightPurple,
    shadowColor: Colors.grey.withOpacity(0.8),
    iconTheme: IconThemeData(color: kDarkGrey),

    appBarTheme: AppBarTheme(
      color: Colors.white,
    ),
    textTheme: TextTheme(
      button: TextStyle(
        color: kPurple,
        letterSpacing: 0.05,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
      bodyText1: TextStyle(
        color: kDarkGrey,
        letterSpacing: 0.05,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
      bodyText2: TextStyle(
        color: Color(0XFF777777),
        letterSpacing: 0.05,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: kLightGrey,
    ),
  );

  //static final ThemeData darkTheme = ThemeData(
  ThemeData dark = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.black,
    primaryColor: kBlack,
    accentColor: kBlack1,
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    buttonColor: kPurple,
    cardColor: kBlack,
    shadowColor: Colors.black12.withOpacity(0.8),
    appBarTheme: AppBarTheme(color: Colors.black),
    iconTheme: IconThemeData(color: kOffWhite),
    textTheme: TextTheme(
      button: TextStyle(
        color: kOffWhite,
        letterSpacing: 0.05,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
      bodyText1: TextStyle(
        color: kOffWhite,
        letterSpacing: 0.05,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
      bodyText2: TextStyle(
        color: Color(0XFF777777),
        letterSpacing: 0.05,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: kBlack,
    ),
  );
  AppTheme({bool isDarkTheme}) {
    _selectedTheme = isDarkTheme ? dark : light;
  }

  void swapTheme(bool isDarkMode) {
    _selectedTheme = isDarkMode ? dark : light;
    notifyListeners();
  }

  ThemeData get getTheme => _selectedTheme;
}
