import 'package:flutter/material.dart';
import 'package:trainings/core/app_constants.dart';
import 'package:trainings/core/app_utils.dart';

import '../../../../data/models/training_model.dart';
import 'vertical_dashed_line.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    this.courses,
    this.onTap,
  }) : super(key: key);
  final Courses? courses;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      key: key,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: GestureDetector(
        child: Material(
          shadowColor: Colors.white70,
          elevation: 2,
          child: Container(
            height: 180,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            courses!.trainingDetails!.date!,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Text(
                              courses!.trainingDetails!.time!,
                              style: const TextStyle(
                                  fontSize: 11, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        courses!.trainingDetails!.place!,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                const VerticalDashedLine(),
                Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          courses!.fillingStatus!,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: Colors.redAccent.shade200),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                courses!.trainingDetails!.name!,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 17,
                                    ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "(${courses!.reviews})",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18),
                            )
                          ],
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(
                                  AppUtils().profileUrl(courses!.id!)),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  AppConstants.keyNoteSpearker,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  courses!.speakerName!,
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            )
                          ],
                        ),
                        const Spacer(),
                        _enrolNowBtn()
                      ],
                    ))
              ],
            ),
          ),
        ),
        onTap: () {
          if (onTap != null) onTap!();
        },
      ),
    );
  }

  Align _enrolNowBtn() {
    return Align(
      alignment: Alignment.bottomRight,
      child: courses!.enrolmentStatus == AppConstants.enroledStatus
          ? _enroledBtn()
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent.shade200,
                minimumSize: const Size(80, 32),
              ),
              onPressed: () {
                if (onTap != null) onTap!();
              },
              child: const Text(
                AppConstants.enrolNow,
                style: TextStyle(fontWeight: FontWeight.w700),
              )),
    );
  }

  Padding _enroledBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Icons.check_circle_outline,
            color: Colors.green,
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            "Enroled!",
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
