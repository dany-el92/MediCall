import 'package:flutter/material.dart';
import 'package:medicall/constants/colors.dart';
import 'package:medicall/constants/routes.dart';
import 'package:medicall/views/auth/login_view.dart';
import 'package:medicall/views/main_view.dart';
import 'package:medicall/views/auth/register_view.dart';
import 'package:medicall/views/prescription_view.dart';
import 'package:medicall/views/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class SnackBarService {
  static final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  static void showSnackBar({required String content}) {
    scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(content)));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        scaffoldMessengerKey: SnackBarService.scaffoldKey,
        title: 'MediCall',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.bluScuro),
          useMaterial3: true,
        ),
        initialRoute: Routes.mainView,
        routes: {
          Routes.loginView: (context) => const LoginView(),
          Routes.registerView: (context) => const RegisterView(),
          Routes.mainView: (context) => const MainView(),
          Routes.splashScreen: (context) => const SplashScreen(),
          Routes.receiptView: (context) => const PrescriptionView(),
        });
  }
}
