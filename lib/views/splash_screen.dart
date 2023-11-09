import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicall/constants/colors.dart';
import 'package:medicall/constants/routes.dart';
import 'package:medicall/utilities/extensions.dart';
import 'package:medicall/constants/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _AccediScreenState();
}

class _AccediScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // scompaiono i bottoni di sistema
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pushReplacementNamed(Routes.loginView);
    });
  }

  @override
  void dispose() {
    //riappaiono i bottoni di sistema
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = context.mediaQuerySize;
    return Scaffold(
        body: Container(
            width: size.width,
            height: size.height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment(0.5, 0),
                    end: Alignment(0.5, 1),
                    colors: [
                  AppColors.bluChiaro,
                  AppColors.bluMedio,
                  AppColors.bluScuro,
                ])),
            child: Column(children: [
              const Spacer(flex: 2),
              Image.asset(ImageConstant.imgLogo),
              const Spacer(
                flex: 2,
              )
            ])));
  }
}
