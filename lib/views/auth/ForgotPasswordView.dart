import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medicall/authentication/auth_exceptions.dart';
import 'package:medicall/authentication/auth_service.dart';
import 'package:medicall/components/custom_text_form_field.dart';
import 'package:medicall/constants/colors.dart';
import 'package:medicall/constants/images.dart';
import 'package:medicall/constants/routes.dart';
import 'package:medicall/utilities/extensions.dart';
import 'package:medicall/utilities/show_dialogs.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final TextEditingController _emailController;

  //rimuovere dopo aver finito
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              ImageConstant.forgotPasswordImage,
              height: 180,
              width: 180,
            ),
            const SizedBox(height: 20),
            const Text(
              'Inserisci la tua email',
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
                "Inserisci la tua mail per ricevere un link per il reset della password.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomTextFormField(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                textInputAction: TextInputAction.next,
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
                suffixIcon: const Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Icon(
                    Icons.email,
                  ),
                ),
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email non inserita';
                  }
                  return null;
                },
              ),
            ),
            //const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  await AuthService.firebase().sendPasswordResetEmail(
                      email: _emailController.text.trim());
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                          'Email di reset inviata correttamente! Controlla la tua casella di posta'),
                      backgroundColor: Colors.green,
                      dismissDirection: DismissDirection.down,
                    ),
                  );
                } on InvalidEmailAuthException {
                  await showErrorDialog(context, 'Email non valida');
                } on GenericAuthException {
                  await showErrorDialog(
                      context, 'Errore durante l\'invio della mail di reset');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.oro,
                foregroundColor: Colors.black,
                shadowColor: Colors.black,
                elevation: 20,
              ),
              child: const Text(
                'Invia mail di reset',
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
