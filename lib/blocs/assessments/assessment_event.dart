part of 'assessment_bloc.dart';

sealed class AssessmentEvent extends Equatable {
  const AssessmentEvent();

  @override
  List<Object> get props => [];
}

class AddAssessmentEvent extends AssessmentEvent {
  final Assessments assessments;
  const AddAssessmentEvent(this.assessments);
  @override
  List<Object> get props => [assessments];
}
