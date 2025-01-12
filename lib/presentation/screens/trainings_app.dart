import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/app_constants.dart';
import '../bloc/training_bloc.dart';
import 'dashboard/course_dashboard.dart';

class TrainingsApp extends StatelessWidget {
  const TrainingsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appTitle,
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => TrainingBloc(),
        child: const Dashboard(),
      ),
    );
  }
}
