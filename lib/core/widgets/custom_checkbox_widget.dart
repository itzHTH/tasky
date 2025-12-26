import 'package:flutter/material.dart';

class CustomCheckboxWidget extends StatelessWidget {
  const CustomCheckboxWidget({
    super.key,
    required this.value,
    required this.onChecked,
  });

  final bool? value;

  final Function(bool? value) onChecked;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: (value) async {
        onChecked(value);
      },
      activeColor: Color(0xff15B86C),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    );
  }
}
