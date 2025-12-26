import 'package:flutter/material.dart';

class CustomTextFormFiledWidget extends StatelessWidget {
  const CustomTextFormFiledWidget({
    super.key,
    this.controllor,
    required this.title,
    this.formValidator,
    required this.hintText,
    this.maxLine,
  });
  final TextEditingController? controllor;
  final String title;
  final String? Function(String? value)? formValidator;
  final String hintText;
  final int? maxLine;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(title, style: Theme.of(context).textTheme.titleSmall),
          ],
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controllor,
          validator: (value) {
            return formValidator?.call(value);
          },
          maxLines: maxLine,
          decoration: InputDecoration(hintText: hintText),
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }
}
