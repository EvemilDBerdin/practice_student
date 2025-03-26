import 'package:flutter/material.dart';

class AppConstants {
  AppConstants._();

  static final navigationKey = GlobalKey<NavigatorState>();

  static final RegExp emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.([a-zA-Z]{2,})+",
  );

  static final RegExp passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$#!%*?&_])[A-Za-z\d@#$!%*?&_].{7,}$',
  );

  static const String baseUrl = "http://192.168.30.138/practice_api";
  static const String authUrl = "$baseUrl/auth.php";

  final headerStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
  final titleStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  final titleStyle2 = TextStyle(fontSize: 16, color: Colors.black45);
  final subtitleStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
  final infoStyle = TextStyle(fontSize: 12, color: Colors.black54);

  //Decoration
  final roundedRectangle12 = RoundedRectangleBorder(
    borderRadius: BorderRadiusDirectional.circular(12),
  );

  final roundedRectangle4 = RoundedRectangleBorder(
    borderRadius: BorderRadiusDirectional.circular(4),
  );

  final roundedRectangle40 = RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
  );
}