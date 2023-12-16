import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicall/constants/colors.dart';
import 'package:medicall/constants/images.dart';

class PrescriptionView extends StatelessWidget {
  const PrescriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        foregroundColor: Colors.white,
        extendedPadding: const EdgeInsets.symmetric(horizontal: 7.5),
        backgroundColor: AppColors.bluChiaro,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Aggiungi ricetta'),
        extendedTextStyle:
            const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(15),
            child: Row(children: [
              Text('Le mie ricette',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  )),
            ]),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  ImageConstant.prescriptionImage,
                  height: 200,
                  width: 200,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Gestisci le tue ricette',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'Salva le tue ricette e tienile sempre con te per averle sempre a portata di mano e non perderle mai più!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                //const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
