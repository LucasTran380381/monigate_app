import 'package:flutter/material.dart';

import 'color.dart';

final elevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(elevation: 10, splashFactory: NoSplash.splashFactory, primary: AppColor.primaryColor),
);
