import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_store/presentation/theme/app_styles/app_colors.dart';
import 'package:online_store/presentation/theme/app_styles/app_styles.dart';
import 'package:online_store/presentation/widgets/actions_button.dart';

class CheckoutSuccessPage extends StatefulWidget {
  const CheckoutSuccessPage({Key? key}) : super(key: key);

  @override
  State<CheckoutSuccessPage> createState() => _CheckoutSuccessPageState();
}

class _CheckoutSuccessPageState extends State<CheckoutSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100.h,
            ),
            Container(
              width: 100.w,
              height: 100.h,
              decoration: BoxDecoration(
                color: AppColors.orange,
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Center(
                child: Icon(
                  Icons.check,
                  size: 30,
                  color: AppColors.white,
                ),
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            Text(
              "Confirmation Success",
              style: AppStyles.medium.copyWith(fontSize: 35.sp),
            ),
            SizedBox(
              height: 30.h,
            ),
            Center(
              child: Text(
                "Thank You for choosing our products.\n Our delivery man will call You.",
                style: AppStyles.medium.copyWith(fontSize: 24.sp),
              ),
            ),
            SizedBox(
              height: 60.h,
            ),
            CustomButton(
                height: 50.h,
                width: 300.w,
                backgroundColor: AppColors.orange,
                borderColor: AppColors.transparent,
                labelText: "Continue Shopping",
                onTap: () {
                  Navigator.pop(context);
                },
                labelTextStyle: AppStyles.buttonText.copyWith(fontSize: 16.sp)),
            SizedBox(
              height: 20.h,
            ),
            CustomButton(
                height: 50.h,
                width: 300.w,
                backgroundColor: AppColors.white,
                borderColor: AppColors.orange,
                labelText: "Track Order",
                onTap: () {},
                labelTextStyle: AppStyles.buttonText
                    .copyWith(fontSize: 16.sp, color: AppColors.orange)),
          ],
        ),
      ),
    );
  }
}
