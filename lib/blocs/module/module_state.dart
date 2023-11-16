part of 'module_bloc.dart';

sealed class ModuleState extends Equatable {
  const ModuleState();

  @override
  List<Object> get props => [];
}

final class ModuleInitial extends ModuleState {}

final class ModuleLoadingState extends ModuleState {}

final class ModuleSuccessState<T> extends ModuleState {
  final T data;
  const ModuleSuccessState(this.data);
}

final class ModuleErrorState extends ModuleState {
  final String message;
  const ModuleErrorState(this.message);
  @override
  List<Object> get props => [message];
}
