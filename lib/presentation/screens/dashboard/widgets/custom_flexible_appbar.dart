import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainings/core/app_colors.dart';
import 'package:trainings/core/app_constants.dart';
import 'package:trainings/presentation/bloc/training_bloc.dart';

import '../../../../core/app_utils.dart';
import '../../../../data/models/training_model.dart';
import '../../details/course_detail_view.dart';

class CustomFlexibleAppBar extends StatefulWidget {
  const CustomFlexibleAppBar({Key? key, this.courses, this.trainingBloc})
      : super(key: key);
  final List<Courses>? courses;
  final TrainingBloc? trainingBloc;

  @override
  State<CustomFlexibleAppBar> createState() => _CustomFlexibleAppBarState();
}

class _CustomFlexibleAppBarState extends State<CustomFlexibleAppBar>
    with TickerProviderStateMixin {
  late PageController _pageViewController;
  int _slideIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
  }

  void _updateCurrentPageIndex(int index) {
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _handlePageViewChanged(int currentPageIndex) {
    setState(() {
      _slideIndex = currentPageIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
              ),
            ),
            Container(
              height: 90,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            ),
          ],
        ),
        Positioned(
          top: 75,
          bottom: 0,
          child: _highlights(),
        )
      ],
    );
  }

  Column _highlights() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 18.0),
          child: Text(
            AppConstants.highlights,
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.center,
          child: Row(
            children: [
              GestureDetector(
                child: Container(
                  height: 70,
                  width: 25,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      backgroundBlendMode: BlendMode.darken),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  if (_slideIndex == 0) {
                    return;
                  }
                  _updateCurrentPageIndex(_slideIndex - 1);
                },
              ),
              const SizedBox(
                width: 15,
              ),
              SizedBox(
                height: 150,
                width: MediaQuery.of(context).size.width - 80,
                child: PageView.builder(
                  controller: _pageViewController,
                  onPageChanged: _handlePageViewChanged,
                  itemCount: widget.courses!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Container(
                        height: 20,
                        alignment: Alignment.centerLeft,
                        padding:
                            const EdgeInsets.only(top: 45, left: 12, right: 12),
                        width: MediaQuery.of(context).size.width - 80,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.5),
                                BlendMode.darken),
                            fit: BoxFit.cover,
                            image: NetworkImage(AppUtils()
                                .hightlightsImgUrl(widget.courses![index].id!)),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.courses![index].trainingDetails!.name!,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 20,
                                      letterSpacing: 1.4,
                                      color: Colors.white),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                children: [
                                  Text(
                                    "${widget.courses![index].trainingDetails!.city!},",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        letterSpacing: 1.2,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    widget
                                        .courses![index].trainingDetails!.date!,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        letterSpacing: 1.2,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${AppConstants.indianRupeeSymbol}${widget.courses![index].trainingDetails!.previousPrice!}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                decorationThickness: 2,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: AppColors.primaryColor),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        "${AppConstants.indianRupeeSymbol}${widget.courses![index].trainingDetails!.fee!}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 18,
                                                color: AppColors.primaryColor),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: const [
                                      Text(
                                        AppConstants.viewDetails,
                                        style: TextStyle(
                                            fontSize: 13,
                                            letterSpacing: 1.1,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                      SizedBox(width: 4),
                                      Icon(
                                        Icons.arrow_forward_outlined,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context)
                            .push(AppUtils().pageRoute(BlocProvider.value(
                          value: widget.trainingBloc!,
                          child: TrainingsDetailPage(
                              courses: widget.courses![index]),
                        )));
                      },
                    );
                  },
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              GestureDetector(
                child: Container(
                  height: 70,
                  width: 25,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      backgroundBlendMode: BlendMode.darken),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  if (_slideIndex == (widget.courses!.length - 1)) {
                    return;
                  }
                  _updateCurrentPageIndex(_slideIndex + 1);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
