import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: Color(0xff181818),
  useMaterial3: true,
  colorScheme: ColorScheme.dark(
    primaryContainer: Color(0xff282828),
    secondary: Color(0xffFFFCFC),
  ),
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xff181818),
    iconTheme: IconThemeData(color: Color(0xffFFFCFC)),
    titleTextStyle: TextStyle(
      color: Color(0xffFFFCFC),
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
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0Xff15B86C),
      foregroundColor: Colors.white,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Color(0xFFFFFFFF),
      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
    ),
  ),

  textTheme: TextTheme(
    displaySmall: TextStyle(
      fontSize: 24,
      color: Color(0xFFFFFFFF),
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      color: Color(0xFFFFFFFF),
      fontWeight: FontWeight.w400,
    ),
    displayLarge: TextStyle(
      fontSize: 32,
      color: Color(0xFFFFFFFF),
      fontWeight: FontWeight.w400,
    ),

    labelMedium: TextStyle(
      fontSize: 18,
      color: Color(0xFFFFFFFF),
      fontWeight: FontWeight.w400,
    ),

    titleSmall: TextStyle(
      fontSize: 16,
      color: Color(0xFFFFFFFF),
      fontWeight: FontWeight.w400,
    ),

    // for unDone Tasks name
    titleMedium: TextStyle(
      fontSize: 16,
      color: Color(0xffFFFCFC),
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.none,
      overflow: TextOverflow.ellipsis,
    ),

    // for Done Tasks Name
    titleLarge: TextStyle(
      fontSize: 16,
      color: Color(0xffA0A0A0),
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.none,
      decorationColor: Color(0xff49454F),
      overflow: TextOverflow.ellipsis,
    ),

    // for done Task Desdc
    labelSmall: TextStyle(
      fontSize: 14,
      color: Color(0xffC6C6C6),
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.none,
      overflow: TextOverflow.ellipsis,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.red, width: 1),
    ),
    hintStyle: TextStyle(
      fontSize: 18,
      color: Color(0xff9E9E9E),
      fontWeight: FontWeight.w400,
    ),
    filled: true,
    fillColor: Color(0xff282828),
  ),

  checkboxTheme: CheckboxThemeData(side: BorderSide(color: Color(0xff6E6E6E))),

  iconTheme: IconThemeData(color: Color(0xFFFFFCFC)),

  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      fontSize: 16,
      color: Color(0xFFFFFFFF),
      fontWeight: FontWeight.w400,
    ),
  ),

  dividerTheme: DividerThemeData(color: Color(0xFF6E6E6E)),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Color(0xff15B86C),
    unselectedItemColor: Color(0xffC6C6C6),
  ),

  splashFactory: NoSplash.splashFactory,

  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xff181818),

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      side: BorderSide(color: Color(0xff15B86C), width: 1),
    ),
    shadowColor: Color(0xff15B86C),
    elevation: 2,
    labelTextStyle: WidgetStatePropertyAll(
      TextStyle(
        fontSize: 18,
        color: Color(0xffFFFCFC),
        fontWeight: FontWeight.w400,
      ),
    ),
  ),
);
