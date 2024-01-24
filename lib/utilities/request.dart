import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:medicall/constants/secret.dart';

Future getData(url) async {
  var uri = Uri.parse(url);
  http.Response response = await http.get(uri);
  return response.body;
}

class OpenAIService {
  final List<Map<String, String>> messages = [];

  Future<String> chatGPTAPI(String prompt) async {
    messages.add({
      "role": "system",
      "content": '''
     Dalla frase seguente, estrai le informazioni di ora, giorno, luogo e prestazione, seguendo questo template: 
      -Ora:
      -Giorno:
      -Luogo:
      -Prestazione:
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
          "max_tokens": 100,
          "temperature": 0.3,
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
        return content;
      }
      return 'An internal error occurred';
    } catch (e) {
      return e.toString();
    }
  }
}
