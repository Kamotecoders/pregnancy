import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pregnancy/models/assesments.dart';
import 'package:pregnancy/repositories/assesment_repository.dart';

part 'assessment_event.dart';
part 'assessment_state.dart';

class AssessmentBloc extends Bloc<AssessmentEvent, AssessmentState> {
  final AssessmentRepository _assessmentRepository;
  AssessmentBloc({required AssessmentRepository assessmentRepository})
      : _assessmentRepository = assessmentRepository,
        super(AssessmentInitial()) {
    on<AssessmentEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<AddAssessmentEvent>(_onAddAssessmentEvent);
  }

  Future<void> _onAddAssessmentEvent(
      AddAssessmentEvent event, Emitter<AssessmentState> emit) async {
    try {
      emit(AssessmentLoadingState());
      _assessmentRepository.addAssessment(event.assessments);
      emit(const AssessmentSuccessState<String>("Successfully Saved"));
    } catch (e) {
      emit(AssessmentErrorState(e.toString()));
    }
  }
}
