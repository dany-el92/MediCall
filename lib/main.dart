import 'package:flutter/material.dart';
import 'package:medicall/views/accedi_screen.dart';
import 'package:medicall/views/main_screen.dart';
import 'package:medicall/views/splash_screen.dart';
import 'package:medicall/views/registrati_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

// test

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediCall',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/' :(context) =>const SplashScreen(),
        '/accedi' :(context) => const AccediScreen(),
        '/registrati':(context) => const RegistratiScreen(),
        '/mainpage':(context)=> const MainScreen(),
      }
    );
  }
}
