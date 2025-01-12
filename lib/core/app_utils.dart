import 'package:flutter/material.dart';

class AppUtils {
  Route pageRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  String profileUrl(int id) => "https://picsum.photos/id/$id/200";
  String hightlightsImgUrl(int id) => "https://picsum.photos/id/$id/200?blur=2";
}
