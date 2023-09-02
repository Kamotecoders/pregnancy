part of 'login_bloc.dart';

sealed class LoginBlocState extends Equatable {
  const LoginBlocState();

  @override
  List<Object> get props => [];
}

final class LoginBlocInitial extends LoginBlocState {}

final class LoginBlocLoading extends LoginBlocState {}

final class LoginBlocAuthenticated extends LoginBlocState {
  final User user;
  const LoginBlocAuthenticated(this.user);
}

final class LoginBlocUnAuthenticated extends LoginBlocState {}

final class LoginBlocError extends LoginBlocState {
  final String message;
  const LoginBlocError(this.message);
}

final class LoginBlocUserChanged extends LoginBlocState {
  final User? user;
  const LoginBlocUserChanged(this.user);
}
