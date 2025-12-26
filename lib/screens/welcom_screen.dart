import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/core/widgets/custom_text_form_filed_widget.dart';
import 'package:tasky/screens/%20main_screen.dart';
import 'package:tasky/core/services/shard_pers.dart';

class WelcomScreen extends StatelessWidget {
  WelcomScreen({super.key});

  final TextEditingController txtControllor = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/logo.svg",
                        height: 42,
                        width: 42,
                      ),
                      SizedBox(width: 16),
                      Text(
                        "Tasky",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 116),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome To Tasky",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      SizedBox(width: 8),
                      SvgPicture.asset(
                        "assets/images/waving-hanhsvg.svg",
                        width: 28,
                        height: 28,
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Your productivity journey starts here.",
                    style: Theme.of(
                      context,
                    ).textTheme.displayMedium!.copyWith(fontSize: 16),
                  ),
                  SizedBox(height: 24),
                  SvgPicture.asset(
                    "assets/images/pana.svg",
                    height: 204,
                    width: 215,
                  ),
                  SizedBox(height: 28),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        CustomTextFormFiledWidget(
                          title: "Full Name",
                          hintText: "e.g. Sarah Khalid",
                          controllor: txtControllor,
                          formValidator: (value) {
                            if (value?.trim().isEmpty ?? false) {
                              return "Please Enter Your Full Name !.";
                            }

                            return null;
                          },
                          maxLine: 1,
                        ),
                        SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            if (_key.currentState?.validate() ?? false) {
                              SharedPrefsHelper.instance.setStringValue(
                                "fullname",
                                txtControllor.text.trim(),
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return MainScreen();
                                  },
                                ),
                              );
                            }
                          },
                          style: Theme.of(context).elevatedButtonTheme.style!
                              .copyWith(
                                fixedSize: WidgetStatePropertyAll(
                                  Size(MediaQuery.widthOf(context), 40),
                                ),
                              ),

                          child: Text("Let’s Get Started"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
