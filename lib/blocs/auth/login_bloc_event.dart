part of 'login_bloc.dart';

sealed class LoginBlocEvent extends Equatable {
  const LoginBlocEvent();

  @override
  List<Object?> get props => [];
}

class SignInEvent extends LoginBlocEvent {
  final String email;
  final String password;
  const SignInEvent(this.email, this.password);
  @override
  List<Object> get props => [email, password];
}

class UserChangedEvent extends LoginBlocEvent {
  final User? user;
  const UserChangedEvent(this.user);
  @override
  List<Object?> get props => [user];
}

class SignUpEvent extends LoginBlocEvent {
  final String name;
  final String phone;
  final String email;
  final String password;
  const SignUpEvent(this.name, this.phone, this.email, this.password);
  @override
  List<Object> get props => [name, phone, email, password];
}

class LogoutEvent extends LoginBlocEvent {
  final User user;
  const LogoutEvent(this.user);
  @override
  List<Object> get props => [user];
}
