import 'package:flutter/material.dart';
import 'package:medicall/authentication/auth_service.dart';
import 'package:medicall/constants/routes.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verifica mail'),
      ),
      body: Column(
        children: [
          Text(
              'È stata inviata una mail di verifica. Per favore clicca il link al suo interno.'),
          Text(
              'Se non è arrivata nessuna mail di verifica, per favore cliccare sul bottone sotto.'),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().sendEmailVerification();
            },
            child: Text('Invia mail di verifica'),
          ),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().logOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.registerView,
                (route) => false,
              );
            },
            child: const Text('Riavvia'),
          )
        ],
      ),
    );
  }
}
