import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicall/constants/colors.dart';
import 'package:medicall/constants/images.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        extendedPadding: const EdgeInsets.symmetric(horizontal: 7.5),
        foregroundColor: Colors.white,
        backgroundColor: AppColors.bluChiaro,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        icon: const Icon(Icons.edit),
        label: const Text('Prenota visita'),
        extendedTextStyle:
            const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(15),
            child: Row(children: [
              Text('Le mie visite',
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
                  ImageConstant.calendarImage,
                  height: 200,
                  width: 200,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Organizza le tue visite',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'Tieni traccia delle tue visite e degli appuntamenti con i tuoi medici per non dimenticarli mai più!',
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
