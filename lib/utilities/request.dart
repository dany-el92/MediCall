import 'package:http/http.dart';

Future getData(url) async {
  var uri = Uri.parse(url);
  Response response = await get(uri);
  return response.body;
}
