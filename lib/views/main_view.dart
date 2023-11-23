import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:medicall/utilities/text_scanner.dart';
import 'package:medicall/constants/colors.dart';
import 'package:medicall/constants/images.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:medicall/utilities/extensions.dart';
import 'package:medicall/views/account_view.dart';
import 'package:medicall/views/calendar_view.dart';
import 'package:medicall/views/homepage_view.dart';
import 'package:medicall/views/assistant_view.dart';
import 'package:medicall/views/prescription_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  //TODO: da cambiare con la pagina iniziale
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _pages = [
    const HomePageView(),
    const CalendarView(),
    const AssistantView(),
    const PrescriptionView(),
    const AccountView()
  ];

  SpeedDial? _checkIndex(int index) {
    if (index == 0) {
      return SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        //overlayColor: Colors.black,
        //overlayOpacity: 0.5,
        spacing: 10,
        curve: Curves.easeIn,
        elevation: 10,
        backgroundColor: AppColors.bluChiaro,
        foregroundColor: Colors.white,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.medical_information),
            shape: const CircleBorder(),
            elevation: 10,
            label: 'Riconoscimento Medicinali',
            onTap: () {},
          ),
          SpeedDialChild(
            child: const Icon(Icons.receipt_rounded),
            shape: const CircleBorder(),
            elevation: 10,
            label: 'Salva Ricetta',
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const TextScanner()));
            },
          ),
        ],
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final size = context.mediaQuerySize;
    return Scaffold(
      backgroundColor: AppColors.bianco,
      appBar: AppBar(
        backgroundColor: AppColors.bluScuro,
        elevation: 5,
        shadowColor: Colors.black,
        toolbarHeight: size.height * 0.08,
        title: Image.asset(
          ImageConstant.imgLogo,
          width: 370,
          height: 55,
        ),
      ),
      floatingActionButton: _checkIndex(_selectedIndex),
      body: _pages[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
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
            child: Icon(Icons.manage_accounts),
            label: 'Account',
          )
        ],
        backgroundColor: AppColors.bluChiaro,
        color: const Color(0xfff9f9f9),
        buttonBackgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 500),
        onTap: _navigateBottomBar,
        letIndexChange: (index) => true,
      ),
    );
  }
}
