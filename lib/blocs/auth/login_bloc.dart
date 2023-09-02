import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pregnancy/repositories/auth_repository.dart';

part 'login_bloc_event.dart';
part 'login_bloc_state.dart';

class LoginBloc extends Bloc<LoginBlocEvent, LoginBlocState> {
  final AuthRepository _authRepository;

  LoginBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(LoginBlocInitial()) {
    on<UserChangedEvent>(_onUserChange);
    on<LoginBlocEvent>((event, emit) {});
    on<SignInEvent>(_signInEvent);
    on<LogoutEvent>(_authLoggedOutEvent);
    add(UserChangedEvent(_authRepository.currentUser));
  }

  Future<void> _signInEvent(
      SignInEvent event, Emitter<LoginBlocState> emit) async {
    try {
      emit(LoginBlocLoading());
      var result = await _authRepository.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      emit(LoginBlocAuthenticated(result!));
    } catch (e) {
      emit(LoginBlocError(e.toString()));
    }
  }

  Future<void> _onUserChange(
      UserChangedEvent event, Emitter<LoginBlocState> emit) async {
    emit(LoginBlocLoading());
    final User? currentUser = _authRepository.currentUser;
    if (currentUser != null) {
      emit(LoginBlocAuthenticated(currentUser));
    } else {
      emit(LoginBlocUnAuthenticated());
    }
  }

  void _authLoggedOutEvent(
      LogoutEvent event, Emitter<LoginBlocState> emit) async {
    try {
      emit(LoginBlocLoading());
      print("Signing out");
      await _authRepository.signOut();
      add(UserChangedEvent(_authRepository.currentUser));
    } catch (e) {
      emit(LoginBlocError(e.toString()));
    }
  }
}
