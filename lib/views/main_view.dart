import 'package:flutter/material.dart';
import 'package:medicall/constants/colors.dart';
import 'package:medicall/constants/images.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bianco,
      appBar: AppBar(
        backgroundColor: AppColors.bluScuro,
        elevation: 0,
        //leading: Image.asset(ImageConstant.imgLogo),
        title: Image.asset(ImageConstant.imgLogo, width: 369, height: 55,),
      ),
      body: const Center(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_calendar_rounded),
            label: 'Calendario'
            ),

          BottomNavigationBarItem(
            icon: Icon(Icons.wechat),
            label:'Assistente'
            
            ),

          BottomNavigationBarItem(icon: Icon(Icons.receipt),
          label: 'Ricette'),

          BottomNavigationBarItem(icon: Icon(Icons.person),
          label: 'Profilo'
          )                     
        ],
        selectedItemColor: AppColors.oro,
        unselectedItemColor: AppColors.bianco,
        iconSize: 27.5,
        backgroundColor: AppColors.bluScuro,
        type: BottomNavigationBarType.fixed,
        ),
    );
  }
}