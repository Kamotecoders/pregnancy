import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pregnancy/blocs/auth2/auth_bloc.dart';
import 'package:pregnancy/models/user.dart';
import 'package:pregnancy/repositories/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(UserInitialState()) {
    on<UserEvent>((event, emit) {});
    on<CreateUser>(_createUser);
    on<GetUserProfile>(_getUserProfile);
    on<UpdateUserInfo>(_updateUserInfo);
  }

  Future<void> _createUser(CreateUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoadingState());
      await Future.delayed(const Duration(seconds: 1));
      await _userRepository.addUser(event.users);
      emit(const UserSuccessState("Successfully Added"));
    } catch (e) {
      emit(UserErrorState(e.toString()));
      emit(UserInitialState());
    }
  }

  Future<void> _getUserProfile(
      GetUserProfile event, Emitter<UserState> emit) async {
    try {
      emit(UserLoadingState());
      final userProfile = await _userRepository.getUserProfile(event.userID);

      if (userProfile != null) {
        emit(UserSuccessState<Users>(userProfile));
      }
    } catch (e) {
      emit(UserErrorState(e.toString()));
    }
  }

  Future<void> _updateUserInfo(
      UpdateUserInfo event, Emitter<UserState> emit) async {
    try {
      emit(UserLoadingState());

      await _userRepository.updateUserProfile(event.users);
      emit(const UserSuccessState<String>("Successfully Updated"));
    } catch (e) {
      emit(UserErrorState(e.toString()));
    }
  }
}
