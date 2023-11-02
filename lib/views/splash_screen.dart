import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicall/constants/images.dart';
import 'package:medicall/utilities/extensions.dart';
import 'package:medicall/views/auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isVisible = true;
  double _buttonTop = 0.0;

  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
      _buttonTop = _isVisible ? 0.0 : -50.0;
    });

    if (!_isVisible) {
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        ).then((value) {
          setState(() {
            _isVisible = true;
            _buttonTop = 0.0;
          });
        });
      });
    }
  }

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
          child: AnimatedOpacity(
            duration: const Duration(seconds: 1),
            opacity: _isVisible ? 1.0 : 0.0,
            child: AnimatedContainer(
              duration: const Duration(seconds: 1),
              curve: Curves.ease,
              transform: Matrix4.translationValues(0, _buttonTop, 0),
              child: Column(children: [
                const Spacer(flex: 2),
                Image.asset(ImageConstant.imgLogo),
                const Spacer(
                  flex: 2,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0XFFFBDB6B),
                      fixedSize: Size(size.width * 0.85, size.height * 0.06),
                      foregroundColor: Colors.black,
                      textStyle: const TextStyle(
                        fontSize: 25,
                      )),
                  onPressed: _toggleVisibility,
                  child: const Text('ACCEDI'),
                ),
                SizedBox(height: size.height * 0.03),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0XFFFBDB6B),
                      fixedSize: Size(size.width * 0.85, size.height * 0.06),
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
        ),
      ),
    );
  }
}
