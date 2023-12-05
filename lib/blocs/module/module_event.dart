part of 'module_bloc.dart';

sealed class ModuleEvent extends Equatable {
  const ModuleEvent();

  @override
  List<Object> get props => [];
}

class UploadFileEvent extends ModuleEvent {
  final File file;
  final String name;
  const UploadFileEvent(this.file, this.name);
  @override
  List<Object> get props => [file, name];
}

class GetAllModulesEvent extends ModuleEvent {
  const GetAllModulesEvent();
  @override
  List<Object> get props => [];
}

class DeleteModule extends ModuleEvent {
  final String moduleID;
  final String path;
  const DeleteModule(this.moduleID, this.path);
  @override
  List<Object> get props => [moduleID];
}
