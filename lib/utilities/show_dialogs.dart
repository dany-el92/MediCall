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

Future<bool> showErrorOCRDialog(BuildContext context) {
  return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Oops! Qualcosa è andato storto..."),
          content: const Text(
              "Non è stato possibile scannerizzare alcune informazioni. Per favore riprova in un ambiente più luminoso"),
          actions: [
            TextButton(
                onPressed: () async {
                  Navigator.of(context).pop(true);
                },
                child: const Text('OK'))
          ],
        );
      }).then((value) => value ?? false);
}


Future<bool> showDeleteAccountDialog(BuildContext context){
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("ATTENZIONE!"),
        content: const Text("Sei sicuro di voler eliminare permanentemente l'account? Così facendo tutti i tuoi dati verranno cancellati!"),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.of(context).pop(true);
            }, 
          child: const Text("Sì")),
          TextButton(
            onPressed: (){
              Navigator.of(context).pop(false);
            }, 
            child: const Text("Annulla"))
        ],
      );
    }).then((value) => value ?? false);
}