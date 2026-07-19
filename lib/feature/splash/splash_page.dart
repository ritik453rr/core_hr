import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'splash_controller.dart';

class SplashPage extends StatelessWidget {
  SplashPage({super.key});

  final controller = Get.find<SplashController>();
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("Splash Screen")));
  }
}
