import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_store/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:online_store/data/repositories/auth_repository.dart';
import 'package:online_store/presentation/auth_wrapper/auth_wrapper.dart';
import 'package:online_store/presentation/sign_up_page/sign_up_page.dart';
import 'package:online_store/presentation/theme/app_styles/app_colors.dart';
import 'package:online_store/presentation/theme/app_styles/app_styles.dart';
import 'package:online_store/presentation/widgets/actions_button.dart';
import 'package:online_store/presentation/widgets/custom_progress_indicator.dart';
import 'package:online_store/presentation/widgets/social_media_logos.dart';
import 'package:online_store/presentation/widgets/text_field.dart';
import 'package:page_transition/page_transition.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  AuthRepository authRepository = AuthRepository();
  bool _hasError = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            //Navigator.pushReplacement(
            //   context, MaterialPageRoute(builder: (context) => main_page()));
            Navigator.pushAndRemoveUntil(
              context,
              PageTransition(
                child: AuthWrapper(),
                type: PageTransitionType.fade,
              ),
              (route) => false,
            );
          }
          if (state is AuthError) {
            setState(() {
              _hasError = true;
            });
            context.read<AuthBloc>().emailController.clear();
            context.read<AuthBloc>().passwordController.clear();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Loading) {
              return const CustomProgressIndicator();
            }
            if (state is UnAuthenticated) {
              return SafeArea(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Form(
                      key: context.read<AuthBloc>().signInFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(height: 52.h),
                          Text(
                            'Sign In',
                            style: AppStyles.title.copyWith(fontSize: 35.h),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          FittedBox(
                              child: Text(
                            'Sign in to account\nto access thousands of products.',
                            style: AppStyles.header.copyWith(fontSize: 25.sp),
                          )),
                          SizedBox(
                            height: 42.h,
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
                            textInputType: TextInputType.emailAddress,
                            obscureText: false,
                            controller:
                                context.read<AuthBloc>().emailController,
                            validator: (value) {
                              if (value?.isEmpty ?? false)
                                return 'write something';
                              return value != null &&
                                      !EmailValidator.validate(value)
                                  ? 'Enter a valid email'
                                  : null;
                            },
                          ),
                          SizedBox(
                            height: 12.h,
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
                            controller:
                                context.read<AuthBloc>().passwordController,
                            validator: (value) {
                              if (value?.isEmpty ?? false)
                                return 'write something';
                              return value != null && value.length < 6
                                  ? "Enter min 6 characters"
                                  : null;
                            },
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Forgot password?',
                              style: AppStyles.medium.copyWith(fontSize: 22.sp),
                            ),
                          ),
                          SizedBox(
                            height: 32.h,
                          ),
                          if (_hasError)
                            Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "No such account",
                                  style: AppStyles.buttonTextOrange
                                      .copyWith(fontSize: 18.sp),
                                )),
                          SizedBox(
                            height: 90.h,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: CustomButton(
                              borderColor: Colors.transparent,
                              height: 50.h,
                              width: 400.w,
                              backgroundColor: AppColors.orange,
                              labelText: 'Sign In',
                              onTap: () {
                                setState(() {
                                  _hasError = false;
                                });
                                context
                                    .read<AuthBloc>()
                                    .authenticateWithEmailAndPassword(context);
                              },
                              labelTextStyle: AppStyles.buttonText
                                  .copyWith(fontSize: 25.sp),
                            ),
                          ),
                          SizedBox(
                            height: 52.h,
                          ),
                          Text(
                            'Connect with',
                            style: AppStyles.medium.copyWith(fontSize: 25.sp),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            children: [
                              LogoBuild(
                                imageUrl: 'assets/images/facebook_logo.png',
                                backgroundColor: Color(0xFF2F4787),
                                onTap: () {
                                  context
                                      .read<AuthBloc>()
                                      .authenticateWithFacebook(context);
                                },
                              ),
                              SizedBox(
                                width: 12.w,
                              ),
                              LogoBuild(
                                backgroundColor: Color(0xFFD4362D),
                                imageUrl: 'assets/images/google-plus.png',
                                onTap: () {
                                  context
                                      .read<AuthBloc>()
                                      .authenticateWithGoogle(context);
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 140.h,
                          ),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: RichText(
                                text: TextSpan(
                                  text: 'No account? ',
                                  style: AppStyles.hintText
                                      .copyWith(fontSize: 22.sp),
                                  children: [
                                    TextSpan(
                                      text: 'Sign up!',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                                child: SignUpPage(),
                                                type: PageTransitionType.fade),
                                          );
                                        },
                                      style: AppStyles.buttonTextOrange
                                          .copyWith(fontSize: 22.sp),
                                    )
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
