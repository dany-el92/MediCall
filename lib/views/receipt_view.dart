import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicall/constants/images.dart';

class ReceiptView extends StatelessWidget {
  const ReceiptView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              ImageConstant.prescriptionImage,
              height: 200,
              width: 200,
            ),
            const Text(
              'Gestisci le tue ricette',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Salva le tue ricette e tienile sempre con te per averle sempre a portata di mano e non perderle mai più!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
