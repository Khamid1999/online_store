import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_store/bloc/auth_bloc/auth_bloc.dart';
import 'package:online_store/data/repositories/auth_repository.dart';
import 'package:online_store/presentation/main_page/main_page.dart';
import 'package:online_store/presentation/sign_in_page/sign_in_page.dart';
import 'package:online_store/presentation/widgets/custom_progress_indicator.dart';


class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AuthBloc(
          authRepository: RepositoryProvider.of<AuthRepository>(context)),
      child: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CustomProgressIndicator());
            } else if (snapshot.hasData) {
              BlocProvider.of<AuthBloc>(context).add(UserRemember());
              return MainPage();
            } else {
              return SignInPage();
            }
          }),
    );
  }
}
