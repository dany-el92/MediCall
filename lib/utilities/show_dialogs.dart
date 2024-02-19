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

Future<bool> showNetworkErrorOCRDialog(BuildContext context) {
  return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Oops! Qualcosa è andato storto..."),
          content: const Text(
              "Servizio non disponibile, ci scusiamo per il disagio. Riprova più tardi!"),
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

Future<bool> showDeleteAccountDialog(BuildContext context) {
  return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("ATTENZIONE!"),
          content: const Text(
              "Sei sicuro di voler eliminare permanentemente l'account? Così facendo tutti i tuoi dati verranno cancellati!"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text("Sì")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text("Annulla"))
          ],
        );
      }).then((value) => value ?? false);
}

Future<bool> showConfirmAppointmentDialog(BuildContext context, String data,
    String orario, String servizio, String centro) {
  String s = "";
  switch (servizio) {
    case "Ortopedia":
      s = "Ortopedica";
      break;

    case "Cardiologia":
      s = "Cardiologica";
      break;
    
    default:
    s = servizio;
    break;
  }

  List<String> list = data.split("-");
  return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: const Text("Conferma Prenotazione"),
            content: Text(
                "Vuoi confermare la prenotazione per una visita $s presso $centro il giorno ${list[2]}/${list[1]}/${list[0]} alle ore $orario?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text("Sì")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text("Annulla"))
            ]);
      }).then((value) => value ?? false);
}

Future<void> showMissingAppointmentDetailsDialog(
    BuildContext context, bool data, bool orario, bool tipo) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Dati Mancanti"),
          content: Text(
              "Non è stato possibile effettuare la prenotazione perchè hai dimenticato di selezionare:\n\n${data == true ? "Data Appuntamento\n" : ""}${orario == true ? "Ora Appuntamento\n" : ""}${tipo == true ? "Tipo di Prescrizione" : ""}"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"))
          ],
        );
      });
}

Future<bool> showDeletePrescriptionDialog(BuildContext context) {
  return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("ATTENZIONE!"),
          content: const Text(
              "Sei sicuro di voler eliminare permanentemente questa ricetta dal tuo account?"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text("Sì")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text("Annulla"))
          ],
        );
      }).then((value) => value ?? false);
}

Future<void> showMissingPasswordDetailsDialog(BuildContext context) {
  return showDialog(
    context: context, 
    builder: (context){
      return AlertDialog(
        title: const Text("Dati Mancanti"),
        content: const Text("I campi risultano vuoti o la nuova password non risulta confermata"),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.of(context).pop();
            }, 
            child: const Text("OK"))
        ],
      );
    });
}

Future<bool> showNewPasswordConfirmedDialog(BuildContext context){
   return showDialog<bool>(
    context: context, 
    builder: (context){
      return AlertDialog(
        title: const Text("Operazione Riuscita"),
        content: const Text("La password è stata modificata con successo.\nRieffettua il login"),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.of(context).pop();
            }, 
            child: const Text("OK"))
        ],
      );
    }).then((_) => true);
}

Future<bool> showDeleteAppointmentDialog(BuildContext context){
  return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("ATTENZIONE!"),
          content: const Text(
              "Sei sicuro di voler disdire questo appuntamento?"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text("Sì")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text("Annulla"))
          ],
        );
      }).then((value) => value ?? false);
}
