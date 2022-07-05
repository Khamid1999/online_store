import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomButton extends StatelessWidget {
final double? height;
final VoidCallback onTap;
final double? width;
final String? labelText;
final Color? backgroundColor;
final TextStyle labelTextStyle;
final Color? borderColor;
const CustomButton({required this.height,required this.width,required this.backgroundColor,required this.labelText,required this.onTap,required this.labelTextStyle, this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Ink(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(
              color: borderColor!,
            ),
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Center(
            child: Text(labelText!,style: labelTextStyle,),
          ),
        ),
      ),
    );
  }
}
