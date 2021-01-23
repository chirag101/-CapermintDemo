import 'package:chirag_patel_23_jan_2021/resourse/app_colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends PreferredSize {
  final Widget child;
  final double height;

  CustomAppBar({@required this.child, this.height = kToolbarHeight});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: AppColors.textColorBlue,
      alignment: Alignment.center,
      child: child,
    );
  }
}
