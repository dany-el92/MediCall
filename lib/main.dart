import 'package:flutter/material.dart';
import 'package:medicall/authentication/auth_service.dart';
import 'package:medicall/constants/colors.dart';
import 'package:medicall/constants/routes.dart';
import 'package:medicall/views/auth/login_view.dart';
import 'package:medicall/views/auth/verify_email_view.dart';
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
        //initialRoute: Routes.verifyMailView,
        home: const HomePage(),
        routes: {
          Routes.loginView: (context) => const LoginView(),
          Routes.registerView: (context) => const RegisterView(),
          Routes.mainView: (context) => const MainView(),
          Routes.splashScreen: (context) => const SplashScreen(),
          Routes.receiptView: (context) => const PrescriptionView(),
          Routes.verifyMailView: (context) => const VerifyEmailView(),
        });
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            //Quando la future è andata a buon fine, restituisco un widget
            case ConnectionState.done:
              final user = AuthService.firebase().currentUser;
              if (user != null) {
                if (user.isEmailVerified) {
                  return const MainView();
                } else {
                  return const VerifyEmailView();
                }
              } else {
                return const LoginView();
              }

            default:
              return const CircularProgressIndicator();
          }
        },
        future: AuthService.firebase().initialize());
  }
}
