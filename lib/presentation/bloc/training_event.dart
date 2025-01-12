part of 'training_bloc.dart';

abstract class TrainingEvent {}

class FetchTrainingsList extends TrainingEvent {}

class FilterTrainingsList extends TrainingEvent {}

class UpdateEnrolmentStatus extends TrainingEvent {
  final int id;
  UpdateEnrolmentStatus(this.id);
}
