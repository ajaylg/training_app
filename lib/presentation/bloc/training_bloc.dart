import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/app_constants.dart';
import '../../data/models/sort_filter_model.dart';
import '../../data/models/training_model.dart';
import '../../data/repositories/training_repository.dart';

part 'training_event.dart';
part 'training_state.dart';

class TrainingBloc extends Bloc<TrainingEvent, TrainingState> {
  final ValueNotifier<List<FilterModel>> selectedFilterModel =
      ValueNotifier<List<FilterModel>>([]);
  final ValueNotifier<bool> isFilterSelected = ValueNotifier<bool>(false);
  TrainingsDataSuccess trainingsDataSuccess = TrainingsDataSuccess();
  List<Courses> coursesData = [];
  List<Courses> backupData = [];
  TrainingBloc() : super(TrainingInitial()) {
    on<FetchTrainingsList>(_fetchTrainingsList);
    on<FilterTrainingsList>(_filterTrainingList);
    on<UpdateEnrolmentStatus>(_updateEnrolmentStatus);
  }

  Map<String, dynamic> _createFilterMap(String label) =>
      {"label": label, "isSelected": false};

  Future<void> _fetchTrainingsList(
      FetchTrainingsList event, Emitter<TrainingState> emit) async {
    emit(TrainingsDataLoading());

    final dataResponse = await TrainingRepository().getTrainingsData();
    coursesData =
        List<Courses>.from(dataResponse.response?.courses ?? <Courses>[]);
    backupData = List<Courses>.of(coursesData);
    final highlightCourses = List<Courses>.from(coursesData
        .where((element) => element.showInHighlights == true)
        .toList());
    emit(trainingsDataSuccess
      ..courses = coursesData
      ..highlightsCourses = highlightCourses);
    final locationSet = <String>{};
    final trainerNameSet = <String>{};
    final trainingNameSet = <String>{};

    for (var course in coursesData) {
      final trainingDetails = course.trainingDetails;
      if (trainingDetails != null) {
        if (trainingDetails.city != null) {
          locationSet.add(trainingDetails.city!);
        }
        if (trainingDetails.name != null) {
          trainingNameSet.add(trainingDetails.name!);
        }
      }
      if (course.speakerName != null) {
        trainerNameSet.add(course.speakerName!);
      }
    }

    List<Map<String, dynamic>> createFilterList(Set<String> values) =>
        values.map(_createFilterMap).toList();
    selectedFilterModel.value = [
      FilterModel.fromJson(
          {"filterName": "Location", "filter": createFilterList(locationSet)}),
      FilterModel.fromJson({
        "filterName": "Training Name",
        "filter": createFilterList(trainingNameSet)
      }),
      FilterModel.fromJson(
          {"filterName": "Trainer", "filter": createFilterList(trainerNameSet)})
    ];
  }

  Future<void> _filterTrainingList(
      FilterTrainingsList event, Emitter<TrainingState> emit) async {
    emit(TrainingsDataLoading());
    await _filterData();
    emit(trainingsDataSuccess..courses = coursesData);
  }

  Future<void> _filterData() async {
    List<Courses> courses = backupData;
    final locationFilter = <String>{};
    final trainingNameFilter = <String>{};
    final trainerFilter = <String>{};

    for (var filterData in selectedFilterModel.value) {
      final selectedItems = filterData.filter!
          .where((filter) => filter.isSelected! && filter.label != null)
          .map((filter) => filter.label!);

      switch (filterData.filterName) {
        case "Location":
          locationFilter.addAll(selectedItems);
          break;
        case "Training Name":
          trainingNameFilter.addAll(selectedItems);
          break;
        case "Trainer":
          trainerFilter.addAll(selectedItems);
          break;
      }
    }

    if (locationFilter.isNotEmpty ||
        trainingNameFilter.isNotEmpty ||
        trainerFilter.isNotEmpty) {
      courses = courses.where((course) {
        final trainingDetails = course.trainingDetails;
        return (locationFilter.isEmpty ||
                (trainingDetails?.city != null &&
                    locationFilter.contains(trainingDetails!.city))) &&
            (trainingNameFilter.isEmpty ||
                (trainingDetails?.name != null &&
                    trainingNameFilter.contains(trainingDetails!.name))) &&
            (trainerFilter.isEmpty ||
                (course.speakerName != null &&
                    trainerFilter.contains(course.speakerName)));
      }).toList();
      isFilterSelected.value = true;
    } else {
      isFilterSelected.value = false;
    }
    coursesData = List<Courses>.from(courses);
  }

  Future<void> _updateEnrolmentStatus(
      UpdateEnrolmentStatus event, Emitter<TrainingState> emit) async {
    emit(TrainingsDataLoading());
    final resultData =
        coursesData.firstWhere((element) => element.id == event.id);
    resultData.enrolmentStatus = AppConstants.enroledStatus;
    final resultBackupData =
        backupData.firstWhere((element) => element.id == event.id);
    resultBackupData.enrolmentStatus = AppConstants.enroledStatus;
    final resultLiveData = trainingsDataSuccess.courses!
        .firstWhere((element) => element.id == event.id);
    resultLiveData.enrolmentStatus = AppConstants.enroledStatus;
    emit(trainingsDataSuccess..courses = coursesData);
  }
}
