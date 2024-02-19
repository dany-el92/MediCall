import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicall/authentication/auth_exceptions.dart';
import 'package:medicall/authentication/auth_service.dart';
import 'package:medicall/components/custom_text_form_field.dart';
import 'package:medicall/constants/colors.dart';
import 'package:medicall/database/utente.dart';
import 'package:medicall/utilities/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:medicall/utilities/extensions.dart';
import 'package:medicall/constants/routes.dart';
import 'package:medicall/utilities/show_dialogs.dart';
import 'package:medicall/views/main_view.dart';

import '../../constants/images.dart';

final _formKey = GlobalKey<FormState>();

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool isObscure = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.1),
                  Image.asset(ImageConstant.imgLogo),
                  SizedBox(height: size.height * 0.1),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      //Input Email
                      CustomTextFormField(
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
                      SizedBox(height: size.height * 0.02),
                      //Input Password
                      CustomTextFormField(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        textInputAction: TextInputAction.done,
                        labelText: 'Password',
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: isObscure,
                        suffixIcon: IconButton(
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                          style: IconButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Icon(
                              isObscure
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        controller: _passwordController,
                        validator: null,
                      ),
              /*        TextButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(context,
                              Routes.forgotPasswordView, (route) => false);
                        },
                        child: const Text(
                          'Hai dimenticato la Password?',
                          style: TextStyle(
                            color: AppColors.oro,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                 */     SizedBox(height: size.height * 0.05),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.black,
                          elevation: 20,
                          backgroundColor: AppColors.oro,
                          foregroundColor: Colors.black,
                          fixedSize:
                              Size(size.width * 0.95, size.height * 0.06),
                        ),
                        onPressed: () async {
                          final email = _emailController.text;
                          final password = _passwordController.text;
                          final prefs = await SharedPreferences.getInstance();

                          try {
                            await AuthService.firebase().logIn(
                              email: email,
                              password: password,
                            );

                            Utente? u =
                                await APIServices.getUtente(email, password);
                            if (u != null) {
                              final user = AuthService.firebase().currentUser;
                              if (user?.isEmailVerified ?? false) {
                                //Utente verificato
                                prefs.setString("email", u.email!);
                                prefs.setString("password", u.password!);
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MainView(utente: u)),
                                    (route) => false);
                                //   Navigator.of(context).pushNamedAndRemoveUntil(
                                //     Routes.mainView,
                                //     (route) => false,
                                //   );
                              } else {
                                //Utente NON verificato
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  Routes.verifyMailView,
                                  (route) => false,
                                );
                              }
                            }
                          } on InvalidLoginCredentialsAuthException {
                            await showErrorDialog(context,
                                'Nome utente o password sbagliati!\nRiprovare.');
                          } on GenericAuthException {
                            await showErrorDialog(
                                context, 'Errore di autenticazione');
                          }

                          // if (_formKey.currentState?.validate() ?? false) {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     const SnackBar(
                          //       content: Text('Logged In!'),
                          //     ),
                          //   );
                          //   emailController.clear();
                          //   passwordController.clear();
                          //   Future.delayed(const Duration(seconds: 5), () {
                          //     Navigator.of(context).pushReplacementNamed(
                          //         Routes.mainView);
                          //   });
                          // }
                        },
                        child: const Text(
                          'ACCEDI',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: Divider(
                      //         color: Colors.grey.shade200,
                      //       ),
                      //     ),
                      //     const Padding(
                      //       padding: EdgeInsets.symmetric(horizontal: 20),
                      //       child: Text(
                      //         'Oppure accedi con',
                      //         style: TextStyle(
                      //           color: Colors.white,
                      //         ),
                      //       ),
                      //     ),
                      //     Expanded(
                      //       child: Divider(
                      //         color: Colors.grey.shade200,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(height: size.height * 0.01),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     IconButton(
                      //       onPressed: () async {
                      //         try {
                      //           await AuthService.firebase().signInWithGoogle();
                      //           if (!context.mounted) return;
                      //           Navigator.of(context).pushNamedAndRemoveUntil(
                      //             Routes.mainView,
                      //             (route) => false,
                      //           );
                      //         } on GenericAuthException {
                      //           await showErrorDialog(
                      //               context, 'Errore di autenticazione');
                      //         }
                      //       },
                      //       icon: SvgPicture.asset(
                      //         ImageConstant.googleLogo,
                      //       ),
                      //     ),
                      //     IconButton(
                      //       onPressed: () async {
                      //         try {
                      //           await AuthService.firebase()
                      //               .signInWithFacebook();
                      //           if (!context.mounted) return;
                      //           Navigator.of(context).pushNamedAndRemoveUntil(
                      //             Routes.mainView,
                      //             (route) => false,
                      //           );
                      //         } on GenericAuthException {
                      //           await showErrorDialog(
                      //               context, 'Errore di autenticazione');
                      //         }
                      //       },
                      //       icon: SvgPicture.asset(
                      //         ImageConstant.facebookLogo,
                      //         width: 40,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(height: size.height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Non hai un account?',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  Routes.registerView, (route) => false);
                            },
                            child: const Text(
                              'Registrati',
                              style: TextStyle(
                                color: AppColors.oro,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
