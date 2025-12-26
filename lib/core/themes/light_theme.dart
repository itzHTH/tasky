import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Color(0xFFF6F7F9),
  useMaterial3: true,
  colorScheme: ColorScheme.light(
    primaryContainer: Color(0xffffffff),
    secondary: Color(0xff161F1B),
  ),
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: Color(0xff161F1B)),
    titleTextStyle: TextStyle(
      color: Color(0xff161F1B),
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    centerTitle: false,
  ),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xff15B86C);
      }
      return Color(0xFFFFFFFF);
    }),
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      }
      return Color(0xFF9E9E9E);
    }),

    trackOutlineColor: WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.transparent;
      }
      return Color(0xFF9E9E9E);
    }),

    trackOutlineWidth: WidgetStatePropertyAll(2),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0Xff15B86C),
      foregroundColor: Colors.white,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Color(0xFF161F1B),
      textStyle: TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
    ),
  ),

  textTheme: TextTheme(
    displaySmall: TextStyle(
      fontSize: 24,
      color: Color(0xFF161F1B),
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      color: Color(0xFF161F1B),
      fontWeight: FontWeight.w400,
    ),
    displayLarge: TextStyle(
      fontSize: 32,
      color: Color(0xFF161F1B),
      fontWeight: FontWeight.w400,
    ),

    labelMedium: TextStyle(
      fontSize: 18,
      color: Color(0xFF161F1B),
      fontWeight: FontWeight.w400,
    ),

    titleSmall: TextStyle(
      fontSize: 16,
      color: Color(0xFF161F1B),
      fontWeight: FontWeight.w400,
    ),

    // for unDone Tasks name
    titleMedium: TextStyle(
      fontSize: 16,
      color: Color(0xff161F1B),
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.none,
      decorationColor: Color(0xff161F1B),
      overflow: TextOverflow.ellipsis,
    ),

    // for Done Tasks Name
    titleLarge: TextStyle(
      fontSize: 16,
      color: Color(0xff6A6A6A),
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xff6A6A6A),
      overflow: TextOverflow.ellipsis,
    ),

    // for done Task Desdc
    labelSmall: TextStyle(
      fontSize: 14,
      color: Color(0xff3A4640),
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.none,
      overflow: TextOverflow.ellipsis,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xffD1DAD6), width: 1),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.red, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xffD1DAD6), width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xffD1DAD6), width: 1),
    ),
    focusColor: Color(0xffD1DAD6),
    hintStyle: TextStyle(color: Color(0xff9E9E9E), fontWeight: FontWeight.w400),

    filled: true,
    fillColor: Colors.white,
  ),

  checkboxTheme: CheckboxThemeData(side: BorderSide(color: Color(0xffD1DAD6))),

  iconTheme: IconThemeData(color: Color(0xFF161F1B)),

  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      fontSize: 16,
      color: Color(0xFF161F1B),
      fontWeight: FontWeight.w400,
    ),
  ),

  dividerTheme: DividerThemeData(color: Color(0xFFD1DAD6)),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Color(0xFF14A662),
    unselectedItemColor: Color(0xFF3A4640),
  ),

  splashFactory: NoSplash.splashFactory,

  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xFFF6F7F9),

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
    shadowColor: Color(0xff15B86C),
    elevation: 2,
    labelTextStyle: WidgetStatePropertyAll(
      TextStyle(
        fontSize: 18,
        color: Color(0xFF161F1B),
        fontWeight: FontWeight.w400,
      ),
    ),
  ),
);
