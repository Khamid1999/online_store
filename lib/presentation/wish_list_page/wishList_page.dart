import 'package:flutter/material.dart';
import 'package:flutter_add_to_cart_button/flutter_add_to_cart_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_store/bloc/wish_list_bloc/wish_list_bloc.dart';
import 'package:online_store/presentation/theme/app_styles/app_colors.dart';
import 'package:online_store/presentation/theme/app_styles/app_styles.dart';
import 'package:online_store/presentation/widgets/custom_progress_indicator.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({Key? key}) : super(key: key);

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  AddToCartButtonStateId stateId = AddToCartButtonStateId.idle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Wish List",
            style: AppStyles.header.copyWith(fontSize: 26.sp),
          ),
          centerTitle: true,
          backgroundColor: AppColors.white,

        ),
        body: BlocBuilder<WishListBloc, WishListState>(
          builder: (context, state) {
            if (state is WishListLoading)
              return CustomProgressIndicator();
            else if (state is WishListLoaded) {
              return ListView.builder(
                  itemCount: context.read<WishListBloc>().wishList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final bloc =
                        context.read<WishListBloc>().wishList.elementAt(index);
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
                                    image:
                                        Image.network(bloc!.imageLink).image,
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
                                    style: AppStyles.header
                                        .copyWith(fontSize: 26.sp),
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  Text(
                                    bloc.description.length > 25
                                        ? bloc.description.replaceRange(
                                            20, bloc.description.length, '')
                                        : bloc.description,
                                    style: AppStyles.header
                                        .copyWith(fontSize: 22.sp),
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  Text(
                                    "£ " + bloc.price.toString(),
                                    style: AppStyles.header
                                        .copyWith(fontSize: 26.sp),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              IconButton(
                                onPressed: () {
                                  context.read<WishListBloc>().add(
                                        WishListRemoveProduct(product: bloc),
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
                  });
            }
            return Container();
          },
        ));
  }
}
