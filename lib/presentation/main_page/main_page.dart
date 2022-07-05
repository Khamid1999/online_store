import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_store/presentation/home_page/home_page.dart';
import 'package:online_store/presentation/notifications_page/notifications_page.dart';
import 'package:online_store/presentation/shopping_cart_page/shopping_cart_page.dart';
import 'package:online_store/presentation/sign_in_page/sign_in_page.dart';
import 'package:online_store/presentation/theme/app_styles/app_colors.dart';
import 'package:online_store/presentation/theme/app_styles/app_styles.dart';
import 'package:online_store/presentation/widgets/custom_progress_indicator.dart';
import 'package:online_store/presentation/wish_list_page/wishList_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final controller = TextEditingController();
  int selectedIndex = 0;
  List<Widget> widgets = [
    HomePage(),
    WishListPage(),
    NotificationsPage(),
    ShoppingCartPage(),
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: StylishBottomBar(
        iconStyle: IconStyle.animated,
        fabLocation: StylishBarFabLocation.center,
        barAnimation: BarAnimation.fade,
        barStyle: BubbleBarStyle.horizotnal,
        currentIndex: selectedIndex,
        opacity: 0.3,
        hasNotch: true,
        onTap: (index) {
          setState(() {
            selectedIndex = index!;
          });
        },
        items: [
          AnimatedBarItems(
            selectedIcon: Icon(
              Icons.home_rounded,
              color: AppColors.orange,
            ),
            icon: Icon(
              Icons.home_outlined,
              color: AppColors.darkGrey,
            ),
            title: Text(
              "Home",
              style: AppStyles.bottomNavigationItems,
            ),
          ),
          AnimatedBarItems(
            selectedIcon: Icon(
              Icons.favorite_border_rounded,
              color: AppColors.orange,
            ),
            icon: Icon(
              Icons.favorite_border_outlined,
              color: AppColors.darkGrey,
            ),
            title: Text(
              "Wishlist",
              style: AppStyles.bottomNavigationItems,
            ),
          ),
          AnimatedBarItems(
            selectedIcon: Icon(
              Icons.notifications_none_rounded,
              color: AppColors.orange,
            ),
            icon: Icon(
              Icons.notifications_none_outlined,
              color: AppColors.darkGrey,
            ),
            title: Text(
              "Notifications",
              style: AppStyles.bottomNavigationItems,
            ),
          ),
          AnimatedBarItems(
            selectedIcon: Icon(
              Icons.shopping_cart_outlined,
            ),
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: AppColors.darkGrey,
            ),
            title: Text(
              "Cart",
              style: AppStyles.bottomNavigationItems,
            ),
          ),
        ],
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (BuildContext context, state) {
          if (state is UnAuthenticated) {
            Navigator.push(
              context,
              PageTransition(
                  child: SignInPage(), type: PageTransitionType.fade),
            );
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (BuildContext context, Object? state) {
          if (state is Loading) {
            return CustomProgressIndicator();
          }
          else if (state is Authenticated || state is AlreadyAuth) {
            return widgets.elementAt(selectedIndex);
          }

          return Container(
            child: Text('Error'),
          );
        },
      ),

    );
  }


}
