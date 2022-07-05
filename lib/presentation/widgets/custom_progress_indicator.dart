import 'package:flutter/material.dart';
import 'package:online_store/presentation/theme/app_styles/app_colors.dart';
import 'package:progress_indicators/progress_indicators.dart';


class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: JumpingText('Loading...',style: TextStyle(
      color: AppColors.lightOrange,
      fontSize: 20,
      fontFamily: 'Montserrat',
    ),
    end: Offset(0,-0.5),));
  }
}

