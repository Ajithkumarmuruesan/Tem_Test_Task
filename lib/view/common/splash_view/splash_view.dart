import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:tem_assessment_firebase/view/common/start_view/start_view.dart';
import 'package:tem_assessment_firebase/view/file_upload_module/dashboard_view/dashboard_view.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      duration: 5000,
      textType: TextType.ColorizeAnimationText,
      textStyle: TextStyle(
          fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.black),
      text: "TEM",
      backgroundColor: Color(0xFFf5eded),
      navigateRoute: StartView(),
    );
  }
}
