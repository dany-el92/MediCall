import 'package:flutter/material.dart';
import 'package:medicall/utilities/palette.dart';
import 'package:medicall/constants/images.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bianco,
      appBar: AppBar(
        backgroundColor: bluscuro,
        elevation: 0,
        //leading: Image.asset(ImageConstant.imgLogo),
        title: Image.asset(ImageConstant.imgLogo, width: 369, height: 55,),
      ),
      body: Center(),
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
        selectedItemColor: oro,
        unselectedItemColor: bianco,
        iconSize: 27.5,
        backgroundColor: bluscuro,
        type: BottomNavigationBarType.fixed,
        ),
    );
  }
}