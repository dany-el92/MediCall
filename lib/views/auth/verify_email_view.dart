import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicall/authentication/auth_service.dart';
import 'package:medicall/constants/colors.dart';
import 'package:medicall/constants/images.dart';
import 'package:medicall/constants/routes.dart';
import 'package:medicall/utilities/extensions.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
    });
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              ImageConstant.mailImage,
              height: 180,
              width: 180,
            ),
            const SizedBox(height: 20),
            const Text(
              'Controlla la tua email',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              child: Text(
                "Ti è stata inviata un'email di verifica per il tuo account."
                " Per completare il processo, clicca sul link presente nella mail."
                " \n\n Se non hai ricevuto l'email di verifica, fai clic sul bottone sottostante.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
            //const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await AuthService.firebase().sendEmailVerification();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.oro,
                foregroundColor: Colors.black,
                shadowColor: Colors.black,
                elevation: 20,
              ),
              child: const Text(
                'Invia mail di verifica',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Hai già un account?',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.loginView, (route) => false);
                  },
                  child: const Text(
                    'Accedi',
                    style: TextStyle(
                      color: AppColors.oro,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
