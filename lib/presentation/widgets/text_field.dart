import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_store/presentation/theme/app_styles/app_colors.dart';
import 'package:online_store/presentation/theme/app_styles/app_styles.dart';


class TxtFld extends StatelessWidget {
  final String? hintText;
  final TextEditingController controller;
  final TextInputType textInputType;
  final bool obscureText;
  final String? Function(String?) validator;
  final Icon? icon;
  TxtFld({
    required this.hintText,
    required this.icon,
    required this.obscureText,
    required this.textInputType,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      autocorrect: true,
      keyboardType: textInputType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.hintTextColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.hintTextColor),
        ),
        border: InputBorder.none,
        focusColor: AppColors.hintTextColor,
        fillColor: AppColors.hintTextColor,
        hintText: hintText,
        hintStyle: AppStyles.hintText.copyWith(fontSize: 18.sp),
        icon: icon,
        iconColor: AppColors.hintTextColor,
      ),
    );
  }
}
