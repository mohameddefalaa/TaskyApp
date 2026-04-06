import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:protofilio/Shared/colors.dart';

class CustomeTextFiled extends StatelessWidget {
  const CustomeTextFiled({
    this.validator,
    super.key,
    required this.hinttext,
    required this.controller,
    required this.maxlins,
    required this.minlins,
    required this.title,
  });
  final String hinttext;
  final int maxlins;
  final int minlins;
  final String? Function(String?)? validator;
  final String title;

  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextTheme.of(context).titleMedium),
        const SizedBox(height: 16),
        TextFormField(
          maxLines: maxlins,
          minLines: minlins,

          validator: validator,

          controller: controller,
          textDirection: TextDirection.ltr,
          cursorColor: Colors.white,
          decoration: InputDecoration(hintText: hinttext),
        ),
      ],
    );
  }
}
