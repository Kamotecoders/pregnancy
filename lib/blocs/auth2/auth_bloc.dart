import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pregnancy/models/user.dart';
import 'package:pregnancy/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(AuthInitial()) {
    on<UserChangedEvent>(_onUserChange);
    on<SignInEvent>(_signInEvent);
    on<SignUpEvent>(_signUpEvent);
    on<ResetPasswordEvent>(_resetPassword);
    on<LogoutEvent>(_authLoggedOutEvent);
    on<ReauthenticateUser>(_reauthenticateUser);
    on<ChangeUserPassword>(_changUserPassword);
  }
  Future<void> _signInEvent(SignInEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoadingState());
      var result = await _authRepository.signInWithEmailAndPassword(
          email: event.email, password: event.password);

      if (result != null) {
        emit(AuthSuccessState<User>(result));
      }
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  Future<void> _onUserChange(
      UserChangedEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final User? currentUser = _authRepository.currentUser;

    if (currentUser != null) {
      emit(AuthSuccessState<User>(currentUser));
    } else {
      emit(UnAuthenticatedState());
    }
  }

  void _authLoggedOutEvent(LogoutEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoadingState());

      print("Signing out");
      await _authRepository.signOut();
      emit(UnAuthenticatedState());
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  Future<void> _signUpEvent(SignUpEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoadingState());

      var result = await _authRepository.registerWithEmailAndPassword(
          email: event.email, password: event.password);
      Users users = Users(
          id: result!.uid,
          name: event.name,
          photo: '',
          phone: event.phone,
          email: event.email,
          type: AccountType.ADMIN);
      emit(AuthSuccessState<Users>(users));
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  Future<void> _resetPassword(
      ResetPasswordEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoadingState());

      await _authRepository.resetPassword(event.email);
      emit(const AuthSuccessState<String>("Successfuly sent"));
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  FutureOr<void> _reauthenticateUser(
      ReauthenticateUser event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoadingState());

      _authRepository.reAuthenticateUser(
          _authRepository.currentUser!, event.currentPassword);
      add(ChangeUserPassword(_authRepository.currentUser!, event.newPassword));
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  FutureOr<void> _changUserPassword(
      ChangeUserPassword event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoadingState());
      await Future.delayed(const Duration(seconds: 1));
      _authRepository.changePassword(event.user, event.newPassword);
      emit(
        const AuthSuccessState<String>("Password changed successful!"),
      );
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }
}
