import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const Color primaryColor = Color(0xffBAE162);
  // static const Color primaryColor = Color.fromRGBO(237, 28, 36, 1);
  static const Color darkBlue = Color(0xff1E2E3D);
  static const Color darkerBlue = Color(0xff152534);
  static const Color darkestBlue = Color(0xff0C1C2E);
  static const Color successResponse = Color.fromARGB(195, 0, 233, 12);
  static const Color errorResponse = Color.fromARGB(223, 255, 0, 0);

  static const List<Color> defaultGradient = [
    Color.fromARGB(255, 165, 0, 0),
    Color.fromARGB(255, 226, 74, 63),
    Color.fromARGB(255, 255, 0, 0),
  ];
}