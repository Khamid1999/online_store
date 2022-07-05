import 'package:flutter/material.dart';
import 'package:online_store/presentation/auth_wrapper/auth_wrapper.dart';
import 'package:online_store/presentation/checkout_success_page/checkout_success_page.dart';
import 'package:online_store/presentation/home_page/home_page.dart';
import 'package:online_store/presentation/main_page/main_page.dart';
import 'package:online_store/presentation/onboarding_page/onBoardingPage.dart';
import 'package:online_store/presentation/shopping_cart_page/shopping_cart_page.dart';
import 'package:online_store/presentation/sign_in_page/sign_in_page.dart';
import 'package:online_store/presentation/sign_up_page/sign_up_page.dart';
import 'package:online_store/presentation/wish_list_page/wishList_page.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => OnBoardingPage());
      case 'auth_wrapper_page':
        return MaterialPageRoute(builder: (_) => AuthWrapper());
      case 'sign_in_page':
        return MaterialPageRoute(builder: (_) => SignInPage());
      case 'sign_up_page':
        return MaterialPageRoute(builder: (_) => SignUpPage());
      case 'main_page':
        return MaterialPageRoute(builder: (_) => MainPage());
      case 'home_page':
        return MaterialPageRoute(builder: (_) => HomePage());
      case 'wish_list_page':
        return MaterialPageRoute(builder: (_) => WishListPage());
      case 'shopping_cart_page':
        return MaterialPageRoute(builder: (_) => ShoppingCartPage());
      case 'notification_page':
        return MaterialPageRoute(builder: (_) => OnBoardingPage());
      case 'checkout_success_page':
        return MaterialPageRoute(builder: (_) => CheckoutSuccessPage());
      default:
        return null;
    }
  }
}
