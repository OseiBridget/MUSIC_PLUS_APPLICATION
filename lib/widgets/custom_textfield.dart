import 'package:flutter/material.dart';
import 'package:testapp/data/colors.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final bool obscureText;
  final bool readonly;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    required this.text,
    required this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.readonly = false,
    this.keyboardType = TextInputType.multiline,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        readOnly: readonly,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Feild should not be empty";
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: text,
          // labelText: text,
          fillColor: readOnlyColor,
          filled: readonly,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
