import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_store/presentation/theme/app_styles/app_colors.dart';

class LogoBuild extends StatelessWidget {
  final Color? backgroundColor;
  final String? imageUrl;
  final VoidCallback onTap;
  LogoBuild(
      {required this.backgroundColor,
      required this.imageUrl,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100.w,
        height: 100.h,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Center(
          child: Image.asset(
            imageUrl!,
            height: 60.h,
            width: 60.w,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
