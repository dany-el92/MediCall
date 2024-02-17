import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:medicall/constants/secret.dart';
import 'package:medicall/utilities/regex_helper.dart';

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
      Formatta la data nel formato aaaa-mm-gg e l'ora nel formato hh:mm
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
        // Send the extracted information to the server
        var response = await http.post(
          Uri.parse('http://89.168.86.207:5001/extract'),
          // Replace with your server URL
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            'ora': ora,
            'data': data,
            'luogo': luogo,
            'prestazione': prestazione,
          }),
        );

        if (response.statusCode == 200) {
          return "Grazie, la sua richiesta è stata inviata con successo. Le faremo sapere al più presto l'esito della prenotazione.";
        } else {
          return 'Servizio non disponibile, ci scusiamo per il disagio. Riprova più tardi!';
        }
      } else {
        return "Per favore, reinvia il messaggio inserendo tutte le informazioni richieste";
      }
    } catch (e) {
      return 'Servizio non disponibile, ci scusiamo per il disagio. Riprova più tardi!';
    }
  }
}
