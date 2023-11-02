import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicall/constants/images.dart';
import 'package:medicall/utilities/extensions.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = context.mediaQuerySize;
    return Scaffold(
      body: SafeArea(
        child: Container(
          // padding:
          //     const EdgeInsets.only(left: 15, right: 15, top: 240, bottom: 140),
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
          child: Column(children: [
            const Spacer(flex: 2),
            Image.asset(ImageConstant.imgLogo),
            const Spacer(
              flex: 2,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFFFBDB6B),
                  minimumSize: const Size(350, 50),
                  foregroundColor: Colors.black,
                  textStyle: const TextStyle(
                    fontSize: 25,
                  )),
              onPressed: () {},
              child: const Text('ACCEDI'),
            ),
            SizedBox(height: size.height * 0.03),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFFFBDB6B),
                  minimumSize: const Size(350, 50),
                  foregroundColor: Colors.black,
                  textStyle: const TextStyle(
                    fontSize: 25,
                  )),
              onPressed: () {},
              child: const Text('REGISTRATI'),
            ),
            SizedBox(height: size.height * 0.02),
            SvgPicture.asset(ImageConstant.googleLogo),
            const Spacer(),
          ]),
        ),
      ),
    );
  }
}
