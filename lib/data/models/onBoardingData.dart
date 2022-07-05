import 'package:flutter/material.dart';

class OnBoardingData {
  final String title, subtitle;
  final Color backgroundColor, titleColor, subtitleColor;
  final Widget? animation;
  OnBoardingData(
      {required this.title,
      required this.subtitle,
      required this.backgroundColor,
      required this.titleColor,
      required this.subtitleColor,
      required this.animation});
}
