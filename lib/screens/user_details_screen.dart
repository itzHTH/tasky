import 'package:flutter/material.dart';
import 'package:tasky/core/widgets/custom_text_form_filed_widget.dart';
import 'package:tasky/core/services/shard_pers.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  late String _fullname;
  late String _movQuote;
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _movQuoteController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();

  void _loadUserDetails() {
    setState(() {
      _fullname =
          SharedPrefsHelper.instance.getStringValue("fullname") ?? "Guset";
      _movQuote =
          SharedPrefsHelper.instance.getStringValue("movQuote") ??
          "One task at a time. One step closer.";

      _fullNameController.value = TextEditingValue(text: _fullname);
      _movQuoteController.value = TextEditingValue(text: _movQuote);
    });
  }

  Future<bool> _saveUserDetails(String fullname, String movQuote) async {
    return (await SharedPrefsHelper.instance.setStringValue(
              "fullname",
              fullname,
            ) ??
            false) &&
        (await SharedPrefsHelper.instance.setStringValue(
              "movQuote",
              movQuote,
            ) ??
            false);
  }

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Details")),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Form(
                    key: _key,
                    child: Column(
                      children: [
                        CustomTextFormFiledWidget(
                          title: "Full Name",
                          hintText: "e.g. Sarah Khilad",
                          controllor: _fullNameController,
                          formValidator: (value) {
                            if (value?.trim().isEmpty ?? false) {
                              return "Please Enter Your Full Name !.";
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 16),
                        CustomTextFormFiledWidget(
                          title: "Motivation Quote",
                          hintText: "e.g. One task at a time. One step closer.",
                          controllor: _movQuoteController,
                          formValidator: (value) {
                            if (value?.trim().isEmpty ?? false) {
                              return "Please Enter Your Motivation Quote !.";
                            }
                            return null;
                          },
                          maxLine: 6,
                        ),
                        Spacer(),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(
                              MediaQuery.of(context).size.width,
                              40,
                            ),
                          ),
                          onPressed: () async {
                            if (_key.currentState!.validate()) {
                              if (await _saveUserDetails(
                                _fullNameController.text,
                                _movQuoteController.text,
                              )) {
                                Navigator.pop(context, true);
                              }
                            }
                          },
                          child: Text("Save Changes"),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
