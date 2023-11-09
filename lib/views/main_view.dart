import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicall/components/appointment_card.dart';
import 'package:medicall/components/assistant_card.dart';
import 'package:medicall/components/view_icon.dart';
import 'package:medicall/constants/colors.dart';
import 'package:medicall/constants/images.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:medicall/utilities/extensions.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    final size = context.mediaQuerySize;
    return Scaffold(
      backgroundColor: AppColors.bianco,
      appBar: AppBar(
        backgroundColor: AppColors.bluScuro,
        elevation: 10,
        shadowColor: Colors.black,
        toolbarHeight: size.height * 0.08,
        title: Image.asset(
          ImageConstant.imgLogo,
          width: 370,
          height: 55,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.bluChiaro,
        shape: const CircleBorder(),
        enableFeedback: true,
        elevation: 5,
        tooltip: 'Riconoscimento medicinali',
        //colore quando si clicca
        splashColor: Colors.grey,
        child: const Icon(
          Icons.camera_alt_rounded,
          color: Colors.white,
          size: 30,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ciao,',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'Daniele Gregori👋',
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
                    child: const Text('DG',
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
                  'Trova medici e specialisti',
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
              // const Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     ViewIcon(
              //       icon: Icons.medical_information,
              //       text: 'Prova',
              //     ),
              //     ViewIcon(
              //       icon: Icons.add,
              //       text: 'Prova',
              //     ),
              //     ViewIcon(
              //       icon: Icons.add,
              //       text: 'Prova',
              //     ),
              //     ViewIcon(
              //       icon: Icons.add,
              //       text: 'Prova',
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        items: const [
          CurvedNavigationBarItem(
            child: Icon(Icons.home),
            label: 'Home',
          ),
          CurvedNavigationBarItem(
            child: Icon(
              Icons.edit_calendar_rounded,
            ),
            label: 'Visite',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.wechat),
            label: 'Assistente',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.receipt),
            label: 'Ricette',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.person),
            label: 'Profilo',
          )
        ],
        backgroundColor: AppColors.bluChiaro,
        color: const Color(0xfff9f9f9),
        buttonBackgroundColor: const Color(0xfff9f9f9),
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 500),
        onTap: (index) {
          setState(() {
            // _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
