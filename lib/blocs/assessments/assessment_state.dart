part of 'assessment_bloc.dart';

sealed class AssessmentState extends Equatable {
  const AssessmentState();

  @override
  List<Object> get props => [];
}

final class AssessmentInitial extends AssessmentState {}

final class AssessmentLoadingState extends AssessmentState {}

final class AssessmentSuccessState<T> extends AssessmentState {
  final T data;
  const AssessmentSuccessState(this.data);
}

final class AssessmentErrorState extends AssessmentState {
  final String message;
  const AssessmentErrorState(this.message);
  @override
  List<Object> get props => [message];
}
