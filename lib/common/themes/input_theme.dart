import 'package:flutter/material.dart';

import 'color.dart';

const inputTheme = InputDecorationTheme(
    floatingLabelStyle: TextStyle(color: AppColor.primaryColor),
    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColor.primaryColor)),
    hoverColor: AppColor.primaryColor,
    fillColor: AppColor.primaryColor,
    focusColor: AppColor.primaryColor);
