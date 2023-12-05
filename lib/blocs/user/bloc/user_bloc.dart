import 'dart:async';
import 'dart:io';

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
    on<UploadImageProfile>(_onUploadImageProfile);
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

  Future<void> _onUploadImageProfile(
      UploadImageProfile event, Emitter<UserState> emit) async {
    try {
      emit(UserLoadingState());
      String? result = await _userRepository.uploadFile(event.file, event.uid);
      if (result != null) {
        await _userRepository.updateProfileImage(event.uid, result);
        emit(UserSuccessState<String>(result));
      } else {
        emit(UserErrorState("Unknown error"));
      }
    } catch (e) {
      emit(UserErrorState(e.toString()));
    }
  }
}
