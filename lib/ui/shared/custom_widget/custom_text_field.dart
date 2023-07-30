import 'package:flutter/material.dart';
import '../colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.validator,
      this.preicon, this.suffixicon});
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final IconData? preicon;
  final IconData? suffixicon;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      style: TextStyle(
        fontSize: size.width * 0.035,
        color: AppColors.maingreyColor,
        fontWeight: FontWeight.normal,
      ),
      decoration: InputDecoration(
          prefixIcon: Icon(widget.preicon),
          suffixIcon: Icon(widget.suffixicon),
          errorStyle: TextStyle(color: AppColors.mainOrangeColor, fontSize: 8),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: size.width * 0.035,
            fontWeight: FontWeight.normal,
          ),
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(size.width * 0.8),
          )),
    );
  }
}
