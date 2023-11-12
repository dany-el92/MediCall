import 'package:flutter/material.dart';
import 'package:medicall/constants/colors.dart';
import 'package:medicall/constants/images.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:medicall/utilities/extensions.dart';
import 'package:medicall/views/homepage_view.dart';
import 'package:medicall/views/prescription_view.dart';
import 'package:medicall/views/profile_view.dart';
import 'package:medicall/views/receipt_view.dart';
import 'package:medicall/views/assistent_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

int _selectedIndex=0;

void _navigateBottomBar(int index){
  setState(() {
    _selectedIndex=index;
  });
}

final List _pages = [
  HomePageView(),
  PrescriptionView(),
  AssistentView(),
  ReceiptView(),
  ProfileView()
];

FloatingActionButton? _checkIndex(int index){
  if(index==0){
    return FloatingActionButton(
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
      ); 
  }
  else{
    return null;
  }
}

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
            child: Icon(Icons.person),
            label: 'Profilo',
          )
        ],
        backgroundColor: AppColors.bluChiaro,
        color: const Color(0xfff9f9f9),
        buttonBackgroundColor: const Color(0xfff9f9f9),
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 500),
        onTap: _navigateBottomBar,
        letIndexChange: (index) => true,
      ),
    );
  }
}
