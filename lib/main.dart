import 'package:flutter/material.dart';
import 'package:tasky/core/services/theme_controller.dart';
import 'package:tasky/core/themes/dark_theme.dart';
import 'package:tasky/core/themes/light_theme.dart';
import 'package:tasky/screens/%20main_screen.dart';
import 'package:tasky/screens/welcom_screen.dart';
import 'package:tasky/core/services/shard_pers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPrefsHelper.initShared();
  ThemeController.init();
  runApp(const Tasky());
}

class Tasky extends StatelessWidget {
  const Tasky({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ThemeController.themeValueNotifier,
      builder: (context, value, child) {
        return MaterialApp(
          title: 'Tasky',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeController.themeValueNotifier.value,
          home: SharedPrefsHelper.instance.getStringValue("fullname") == null
              ? WelcomScreen()
              : MainScreen(),
        );
      },
    );
  }
}
