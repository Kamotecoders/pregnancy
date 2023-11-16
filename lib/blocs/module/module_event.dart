part of 'module_bloc.dart';

sealed class ModuleEvent extends Equatable {
  const ModuleEvent();

  @override
  List<Object> get props => [];
}

class UploadFileEvent extends ModuleEvent {
  final File file;
  const UploadFileEvent(this.file);
  @override
  List<Object> get props => [file];
}

class GetAllModulesEvent extends ModuleEvent {
  const GetAllModulesEvent();
  @override
  List<Object> get props => [];
}
