import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_store/bloc/shopping_cart_bloc/shopping_cart_bloc.dart';
import 'package:online_store/presentation/theme/app_styles/app_colors.dart';
import 'package:online_store/presentation/theme/app_styles/app_styles.dart';
import 'package:online_store/presentation/widgets/custom_progress_indicator.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shopping Cart',
          style: AppStyles.header.copyWith(fontSize: 26.sp),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: AppColors.orange,
          borderRadius: BorderRadius.circular(10.r),
        ),
        width: 200.w,
        height: 70.h,
        padding: EdgeInsets.only(left: 5.h),
        margin: EdgeInsets.only(right: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Total: £' + context.read<ShoppingCartBloc>().sum.toStringAsFixed(2),
              style: AppStyles.medium
                  .copyWith(fontSize: 20.sp, color: AppColors.white),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, 'checkout_success_page');
              },
              icon: Icon(
                Icons.account_balance_wallet,
                color: AppColors.white,
                size: 35.sp,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
          builder: (context, state) {
        if (state is ShoppingCartLoading)
          return CustomProgressIndicator();
        else if (state is ShoppingCartLoaded)
          return ListView.builder(
            itemCount: context.read<ShoppingCartBloc>().productList.length,
            itemBuilder: (BuildContext context, int index) {
              final bloc =
                  context.read<ShoppingCartBloc>().productList.elementAt(index);
              return Padding(
                padding: EdgeInsets.only(left: 16.w, top: 16.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100.w,
                          height: 80.h,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: Image.network(bloc.imageLink).image,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Column(
                          children: [
                            Text(
                              bloc.type,
                              style: AppStyles.header.copyWith(fontSize: 26.sp),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              bloc.description.length > 25
                                  ? bloc.description.replaceRange(
                                      20, bloc.description.length, '')
                                  : bloc.description,
                              style: AppStyles.header.copyWith(fontSize: 22.sp),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              "£ " + bloc.price.toString(),
                              style: AppStyles.header.copyWith(fontSize: 26.sp),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        IconButton(
                          onPressed: () {
                            context.read<ShoppingCartBloc>().add(
                                  ShoppingCartRemoveProductEvent(product: bloc),
                                );
                          },
                          icon: Icon(Icons.delete),
                          color: AppColors.orange,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              );
            },
          );
        return Container();
      }),
    );
  }
}
