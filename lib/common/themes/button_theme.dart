import 'package:flutter/material.dart';

import '../../util.dart';

final elevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(elevation: 10, splashFactory: NoSplash.splashFactory, primary: Util.primaryColor),
);
