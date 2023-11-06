import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicall/components/custom_text_form_field.dart';
import 'package:medicall/constants/colors.dart';
import 'package:medicall/utilities/extensions.dart';

import '../../constants/images.dart';

final _formKey = GlobalKey<FormState>();

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  //TODO: Add controller
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isObscure = true;

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
                        textInputAction: TextInputAction.next,
                        labelText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        suffixIcon: const Padding(
                          padding: EdgeInsets.only(right: 20.0),
                          child: Icon(
                            Icons.email,
                          ),
                        ),
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Inserire del testo';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: size.height * 0.02),
                      //Input Password
                      CustomTextFormField(
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
                        controller: passwordController,
                        validator: null, //TODO: Add validator
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Hai dimenticato la Password?',
                          style: TextStyle(
                            color: AppColors.oro,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.black,
                          elevation: 20,
                          backgroundColor: AppColors.oro,
                          foregroundColor: Colors.black,
                          fixedSize:
                              Size(size.width * 0.95, size.height * 0.06),
                        ),
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Logged In!'),
                              ),
                            );
                            emailController.clear();
                            passwordController.clear();
                          }
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
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.grey.shade200,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Oppure accedi con',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.grey.shade200,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              ImageConstant.googleLogo,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              ImageConstant.facebookLogo,
                              width: 40,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.02),
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
                            onPressed: () {},
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
