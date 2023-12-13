import 'package:flutter/material.dart';

Future<void> showErrorDialog(BuildContext context, String text) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Errore!'),
          content: Text(text),
          actions: [
            TextButton(
                onPressed: () {
                  //Rimuove l'alert dialog dallo schermo
                  Navigator.of(context).pop();
                },
                child: const Text('OK'))
          ],
        );
      });
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Esci'),
        content: const Text('Confermi di voler uscire?'),
        actions: [
          TextButton(
              onPressed: () {
                //Toglie l'alert dalla schermata tornando indietro con pop
                //Ritorna false per far capire se l'utente ha scelto di annullare
                Navigator.of(context).pop(false);
              },
              child: const Text('Annulla')),
          TextButton(
              onPressed: () {
                //Ritorna true per far capire se l'utente ha scelto di uscire
                Navigator.of(context).pop(true);
              },
              child: const Text('Esci'))
        ],
      );
    },
  ).then((value) => value ?? false);
}
