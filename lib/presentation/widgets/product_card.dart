import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_store/presentation/theme/app_styles/app_colors.dart';
import 'package:online_store/presentation/theme/app_styles/app_styles.dart';

class ProductCard extends StatelessWidget {
  final String? imageUrl;
  final String? description;
  final double price;
  final VoidCallback onTap;

  ProductCard(
      {required this.imageUrl,
      required this.description,
      required this.price,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 290.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0.r),
                  image: DecorationImage(
                      fit: BoxFit.fill, image: NetworkImage(imageUrl!))),
            ),
            Container(
              width: double.infinity,
              child: Row(
                children: [
                  Text(
                    description!.length > 25
                        ? description!.replaceRange(20, description!.length, '')
                        : description!,
                    style: AppStyles.bottomNavigationItems.copyWith(
                        color: AppColors.lightOrange, fontSize: 14.sp),
                    maxLines: 1,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 6.w),
                    child: Text(
                      "£" + price.toString(),
                      style: AppStyles.bottomNavigationItems
                          .copyWith(color: AppColors.orange),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
