import 'package:flutter/material.dart';
import 'package:trainings/core/app_constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const Text(
          AppConstants.appTitle,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            letterSpacing: 2,
            fontWeight: FontWeight.w700,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
      ],
    );
  }
}
