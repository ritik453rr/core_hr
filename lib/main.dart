import 'package:core_hr/core/services/notification_service/local_notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:core_hr/core/constants/app_theme.dart';
import 'package:core_hr/core/routing/app_pages.dart';
import 'package:core_hr/core/routing/app_routes.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toastification/toastification.dart';
import 'core/services/background_service/background_service.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await dotenv.load(fileName: ".env");
  await configuredBackgroundService();
  await LocalNotificationService.initializeLocalNotification();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        getPages: AppPages.pages,
        initialRoute: AppRoutes.splash,
        defaultTransition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 350),
      ),
    );
  }
}
