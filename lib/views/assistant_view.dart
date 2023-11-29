import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:medicall/constants/colors.dart';
import 'package:medicall/utilities/extensions.dart';

class AssistantView extends StatefulWidget {
  const AssistantView({super.key});

  @override
  State<AssistantView> createState() => _AssistantViewState();
}

class _AssistantViewState extends State<AssistantView> {
  @override
  Widget build(BuildContext context) {
    final size = context.mediaQuerySize;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: size.height * 0.01),
                const BubbleSpecialThree(
                  textStyle: TextStyle(
                    color:  AppColors.bianco,
                    fontSize: 16
                  ) ,
                  text: "Ciao sono Pasqualino, l'assistente virtuale! Come posso aiutarti?",
                  color: AppColors.bluMedio,
                  tail:true,
                  isSender: false),
                const BubbleSpecialThree(
                  text: "Vorrei prenotare per..." ,
                  color: AppColors.bluChiaro,
                  tail:true,
                  textStyle: TextStyle(
                    color: AppColors.bianco,
                    fontSize: 16
                  ) 
                ),   
                SizedBox(height: size.height * 0.1)
              ],
            ),
          ),
          MessageBar(
            messageBarHitText: "Messaggio...",
            replyIconColor: AppColors.bluChiaro,
            sendButtonColor: AppColors.bluChiaro,
            actions: [
              const InkWell(
                child: Icon(Icons.mic, color: AppColors.bluChiaro,),
              )
            ],
          )
        ],
      ),
    );
  }
}
