import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_store/bloc/detail_page_bloc/detail_page_bloc.dart';
import 'package:online_store/bloc/shopping_cart_bloc/shopping_cart_bloc.dart';
import 'package:online_store/bloc/wish_list_bloc/wish_list_bloc.dart';
import 'package:online_store/data/repositories/auth_repository.dart';

import 'package:online_store/presentation/router/app_router.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/auth_bloc/auth_bloc.dart';
import 'presentation/theme/app_styles/app_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool hasSeenOnBoarding = false;
  if (preferences.containsKey('hasSeenOnBoarding'))
    hasSeenOnBoarding = await preferences.getBool('hasSeenOnBoarding') ?? false;
  runApp(MyApp(hasSeenOnBoarding: hasSeenOnBoarding));
}

class MyApp extends StatelessWidget {
  final bool hasSeenOnBoarding;
  final AppRouter appRouter = AppRouter();

  MyApp({Key? key, required this.hasSeenOnBoarding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
        // RepositoryProvider(create: (context)=>null),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: RepositoryProvider.of<AuthRepository>(context),
            ),
          ),
          BlocProvider<ShoppingCartBloc>(
            create: (context) => ShoppingCartBloc(),
          ),
          BlocProvider<DetailPageBloc>(
            create: (context) => DetailPageBloc(),
          ),
          BlocProvider<WishListBloc>(
            create: (context) => WishListBloc(),
          ),
        ],
        child: ScreenUtilInit(
          designSize: Size(502, 1090),
          builder: (BuildContext context, Widget? child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Online Store',
            theme: ThemeData(
              inputDecorationTheme: InputDecorationTheme(
                iconColor: AppColors.hintTextColor,
              ),
              textSelectionTheme:
                  TextSelectionThemeData(cursorColor: AppColors.hintTextColor),
            ),
            onGenerateRoute: appRouter.onGenerateRoute,
          ),
        ),
      ),
    );
  }
}
