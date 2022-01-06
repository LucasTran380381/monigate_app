import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monigate_app/common/providers/bottom_navigation_index_provider.dart';
import 'package:monigate_app/common/service/notification_service.dart';
import 'package:monigate_app/common/themes/bottom_navigation_theme.dart';
import 'package:monigate_app/common/themes/button_theme.dart';
import 'package:monigate_app/common/themes/color.dart';
import 'package:monigate_app/common/themes/input_theme.dart';
import 'package:monigate_app/common/widgets/splash_page.dart';
import 'package:monigate_app/home/logic/checkin_provider.dart';
import 'package:monigate_app/i18n/app_translation.dart';

Future<void> main() async {
  await GetStorage.init();
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const ProviderScope(child: MyApp()));
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  final statusCode = message.data['checkinStatusCode'];
  final container = ProviderContainer();
  if (statusCode != null) {
    container.read(bottomNavigationIndexProvider.notifier).selectIndex(0);
    container.read(checkinProvider.notifier).fetchCheckin();
    container.read(notificationServiceProvider).showNotification('Trạng thái Checkin', 'Đã cập nhật checkin', '/home');
  }
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
          elevatedButtonTheme: elevatedButtonTheme,
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: AppColor.primaryColor, //thereby
          ),
          inputDecorationTheme: inputTheme,
          cardTheme: const CardTheme(
            elevation: 10,
          ),
          progressIndicatorTheme: const ProgressIndicatorThemeData(circularTrackColor: AppColor.primaryColor),
          shadowColor: AppColor.primaryColor.withOpacity(0.3),
          primaryColor: AppColor.primaryColor,
          bottomNavigationBarTheme: bottomNavigationTheme,
          appBarTheme: AppBarTheme(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              )),
              centerTitle: true,
              titleTextStyle: Theme.of(context).textTheme.headline5!.merge(const TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
              backgroundColor: const Color(0xFF0C9869),
              foregroundColor: Colors.white),
          textTheme: GoogleFonts.workSansTextTheme(
            Theme.of(context).textTheme,
          ).copyWith(headline5: const TextStyle(fontWeight: FontWeight.w800), headline4: const TextStyle(fontWeight: FontWeight.w800))),
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
      locale = language == 'vn' ? const Locale('vn', 'VN') : const Locale('en', 'US');
    }
    return locale;
  }

  _initLanguage(GetStorage box) {
    box.write('language', 'vn');
  }
}
