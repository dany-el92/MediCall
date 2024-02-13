import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:medicall/constants/colors.dart';
import 'package:medicall/main.dart';

class AssistantCard extends StatelessWidget {
  const AssistantCard({super.key});

  @override
  Widget build(BuildContext context) {
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
      onPressed: () {
        CurvedNavigationBarState? state = bottomNavigationKey.currentState;
        state?.setPage(2);
      },
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
