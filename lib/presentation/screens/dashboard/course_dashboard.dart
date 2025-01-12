import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainings/core/app_colors.dart';
import 'package:trainings/core/app_constants.dart';
import 'package:trainings/presentation/bloc/training_bloc.dart';
import 'package:trainings/presentation/screens/dashboard/widgets/sort_filter_widget.dart';

import '../../../core/app_utils.dart';
import '../../../data/models/sort_filter_model.dart';
import '../details/course_detail_view.dart';
import 'widgets/custom_app_bar.dart';
import 'widgets/custom_flexible_appbar.dart';
import 'widgets/list_item_widget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late TrainingBloc _trainingBloc;

  @override
  void initState() {
    _trainingBloc = BlocProvider.of<TrainingBloc>(context);
    _trainingBloc.add(FetchTrainingsList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70.withOpacity(0.9),
      body: CustomScrollView(
        slivers: [
          BlocBuilder<TrainingBloc, TrainingState>(
            bloc: _trainingBloc,
            builder: (context, state) {
              return SliverAppBar(
                backgroundColor: AppColors.primaryColor,
                title: const CustomAppBar(),
                expandedHeight: (state is TrainingsDataSuccess &&
                        state.highlightsCourses!.isNotEmpty)
                    ? 300
                    : 50,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: (state is TrainingsDataSuccess &&
                          state.highlightsCourses!.isNotEmpty)
                      ? CustomFlexibleAppBar(
                          courses: state.highlightsCourses,
                          trainingBloc: _trainingBloc,
                        )
                      : const SizedBox(),
                ),
              );
            },
          ),
          _filterBtn(),
          _listView(),
        ],
      ),
    );
  }

  SliverToBoxAdapter _filterBtn() {
    return SliverToBoxAdapter(
      child: Container(
        height: 45,
        color: Colors.white,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 18),
        child: Align(
          alignment: Alignment.topLeft,
          child: GestureDetector(
            child: Container(
              height: 30,
              width: 75,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey)),
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Row(
                children: [
                  ValueListenableBuilder<bool>(
                      valueListenable: _trainingBloc.isFilterSelected,
                      builder: (context, val, _) {
                        return Stack(
                          children: [
                            const Icon(
                              Icons.filter_list,
                              color: Colors.grey,
                              size: 18,
                            ),
                            if (val)
                              Positioned(
                                top: 2,
                                right: 1,
                                child: Container(
                                  width: 5,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              )
                          ],
                        );
                      }),
                  const SizedBox(
                    width: 6,
                  ),
                  const Text(
                    AppConstants.filter,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            onTap: () {
              _showFilterBottomSheet();
            },
          ),
        ),
      ),
    );
  }

  BlocBuilder _listView() {
    return BlocBuilder<TrainingBloc, TrainingState>(
      bloc: _trainingBloc,
      builder: (context, state) {
        if (state is TrainingsDataSuccess) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListItem(
                    key: ValueKey(state.courses![index].id),
                    courses: state.courses![index],
                    onTap: () {
                      Navigator.of(context)
                          .push(AppUtils().pageRoute(BlocProvider.value(
                        value: _trainingBloc,
                        child:
                            TrainingsDetailPage(courses: state.courses![index]),
                      )));
                    });
              },
              childCount: state.courses!.length,
            ),
          );
        }
        return const SliverToBoxAdapter();
      },
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<TrainingBloc, TrainingState>(
          bloc: _trainingBloc,
          builder: (context, state) {
            return ValueListenableBuilder<List<FilterModel>>(
                valueListenable: _trainingBloc.selectedFilterModel,
                builder: (context, filterModel, _) {
                  return SortFilter(
                      initialFilterModel: filterModel,
                      onSelectFilterCallback: onSelectFilter);
                });
          },
        );
      },
    );
  }

  void onSelectFilter() {
    _trainingBloc.add(FilterTrainingsList());
  }
}
