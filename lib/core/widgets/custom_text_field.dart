import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key, 
    required this.hintText, 
    required this.textInputType, 
    this.suffixIcon, 
    this.onSaved,  
    this.obscureText = false,
    this.controller,
    this.isReadOnly = false,
    this.validator,
  });
  
  final String hintText;
  final TextInputType textInputType;
  final Widget? suffixIcon;
  final void Function(String?)? onSaved;
  final bool obscureText;
  final TextEditingController? controller;
  final bool isReadOnly;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: isReadOnly,
      obscureText: obscureText,
      onSaved: onSaved,
      validator: validator ?? (value){
        if(value == null || value.isEmpty){
          return 'هذا الحقل مطلوب';
        }
        return null;
      },
      keyboardType: textInputType,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xFF949D9E)
        ),
        hintText: hintText,
        filled: true,
        fillColor: Color(0xFFF9FAFA),
        border: BuildBoarder(),
        enabledBorder: BuildBoarder(),
        focusedBorder: BuildBoarder(),
      ),
    );
  }

  OutlineInputBorder BuildBoarder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(
          width: 1,
          color: Color(0xFFE6E9E9),
        ),
      );
  }
}