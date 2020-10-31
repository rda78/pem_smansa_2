import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils {
  static var context;
  static void init(ctx) {
    context = ctx;
  }

  static MediaQueryData mediaQueryData() => MediaQuery.of(context);

  static TextTheme textTheme() => Theme.of(context).textTheme;

  static double width(var percentage) => MediaQuery.of(context).size.width * percentage / 100;

  static double height(var percentage) => MediaQuery.of(context).size.height * percentage / 100;
}