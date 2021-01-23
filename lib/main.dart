import 'package:chirag_patel_23_jan_2021/bloc/image/image_bloc.dart';
import 'package:chirag_patel_23_jan_2021/data/repository/image_repository.dart';
import 'package:chirag_patel_23_jan_2021/resourse/app_colors.dart';
import 'package:chirag_patel_23_jan_2021/routes.dart';
import 'package:chirag_patel_23_jan_2021/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Chirag Practical 23 01 2021",
      theme: ThemeData(
          scaffoldBackgroundColor: AppColors.default_background,
          primaryColor: AppColors.textColorBlue,
          accentColor: AppColors.default_background),
      routes: Routes.routes,
      supportedLocales: [
        Locale('en'),
      ],
      home: BlocProvider( create: (context) => ImageBloc(repository: ImageRepositoryImpl()),
        child: HomeScreen(),
      ),
    );
  }
}
