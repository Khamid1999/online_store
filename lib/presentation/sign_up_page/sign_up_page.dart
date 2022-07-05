import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_store/bloc/auth_bloc/auth_bloc.dart';
import 'package:online_store/data/repositories/auth_repository.dart';
import 'package:online_store/presentation/main_page/main_page.dart';
import 'package:online_store/presentation/sign_in_page/sign_in_page.dart';
import 'package:online_store/presentation/theme/app_styles/app_colors.dart';
import 'package:online_store/presentation/theme/app_styles/app_styles.dart';
import 'package:online_store/presentation/widgets/actions_button.dart';
import 'package:online_store/presentation/widgets/custom_progress_indicator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:username_validator/username_validator.dart';

import '../widgets/text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  AuthRepository authRepository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.push(
              context,
              PageTransition(child: MainPage(), type: PageTransitionType.fade),
            );
          }
          if (state is AuthError) {
            context.read<AuthBloc>().emailController.clear();
            context.read<AuthBloc>().passwordController.clear();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (BuildContext context, state) {
          if (state is Loading) {
            return CustomProgressIndicator();
          }
          if (state is UnAuthenticated) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: SafeArea(
                child: SingleChildScrollView(
                  reverse: true,
                  child: Form(
                    key: context.read<AuthBloc>().signUpFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: 52.h,
                        ),
                        Text(
                          'Sign Up',
                          style: AppStyles.title.copyWith(fontSize: 35.sp),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        FittedBox(
                            child: Text(
                          'Sign up to account\nto access thousands of products.',
                          style: AppStyles.header.copyWith(fontSize: 25.sp),
                        )),
                        SizedBox(
                          height: 44.h,
                        ),
                        Text(
                          'Name',
                          style: AppStyles.medium.copyWith(fontSize: 22.sp),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        TxtFld(
                          hintText: 'Enter your name',
                          controller: context.read<AuthBloc>().nameController,
                          icon: Icon(Icons.title_outlined),
                          textInputType: TextInputType.name,
                          obscureText: false,
                          validator: (value) {
                            if (!UValidator.validateThis(
                                pattern: RegPattern.strict, username: value!)) {
                              return 'Invalid username';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Text(
                          'Email',
                          style: AppStyles.medium.copyWith(fontSize: 22.sp),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        TxtFld(
                          hintText: 'Enter your email',
                          icon: Icon(Icons.email_outlined),
                          obscureText: false,
                          textInputType: TextInputType.emailAddress,
                          validator: (value) {
                            return value != null &&
                                    !EmailValidator.validate(value)
                                ? 'Enter a valid email'
                                : null;
                          },
                          controller: context.read<AuthBloc>().emailController,
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Text(
                          'Password',
                          style: AppStyles.medium.copyWith(fontSize: 22.sp),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        TxtFld(
                          hintText: 'Enter your password',
                          icon: Icon(Icons.lock_outline),
                          textInputType: TextInputType.text,
                          obscureText: true,
                          validator: (value) {
                            return value != null && value.length < 6
                                ? "Enter min 6 characters"
                                : null;
                          },
                          controller:
                              context.read<AuthBloc>().passwordController,
                        ),
                        SizedBox(
                          height: 100.h,
                        ),
                        Center(
                            child: CustomButton(
                                height: 50.h,
                                width: 400.w,
                                backgroundColor: AppColors.orange,
                                borderColor: Colors.transparent,
                                labelText: 'Sign Up',
                                onTap: () {
                                  context
                                      .read<AuthBloc>()
                                      .signUpWithEmailAndPassword(context);
                                },
                                labelTextStyle: AppStyles.buttonText)),
                        SizedBox(
                          height: 24.h,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: RichText(
                            text: TextSpan(
                              text: 'already have an account?  ',
                              style:
                                  AppStyles.hintText.copyWith(fontSize: 18.sp),
                              children: [
                                TextSpan(
                                    text: 'Login',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                child: SignInPage(),
                                                type: PageTransitionType.fade));
                                      },
                                    style: AppStyles.buttonTextOrange
                                        .copyWith(fontSize: 24.sp))
                              ],
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom)),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return Container(
            child: Text('failed'),
          );
        },
      ),
    );
  }
}
