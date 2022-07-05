part of 'package:online_store/bloc/auth_bloc/auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Loading extends AuthState {}

class Authenticated extends AuthState {}

class UnAuthenticated extends AuthState {}

class AuthError extends AuthState {
  final String error;

  AuthError(this.error);

  @override
  List<Object?> get props => [error];
}

class AlreadyAuth extends AuthState {}
