import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_store/data/models/onBoardingData.dart';
import 'package:online_store/presentation/theme/app_styles/app_styles.dart';

class OnBoardingCard extends StatelessWidget {
  OnBoardingCard({required this.data});

  final OnBoardingData data;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding:  EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
          child: Column(
            children: [
              GestureDetector(
                child: Align(alignment: Alignment.topRight,
                    child: Text("Skip",style: AppStyles.title,),
                ),
                onTap: (){
                  Navigator.pushNamed(context, 'auth_wrapper_page');
                },
              ),
              const Spacer(
                flex: 3,
              ),
              SizedBox(height: 64.h,),
              Flexible(
                flex: 20,
                child: data.animation!,
              ),
              const Spacer(
                flex: 1,
              ),
              Text(
                data.title.toUpperCase(),
                style: TextStyle(
                  color: data.titleColor,
                  fontSize: 35.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
                maxLines: 1,
              ),
              const Spacer(
                flex: 1,
              ),
              Text(
                data.subtitle,
                style: TextStyle(color: data.subtitleColor, fontSize: 25.sp),
              textAlign: TextAlign.center,
                maxLines: 2,
              ),
              const Spacer(flex: 15,),
            ],
          ),
        ),
      ],
    );
  }
}
