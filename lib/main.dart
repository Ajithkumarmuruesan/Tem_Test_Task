import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:tem_assessment_firebase/controllers/dashboard_controller.dart';
import 'package:tem_assessment_firebase/controllers/fibo_dashboard_controller.dart';
import 'package:tem_assessment_firebase/controllers/sub_bal_dashboard_controller.dart';
import 'package:tem_assessment_firebase/view/bal_sub_dashboard/sub_bal_dashboard_view.dart';
import 'package:tem_assessment_firebase/view/common/splash_view/splash_view.dart';
import 'package:tem_assessment_firebase/view/fibonacci_module/fibonacci_dashboard_view.dart';
import 'package:tem_assessment_firebase/view/file_upload_module/dashboard_view/dashboard_view.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(
      value: DashBoardController(),
    ),
    ChangeNotifierProvider.value(
      value: FibonacciDashBoardController(),
    ),
    ChangeNotifierProvider.value(
      value: SubBalDashBoardController(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tem Tech',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashView(),
        '/filedashboard': (context) => DashboardView(),
        '/fibdashboard': (context) => FibonacciDashboardView(),
        '/subbaldashboard': (context) => SubBalDashBoardView(),
      },
      builder: EasyLoading.init(),
    );
  }
}
