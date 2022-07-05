import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_store/data/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  void authenticateWithEmailAndPassword(context) {
    if (signInFormKey.currentState?.validate() ?? false) {
      BlocProvider.of<AuthBloc>(context).add(
        SignInRequested(emailController.text, passwordController.text),
      );
    }
  }

 Future<void> dispose() async {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    return super.close();
  }

  void authenticateWithGoogle(context) {
    BlocProvider.of<AuthBloc>(context).add(
      GoogleSignInRequested(),
    );
  }

  AuthBloc({required this.authRepository}) : super(UnAuthenticated()) {
    on<SignInRequested>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.signIn(
            email: event.email, password: event.password);

        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });
    on<UserRemember>((event, emit) {
      emit(Authenticated());
    });
    on<SignUpRequested>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.signUp(
            email: event.email, password: event.password);
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });
    on<GoogleSignInRequested>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.signInWithGoogle();
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });
    on<SignOutRequested>((event, emit) async {
      emit(Loading());
      await authRepository.signOut();
      emit(UnAuthenticated());
    });
    on<FacebookSignInRequested>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.signInWithFacebook();
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });
  }
  void authenticateWithFacebook(context) {
    BlocProvider.of<AuthBloc>(context).add(FacebookSignInRequested());
  }

  void signUpWithEmailAndPassword(context) {
    if (signInFormKey.currentState?.validate() ?? false) {
      BlocProvider.of<AuthBloc>(context).add(
        SignUpRequested(emailController.text, passwordController.text),
      );
    }
  }
}
