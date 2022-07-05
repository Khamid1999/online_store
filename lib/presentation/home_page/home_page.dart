import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_store/bloc/auth_bloc/auth_bloc.dart';
import 'package:online_store/data/models/category_model.dart';
import 'package:online_store/data/repositories/category_repository.dart';
import 'package:online_store/presentation/category_products_page/category_products_page.dart';
import 'package:online_store/presentation/theme/app_styles/app_colors.dart';
import 'package:online_store/presentation/theme/app_styles/app_styles.dart';
import 'package:online_store/presentation/widgets/custom_progress_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final _searchController = TextEditingController();
  void signOut() {
    BlocProvider.of<AuthBloc>(context).add(SignOutRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 65),
        child: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.white,
            ),
            child: Center(
              child: AnimationSearchBar(

                  duration: Duration(milliseconds: 400),
                  isBackButtonVisible: false,
                  backIconColor: Colors.black,
                  hintText: "What are you looking for?",
                  textStyle:
                      AppStyles.hintText.copyWith(color: AppColors.orange),
                  centerTitle: 'All Categories',
                  centerTitleStyle: AppStyles.medium,
                  onChanged: (text) => debugPrint(text),
                  searchTextEditingController: _searchController,
                  horizontalPadding: 5),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.orange,
        onPressed: () {
          signOut();
        },
        child: Center(
          child: Icon(Icons.exit_to_app),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: FutureBuilder<List<Category?>>(
            future: CategoryRepository().getCategoriesList(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return CustomProgressIndicator();
              else
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoryProductsPage(
                                collectionName:
                                snapshot.data!.elementAt(index)!.id,
                                categoryType:
                                snapshot.data!.elementAt(index)!.type,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 150.w,
                              height: 120.h,
                              margin: EdgeInsets.only(bottom: 20.h),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: Image.network(snapshot.data!
                                          .elementAt(index)!
                                          .imageLink)
                                      .image,
                                ),
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                            ),
                            SizedBox(width: 5.w,),
                            Text(
                              snapshot.data!.elementAt(index)!.type,
                              style: AppStyles.medium.copyWith(fontSize: 30.sp),
                            ),
                            SizedBox(width: 30.w,),
                            IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 35.sp,
                                color: AppColors.orange,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: snapshot.data!.length,
                  padding: EdgeInsets.symmetric(vertical: 30.h),
                );
            },
          ),
        ),
      ),
    );
  }
}
