import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {required this.textInputAction,
      required this.labelText,
      required this.keyboardType,
      required this.controller,
      super.key,
      this.onChanged,
      this.validator,
      this.obscureText,
      this.suffixIcon,
      this.onEditingComplete,
      this.autofocus,
      this.focusNode,
      this.onTap,
      this.floatingLabelBehavior});

  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool? obscureText;
  final Widget? suffixIcon;
  final String labelText;
  final bool? autofocus;
  final FocusNode? focusNode;
  final void Function()? onEditingComplete;
  final Future<void> Function()? onTap;
  final FloatingLabelBehavior? floatingLabelBehavior;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      focusNode: focusNode,
      onChanged: onChanged,
      autofocus: autofocus ?? false,
      validator: validator,
      obscureText: obscureText ?? false,
      obscuringCharacter: '*',
      onEditingComplete: onEditingComplete,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
        labelStyle: const TextStyle(
          color: Colors.blueGrey,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        suffixIcon: suffixIcon,
        labelText: labelText,
        floatingLabelBehavior: floatingLabelBehavior,
        fillColor: Colors.white,
        filled: true,
      ),
      onTap: onTap,
    );
  }
}
