import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_store/bloc/shopping_cart_bloc/shopping_cart_bloc.dart';
import 'package:online_store/bloc/wish_list_bloc/wish_list_bloc.dart';
import 'package:online_store/data/models/product_model.dart';
import 'package:online_store/presentation/theme/app_styles/app_colors.dart';
import 'package:online_store/presentation/theme/app_styles/app_styles.dart';
import 'package:online_store/presentation/widgets/actions_button.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  ProductDetailPage({
    required this.product,
  });
  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          "Detail Page",
          style: AppStyles.header,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.darkBlue,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.h,
          ),
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0.r),
            ),
            child: Center(
              child: Container(
                width: double.infinity,
                height: 400.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.product.imageLink),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: Text(
              widget.product.description,
              style: AppStyles.header.copyWith(fontSize: 25.sp),
              maxLines: 2,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: Text(
              "Product",
              style: AppStyles.title.copyWith(fontSize: 40.sp),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: Text(
              "Type:     " + widget.product.type,
              style: AppStyles.header.copyWith(fontSize: 26.sp),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: Text(
                "Price:     £" + widget.product.price.toString(),
                style: AppStyles.header.copyWith(fontSize: 26.sp),
                maxLines: 2,
              ),
            ),
          ),
          SizedBox(
            height: 60.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 32.w, bottom: 20.h),
            child: Row(
              children: [
                CustomButton(
                  borderColor: AppColors.orange,
                  height: 60.h,
                  width: 200.w,
                  backgroundColor: AppColors.white,
                  labelText: "Add To Wishlist",
                  onTap: () {
                    context.read<WishListBloc>().add(WishListAddProduct(product: widget.product));
                  },
                  labelTextStyle:
                      AppStyles.buttonTextOrange.copyWith(fontSize: 22.sp),
                ),
                SizedBox(
                  width: 40.w,
                ),
                CustomButton(
                  height: 60.h,
                  width: 200.w,
                  borderColor: AppColors.orange,
                  backgroundColor: AppColors.orange,
                  labelText: "Add To Cart",
                  onTap: () {
                    context.read<ShoppingCartBloc>().add(
                        ShoppingCartAddProductEvent(product: widget.product));
                  },
                  labelTextStyle:
                      AppStyles.buttonText.copyWith(fontSize: 22.sp),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
