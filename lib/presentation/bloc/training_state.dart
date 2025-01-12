part of 'training_bloc.dart';

abstract class TrainingState {}

class TrainingInitial extends TrainingState {}

class TrainingsDataLoading extends TrainingState {}

class TrainingsDataSuccess extends TrainingState {
    List<Courses>? courses;
    List<Courses>? highlightsCourses;
  TrainingsDataSuccess({this.courses, this.highlightsCourses});
}
