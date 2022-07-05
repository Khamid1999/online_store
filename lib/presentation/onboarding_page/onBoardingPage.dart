import 'package:concentric_transition/page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:online_store/bloc/auth_bloc/auth_bloc.dart';
import 'package:online_store/data/models/onBoardingData.dart';
import 'package:online_store/data/repositories/auth_repository.dart';
import 'package:online_store/presentation/auth_wrapper/auth_wrapper.dart';
import 'package:online_store/presentation/theme/app_styles/app_colors.dart';
import 'package:online_store/presentation/widgets/onBoarding_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingPage extends StatelessWidget {
  OnBoardingPage({Key? key}) : super(key: key);
  final data = [
    OnBoardingData(
        title: "Exploration",
        subtitle: "You can have anything you want in life if you dress for it.",
        backgroundColor: AppColors.rose,
        titleColor: AppColors.darkGrey,
        subtitleColor: AppColors.darkGrey,
        animation: LottieBuilder.asset(
          "assets/animations/women-dress.json",
          frameRate: FrameRate(
            20
          ),
          repeat: false,
          height: 300.h,
          width: 300.w,
        )),
    OnBoardingData(
        title: "Sense",
        subtitle: "Clothes mean nothing until someone lives in them",
        backgroundColor: AppColors.lilac,
        titleColor: AppColors.darkGrey,
        subtitleColor: AppColors.darkGrey,
        animation: LottieBuilder.asset(
          "assets/animations/sneaker.json",
          repeat: false,
          height: 300.h,
          width: 300.w,
        )),
    OnBoardingData(
        title: "Vision",
        subtitle: "Style is a way to say who you are without having to speak",
        backgroundColor: AppColors.lightBlue,
        titleColor: AppColors.darkGrey,
        subtitleColor: AppColors.darkGrey,
        animation: LottieBuilder.asset(
          "assets/animations/shopping.json",
          repeat: false,
          height: 300.h,
          width: 300.w,
        )),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        colors: data.map((e) => e.backgroundColor).toList(),
        itemCount: data.length,
        onFinish: () async {
          final preferences = await SharedPreferences.getInstance();
          await preferences.setBool('hasSeenOnBoarding', true);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => BlocProvider(
                    create: (context) => AuthBloc(
                        authRepository:
                            RepositoryProvider.of<AuthRepository>(context)),
                    child: AuthWrapper())),
            (route) => false,
          );
        },
        itemBuilder: (int index,) {
          return OnBoardingCard(data: data[index]);
        },
      ),
    );
  }
}
