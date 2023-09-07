import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../values/colors.dart';
import '../values/strings.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    Key? key,
    this.title = Strings.APP_TITLE,
    this.titleColor,
    this.titleStyle,
    this.fontSize = 50,
  }) : super(key: key);

  final String title;
  final TextStyle? titleStyle;
  final Color? titleColor;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: titleStyle ??
          GoogleFonts.bungeeTextTheme().headlineMedium!.copyWith(
                color: titleColor ?? AppColors.primaryColor,
                fontSize: fontSize,
              ),
    );
  }
}
