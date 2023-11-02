import 'package:flutter/material.dart';
import 'package:medicall/utilities/extensions.dart';

import '../../constants/images.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = context.mediaQuerySize;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment(0.5, 0),
                  end: Alignment(0.5, 1),
                  colors: [
                Color(0XFF00306D),
                Color(0XFF002556),
                Color(0XFF00204A)
              ])),
          child: Column(
            children: [
              Image.asset(ImageConstant.imgLogo),

            ],
          ),
        ),
      ),
    );
  }
}
