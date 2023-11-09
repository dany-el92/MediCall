import 'package:flutter/material.dart';
import 'package:medicall/constants/colors.dart';
import 'package:medicall/constants/images.dart';

class AssistantCard extends StatelessWidget {
  const AssistantCard({super.key});

  @override
  Widget build(BuildContext context) {
    //container per il gradiente al posto dell'elevatedButton
    // return Container(
    //   padding: const EdgeInsets.all(10),
    //   width: double.infinity,
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(10),
    //     gradient: const LinearGradient(
    //       colors: [
    //         AppColors.oro,
    //         AppColors.bluChiaro,
    //       ],
    //       begin: Alignment.centerLeft,
    //       end: Alignment.centerRight,
    //     ),
    //   ),
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.bluChiaro,
        elevation: 5,
        shadowColor: AppColors.bluChiaro,
        splashFactory: InkSplash.splashFactory,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(10),
      ),
      onPressed: () {},
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Ciao, come posso aiutarti?',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            Icon(
              Icons.mic,
              size: 30,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
