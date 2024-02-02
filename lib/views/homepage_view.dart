import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicall/components/appointment_card.dart';
import 'package:medicall/components/assistant_card.dart';
import 'package:medicall/constants/images.dart';
import 'package:medicall/database/utente.dart';
import 'package:medicall/utilities/extensions.dart';
import 'package:medicall/constants/colors.dart';

class HomePageView extends StatelessWidget {

  final Utente utente;

  const HomePageView({super.key, required this.utente});

  @override
  Widget build(BuildContext context) {
    final size = context.mediaQuerySize;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: size.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                const Text(
                      'Ciao,',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "${utente.nome} ${utente.cognome} 👋",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.blueAccent.shade700,
                  child: Text("${utente.nome![0]}${utente.cognome![0]}",
                      style: TextStyle(
                        color: Colors.white,
                      )),
                )
              ],
            ),
            SizedBox(height: size.height * 0.02),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                size: 30,
                color: AppColors.bluChiaro,
              ),
              label: const Text(
                'Trova strutture sanitarie',
                style: TextStyle(
                  fontSize: 15,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              style: ElevatedButton.styleFrom(
                alignment: Alignment.centerLeft,
                backgroundColor: Colors.white,
                fixedSize: Size(size.width * 0.95, size.height * 0.06),
                elevation: 4,
                shadowColor: AppColors.bluChiaro,
                surfaceTintColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.05),
            const Text(
              "Prenota una visita tramite l'Assistente Virtuale",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            SizedBox(
              height: size.height * 0.60,
              child: Card(
                elevation: 10,
                shadowColor: AppColors.bluChiaro,
                color: Colors.white,
                surfaceTintColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(ImageConstant.chatImage, width: 200),
                      const Text(
                        "Chiedi aiuto all'Assistente",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const Text(
                        "Utilizza l'Assistente Virtuale per prenotare una visita senza dover attendere in coda."
                        " Chiedi al tuo assistente di prenotare una visita e lui ti guiderà passo passo.",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          wordSpacing: 1.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const AssistantCard(),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Prossimo Appuntamento',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    )),
                TextButton(
                  child: Text(
                    'Vedi Tutti',
                    style: TextStyle(
                      color: Colors.amber.shade600,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  onPressed: () {},
                )
              ],
            ),
            AppointmentCard(
              onTap: () {},
            ),
            SizedBox(height: size.height * 0.04),
          ],
        ),
      ),
    );
  }
}
