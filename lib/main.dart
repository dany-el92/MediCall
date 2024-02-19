import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:medicall/authentication/auth_service.dart';
import 'package:medicall/constants/colors.dart';
import 'package:medicall/constants/routes.dart';
import 'package:medicall/messaging/firebase_cloud_messaging.dart';
import 'package:medicall/database/utente.dart';
import 'package:medicall/utilities/api_services.dart';
import 'package:medicall/views/auth/forgot_password_view.dart';
import 'package:medicall/views/auth/login_view.dart';
import 'package:medicall/views/auth/verify_email_view.dart';
import 'package:medicall/views/calendar_view.dart';
import 'package:medicall/views/main_view.dart';
import 'package:medicall/views/auth/register_view.dart';
import 'package:medicall/views/prescription_view.dart';
import 'package:medicall/views/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  initializeDateFormatting('it_IT', null);
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
        // initialRoute: Routes.loginView,
        home: const HomePage(),
        routes: {
          Routes.loginView: (context) => const LoginView(),
          Routes.registerView: (context) => const RegisterView(),
          //  Routes.mainView: (context) => const MainView(),
          Routes.splashScreen: (context) => const SplashScreen(),
          Routes.receiptView: (context) => const PrescriptionView(),
          Routes.calendarView: (context) => const CalendarView(),
          Routes.verifyMailView: (context) => const VerifyEmailView(),
          Routes.forgotPasswordView: (context) => const ForgotPasswordView(),
        });
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Utente? u;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("email");
    String? password = prefs.getString("password");
    if (email != null && password != null) {
      Utente? y = await APIServices.getUtente(email, password);
      setState(() {
        u = y;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            //Quando la future è andata a buon fine, restituisco un widget
            case ConnectionState.done:
              CloudMessaging().initNotification();
              final user = AuthService.firebase().currentUser;
              if (user != null) {
                if (user.isEmailVerified && u != null) {
                //  CloudMessaging().initNotification();
                  return MainView(utente: u!);
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
