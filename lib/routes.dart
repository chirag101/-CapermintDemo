import 'package:chirag_patel_23_jan_2021/ui/home_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  static const String new_screen = "/new_screen";

  static final routes = <String, WidgetBuilder>{
    new_screen: (BuildContext context) => HomeScreen(),
  };
}
