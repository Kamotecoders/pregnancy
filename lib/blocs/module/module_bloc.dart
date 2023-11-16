import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pregnancy/repositories/file_repository.dart';

part 'module_event.dart';
part 'module_state.dart';

class ModuleBloc extends Bloc<ModuleEvent, ModuleState> {
  final FileRepository _fileRepository;

  ModuleBloc({required FileRepository fileRepository})
      : _fileRepository = fileRepository,
        super(ModuleInitial()) {
    on<ModuleEvent>((event, emit) {});
    on<UploadFileEvent>(_onUploadModuleEvent);
    on<GetAllModulesEvent>(_onGetAllModulesEvent);
  }

  Future<void> _onUploadModuleEvent(
      UploadFileEvent event, Emitter<ModuleState> emit) async {
    try {
      emit(ModuleLoadingState());
      final result = await _fileRepository.uploadFile(event.file);
      emit(ModuleSuccessState<String>(result));
    } catch (err) {
      emit(ModuleErrorState(err.toString()));
    }
  }

  Future<void> _onGetAllModulesEvent(
      GetAllModulesEvent event, Emitter<ModuleState> emit) async {
    try {
      emit(ModuleLoadingState());
      final result = await _fileRepository.getAllModules();
      emit(ModuleSuccessState<List<Map<String, String>>>(result));
    } catch (err) {
      emit(ModuleErrorState(err.toString()));
    }
  }
}
