import 'package:flutter/material.dart';
import 'package:medicall/components/appointmentCard.dart';
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
        elevation: 0,
        //leading: Image.asset(ImageConstant.imgLogo),
        title: Image.asset(
          ImageConstant.imgLogo,
          width: 370,
          height: 55,
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
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'Daniele Gregori👋',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.brown.shade800,
                    child: const Text('DG',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                  )
                ],
              ),
              Divider(color: Colors.black54),
              SizedBox(height: size.height * 0.1),
              AppointmentCard(
                onTap: () {},
              ),
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
            label: 'Calendario',
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
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
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
