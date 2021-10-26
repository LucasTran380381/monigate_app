import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monigate_app/i18n/app_translation.dart';
import 'package:monigate_app/util.dart';
import 'package:monigate_app/views/splash_page.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: AppTranslation(),
      locale: getLocale(),
      title: 'Moni Gate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                elevation: 10,
                splashFactory: NoSplash.splashFactory,
                primary: Util.primaryColor),
          ),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Util.primaryColor, //thereby
          ),
          inputDecorationTheme: const InputDecorationTheme(
              floatingLabelStyle: TextStyle(color: Util.primaryColor),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Util.primaryColor)),
              hoverColor: Util.primaryColor,
              fillColor: Util.primaryColor,
              focusColor: Util.primaryColor),
          cardTheme:
              const CardTheme(elevation: 10, shadowColor: Util.primaryColor),
          progressIndicatorTheme: const ProgressIndicatorThemeData(
              circularTrackColor: Util.primaryColor),
          shadowColor: Util.primaryColor.withOpacity(0.3),
          primaryColor: Util.primaryColor,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Util.primaryColor,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: false,
          ),
          appBarTheme: AppBarTheme(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(24),
                bottomLeft: Radius.circular(24),
              )),
              centerTitle: true,
              toolbarHeight: 140,
              titleTextStyle: Theme.of(context).textTheme.headline5!.merge(
                  const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w800)),
              backgroundColor: const Color(0xFF0C9869),
              foregroundColor: Colors.white),
          textTheme: GoogleFonts.workSansTextTheme(
            Theme.of(context).textTheme,
          ).copyWith(
              headline5: const TextStyle(fontWeight: FontWeight.w800),
              headline4: const TextStyle(fontWeight: FontWeight.w800))),
      home: const SplashPage(),
    );
  }

  getLocale() {
    Locale locale;
    final box = GetStorage();
    final String? language = box.read('language');
    if (language == null) {
      _initLanguage(box);
      locale = const Locale('vn', 'VN');
    } else {
      locale = language == 'vn'
          ? const Locale('vn', 'VN')
          : const Locale('en', 'US');
    }
    return locale;
  }

  _initLanguage(GetStorage box) {
    box.write('language', 'vn');
  }
}
