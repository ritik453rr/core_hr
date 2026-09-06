import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:core_hr/core/app_theme/app_theme.dart';
import 'package:core_hr/core/routing/app_pages.dart';
import 'package:core_hr/core/routing/app_routes.dart';
import 'package:get_storage/get_storage.dart';

import 'package:toastification/toastification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await dotenv.load(fileName: ".env");
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
      ),
    );
  }
}
