import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainings/core/app_colors.dart';

import '../../../core/app_constants.dart';
import '../../../data/models/training_model.dart';
import '../../bloc/training_bloc.dart';

class TrainingsDetailPage extends StatefulWidget {
  const TrainingsDetailPage({Key? key, this.courses}) : super(key: key);
  final Courses? courses;

  @override
  State<TrainingsDetailPage> createState() => _TrainingsDetailPageState();
}

class _TrainingsDetailPageState extends State<TrainingsDetailPage> {
  late TrainingBloc _trainingBloc;

  @override
  void initState() {
    _trainingBloc = BlocProvider.of<TrainingBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white70.withOpacity(0.9),
        actions: [
          _closeBtn(context),
        ],
      ),
      bottomNavigationBar: _enrolNowBtn(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _header(),
            _enrolReviews(),
            _summary(),
            _trainingDetails()
          ],
        ),
      ),
    );
  }

  IconButton _closeBtn(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.close,
        color: Colors.black,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Padding _header() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.blue.shade200,
            Colors.red.shade300,
          ],
        )),
        height: 160,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.courses!.trainingDetails!.name!,
              style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: Colors.white),
            ),
            Row(
              children: [
                const Text(
                  AppConstants.trainer,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w800),
                ),
                const SizedBox(width: 6),
                Text(
                  widget.courses!.speakerName!,
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w800),
                ),
                const Spacer(),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: Text(
                    widget.courses!.fillingStatus!,
                    style: const TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Padding _enrolReviews() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Material(
        shadowColor: Colors.white70,
        elevation: 6,
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      const Text(
                        AppConstants.enrolFee,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.black54),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "${AppConstants.indianRupeeSymbol} ${widget.courses!.trainingDetails!.fee}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const VerticalDivider(
                thickness: 1.8,
                indent: 10,
                endIndent: 10,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      const Text(
                        AppConstants.reviews,
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 20,
                            fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            color: AppColors.primaryColor,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            widget.courses!.reviews.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding _summary() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Material(
        shadowColor: Colors.white70,
        elevation: 2,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                AppConstants.aboutTraining,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              const SizedBox(height: 12),
              Text(
                widget.courses!.trainingDetails!.description!,
                style: const TextStyle(
                    height: 1.8, fontSize: 16, color: Colors.black87),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding _trainingDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppConstants.trainingDetails,
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black54),
          ),
          const SizedBox(
            height: 6,
          ),
          Card(
            elevation: 2,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.date_range,
                        color: Colors.black38,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                          child: Wrap(
                        runSpacing: 3,
                        children: [
                          Text(widget.courses!.trainingDetails!.date!,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(width: 4),
                          Text("(${widget.courses!.trainingDetails!.time!})",
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500))
                        ],
                      )),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.black38,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(widget.courses!.trainingDetails!.place!,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _enrolNowBtn(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              left: BorderSide.none,
              right: BorderSide.none,
              bottom: BorderSide.none,
              top: BorderSide(color: Color(0xFFE0E0E0)))),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent.shade200,
            minimumSize: const Size(80, 50),
          ),
          onPressed: widget.courses!.enrolmentStatus == AppConstants.enroledStatus
              ? null
              : () {
                  _showSuccessMsg();
                  _trainingBloc.add(UpdateEnrolmentStatus(widget.courses!.id!));
                  Navigator.of(context).pop();
                },
          child: Text(
            widget.courses!.enrolmentStatus == AppConstants.enroledStatus
                ? AppConstants.alreadyEnroled
                : AppConstants.enrolNow,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
          )),
    );
  }

  _showSuccessMsg() {
    const snackBar = SnackBar(
      backgroundColor: Colors.green,
      content: Text(
        AppConstants.snackBarSuccessMsg,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
