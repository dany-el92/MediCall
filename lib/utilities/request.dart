import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:medicall/constants/secret.dart';
import 'package:medicall/database/centro_medico.dart';
import 'package:medicall/database/prenotazione_visita.dart';
import 'package:medicall/database/servizio_sanitario.dart';
import 'package:medicall/database/utente.dart';
import 'package:medicall/utilities/api_services.dart';
import 'package:medicall/utilities/regex_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future getData(url) async {
  var uri = Uri.parse(url);
  http.Response response = await http.get(uri);
  return response.body;
}

class OpenAIService {
  final List<Map<String, String>> messages = [];
  String generatedContent = '';

  Future<String> chatGPTAPI(String prompt) async {
    messages.add({
      "role": "system",
      "content": '''
     Dalla frase seguente, estrai le informazioni di ora, giorno, luogo e prestazione, seguendo questo template: 
      -Ora:
      -Data:
      -Luogo:
      -Prestazione:
      Formatta la data nel formato aaaa-mm-gg e l'ora nel formato hh:mm.
      Se l'anno non è specificato, assumi che sia il 2024.
    ''',
    });
    messages.add({
      'role': 'user',
      'content': prompt,
    });
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIAPIKey',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": messages,
          "max_tokens": 256,
          "temperature": 0,
        }),
      );

      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();

        messages.add({
          'role': 'assistant',
          'content': content,
        });

        log(content);

        generatedContent = await extractAndSendData(content);

        return generatedContent;
      }
      return 'An internal error occurred';
    } catch (e) {
      return e.toString();
    }
  }

  bool isInputComplete(Map<String, String> userInput) {
    List<String> requiredFields = ['ora', 'data', 'luogo', 'prestazione'];

    for (String field in requiredFields) {
      if (!userInput.containsKey(field) ||
          userInput[field]!.isEmpty ||
          userInput[field]!.contains('non specificato')) {
        return false;
      }
    }

    return true;
  }

  Future<String> extractAndSendData(String content) async {
    try {
      // Extract the information from the generated content
      String ora = RegexHelper.extractOra(content);
      String data = RegexHelper.extractData(content);
      String luogo = RegexHelper.extractLuogo(content);
      String prestazione = RegexHelper.extractPrestazione(content);

      // Check if the extracted information is complete
      Map<String, String> userInput = {
        'ora': ora,
        'data': data,
        'luogo': luogo,
        'prestazione': prestazione,
      };

      if (isInputComplete(userInput)) {
        SS? servizio;
        final prefs= await SharedPreferences.getInstance();
        String? email = prefs.getString("email");
        String? password = prefs.getString("password");
        CentroList? centro = await APIServices.getCentriFromSearchBar(luogo);
        if(centro == null || centro.items!.isEmpty){
          return "La struttura sanitaria da lei inserita, non esiste. Per favore riprovi";
        }

        SSList? listSS = await APIServices.getSSFromCentro(centro.items![0]);
        List<String> ssList = prestazione.split(" ");
        if(ssList.length == 2){
          servizio = await APIServices.getSS(ssList[1]);
           if(servizio == null){
            return "Il servizio sanitario da lei inserito, non esiste. Per favore riprovi";
          } else{
            bool exists = listSS!.items!.any((element) => element.idServizio == servizio!.idServizio);
            if(!exists){
              return "Il servizio sanitario da lei inserito non è offerto dalla struttura ${centro.items![0].nome!}";
            }
          }
        } else if(ssList.length == 3){
          servizio = await APIServices.getSS(ssList[2]);
           if(servizio == null){
            return "Il servizio sanitario da lei inserito, non esiste. Per favore riprovi";
          } else{
            bool exists = listSS!.items!.any((element) => element.idServizio == servizio!.idServizio);
            if(!exists){
              return "Il servizio sanitario da lei inserito non è offerto dalla struttura ${centro.items![0].nome!}";
            }
          }
        } else if(ssList.length == 4){
          servizio = await APIServices.getSS("${ssList[2]} ${ssList[3]}");
           if(servizio == null){
            return "Il servizio sanitario da lei inserito, non esiste. Per favore riprovi";
          } else{
            bool exists = listSS!.items!.any((element) => element.idServizio == servizio!.idServizio);
            if(!exists){
              return "Il servizio sanitario da lei inserito non è offerto dalla struttura ${centro.items![0].nome!}";
            }
          }
        }

        if(email !=null && password != null){
          Utente? utente = await APIServices.getUtente(email, password);
          Prenotazione prenotazione = Prenotazione(dataPrenotazione: data, idUtente: utente!.codiceFiscale, idCm: centro.items![0].idCentro, idTipo: servizio!.idServizio , orario: ora);
          APIServices.addPrenotazione(prenotazione);
        // Send the extracted information to the server
          var response = await http.post(
            Uri.parse('http://89.168.86.207:5001/extract'),
            // Replace with your server URL
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              'nomeCompleto': "${utente.nome!} ${utente.cognome!}",
              'ora': ora,
              'data': data,
              'luogo': centro.items![0].nome,
              'prestazione': prestazione,
            }),
          );

          if (response.statusCode == 200) {
            return "Grazie, la sua richiesta è stata inviata con successo. Le faremo sapere al più presto l'esito della prenotazione.";
          } else {
            return 'Servizio non disponibile, ci scusiamo per il disagio. Riprova più tardi!';
          }
        }
      } else {
        return "Per favore, reinvia il messaggio inserendo tutte le informazioni richieste";
      }
    } catch (e) {
      return 'Servizio non disponibile, ci scusiamo per il disagio. Riprova più tardi!';
    }

    return "Errore";
  }
}
