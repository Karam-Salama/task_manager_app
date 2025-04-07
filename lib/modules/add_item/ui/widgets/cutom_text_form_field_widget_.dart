// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final bool? obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final Function()? onTap;
  final int maxLines;
  final bool readOnly;
  final TextEditingController? controller;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.onSaved,
    this.maxLines = 1,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onTap: onTap,
      onSaved: onSaved,
      readOnly: readOnly,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      obscureText: obscureText!,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: AppTextStyle.pacifico700style23Black.copyWith(
        fontSize: 18,
      ),
      decoration: InputDecoration(
        enabledBorder: getBorderStyle(),
        focusedBorder: getBorderStyle(),
        border: getBorderStyle(),
        hintText: hintText,
        hintStyle: AppTextStyle.pacifico700style23Black.copyWith(
          fontSize: 16,
          color: AppColors.greyColor,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        suffixIcon: suffixIcon,
      ),
    );
  }
}

OutlineInputBorder getBorderStyle() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(
      color: Color(0xFFE6E9EA),
      width: 1.0,
    ),
  );
}
