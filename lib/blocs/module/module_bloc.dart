import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pregnancy/models/modules.dart';
import 'package:pregnancy/repositories/file_repository.dart';

part 'module_event.dart';
part 'module_state.dart';

class ModuleBloc extends Bloc<ModuleEvent, ModuleState> {
  final FileRepository _fileRepository;

  final _modulesController = StreamController<List<Module>>.broadcast();

  Stream<List<Module>> get modulesStream => _modulesController.stream;
  ModuleBloc({required FileRepository fileRepository})
      : _fileRepository = fileRepository,
        super(ModuleInitial()) {
    on<ModuleEvent>((event, emit) {});
    on<UploadFileEvent>(_onUploadModuleEvent);
    on<DeleteModule>(_onDeleteModule);
  }

  Future<void> _onUploadModuleEvent(
      UploadFileEvent event, Emitter<ModuleState> emit) async {
    try {
      emit(ModuleLoadingState());
      final result = await _fileRepository.uploadFile(event.file);
      Module module = Module(
          id: '', name: event.name, url: result, createdAt: DateTime.now());
      await _fileRepository.saveModule(module);
      Future.delayed(const Duration(seconds: 2));
      emit(const ModuleSuccessState<String>("Successfully Saved!"));
    } catch (err) {
      emit(ModuleErrorState(err.toString()));
    }
  }

  Future<void> _onDeleteModule(
      DeleteModule event, Emitter<ModuleState> emit) async {
    try {
      emit(ModuleLoadingState());
      final result =
          await _fileRepository.deleteModuleAndFile(event.moduleID, event.path);
      emit(const ModuleSuccessState<String>("Successfully Deleted!"));
    } catch (err) {
      emit(ModuleErrorState(err.toString()));
    }
  }
}
