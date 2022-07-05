import 'package:flutter/material.dart';
import 'package:online_store/presentation/theme/app_styles/app_colors.dart';

class AppStyles {
  static const title = TextStyle(
          fontSize: 25, color: AppColors.lightOrange, fontFamily: 'Montserrat'),
      header = TextStyle(
          fontSize: 20, color: AppColors.darkBlue, fontFamily: 'Montserrat'),
      medium = TextStyle(
          fontSize: 18, color: AppColors.darkGrey, fontFamily: 'Montserrat'),
      bottomNavigationItems = TextStyle(
          fontSize: 12, color: AppColors.darkGrey, fontFamily: 'Montserrat'),
      hintText = TextStyle(
          fontSize: 16,
          color: AppColors.hintTextColor,
          fontFamily: 'Montserrat'),
      buttonText = TextStyle(
          fontSize: 25, color: AppColors.white, fontFamily: 'Montserrat'),
      buttonTextOrange = TextStyle(
          fontSize: 25, color: AppColors.lightOrange, fontFamily: 'Montserrat');
}
