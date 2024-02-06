import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:medicall/constants/rest_apis.dart';
import 'package:medicall/database/ricetta_medica.dart';
import 'package:medicall/database/scansione.dart';
import 'package:medicall/database/servizio_sanitario.dart';
import 'package:medicall/database/utente.dart';

class APIServices {
  static const headers = {'Content-Type': 'application/json'};

  Future<SSList?> getAllSS() async {
    try {
      var client = http.Client();
      var uri = Uri.parse(RestAPIs.baseURL + RestAPIs.ssTest);
      //var uri= Uri.parse(RestAPIs.baseURL+RestAPIs.ssTest);
      var response = await client.get(uri);
      client.close();
      if (response.statusCode == 200) {
        print('GET FUNZIONA');
        return ssListFromJson(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<void> addSS(SSList lista) async {
    try {
      var client = http.Client();
      var uri = Uri.parse(RestAPIs.baseURL + RestAPIs.ssTest);
      for (SS x in lista.items!) {
        var response = await client.post(uri,
            body: json.encode(x.toJson()), headers: headers);
        if (response.statusCode == 201 || response.statusCode == 200) {
          print("POST FUNZIONA");
        }
      }
      client.close();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> deleteSS(int id) async {
    try {
      var client = http.Client();
      var uri = Uri.parse('${RestAPIs.baseURL}${RestAPIs.ssTest}/$id');
      var response = await client.delete(uri);
      client.close();
      if (response.statusCode == 204 || response.statusCode == 200) {
        print("DELETE FUNZIONA");
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> updateSS(int id, String tipo) async {
    try {
      var client = http.Client();
      var uri = Uri.parse(RestAPIs.baseURL + RestAPIs.ssTest);
      SS x = SS(idServizio: id, tipo: tipo);
      Map<String, dynamic> map = {"items": []};
      print(map["items"]);
      var response = await client.put(uri,
          body: json.encode(x.toJson()), headers: headers);
      client.close();
      if (response.statusCode == 200 || response.statusCode == 204) {
        print(response.statusCode);
        print("UPDATE FUNZIONA");
      }
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> addUtente(Utente u) async {
    try {
      var client = http.Client();
      var uri = Uri.parse(RestAPIs.baseURL + RestAPIs.utenteAccount);
      var response = await client.post(uri,
          body: json.encode(u.toJson()), headers: headers);
      client.close();
      log(response.statusCode.toString());
      if (response.statusCode == 201 || response.statusCode == 200) {
        print("POST FUNZIONA");
      }
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<Utente?> getUtente(String email, String password) async {
    try {
      var client = http.Client();
      var uri = Uri.parse(
          "${RestAPIs.baseURL}${RestAPIs.utenteAccount}/$email/$password");
      var response = await client.get(uri);
      client.close();
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        print('GET FUNZIONA');
        return utenteListFromJson(response.body).items![0];
      }
    } catch (e) {
      log(e.toString());
    }

    return null;
  }

  static Future<void> addRicetta(Ricetta r) async {
    try {
      var client = http.Client();
      var uri = Uri.parse(RestAPIs.baseURL + RestAPIs.ricettaMedica);
      var response = await client.post(uri,
          body: json.encode(r.toJson()), headers: headers);
      client.close();
      log(response.statusCode.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("POST FUNZIONA");
      }
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> addScansione(Scansione s) async {
    try {
      var client = http.Client();
      var uri =
          Uri.parse("${RestAPIs.baseURL}${RestAPIs.ricettaMedica}/scansione");
      var response = await client.post(uri,
          body: json.encode(s.toJson()), headers: headers);
      client.close();
      log(response.statusCode.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("POST FUNZIONA");
      }
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> deleteUtente(String cf) async {
    try {
      var client = http.Client();
      var uri = Uri.parse("${RestAPIs.baseURL}${RestAPIs.utenteAccount}/$cf");
      var response = await client.delete(uri);
      client.close();
      log(response.statusCode.toString());
      if (response.statusCode == 204 || response.statusCode == 200) {
        print("DELETE FUNZIONA");
      }
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<RicettaList?> getRicetteFromUtente (Utente u) async{
    try{
      var client= http.Client();
      var uri= Uri.parse("${RestAPIs.baseURL}${RestAPIs.ricettaMedica}/utente/${u.codiceFiscale!}");
      var response = await client.get(uri);
      client.close();
      log(response.statusCode.toString());
      if(response.statusCode== 200){
        return ricettaListFromJson(response.body);
      }
    } catch(e){
      log(e.toString());
    }

    return null;
  }
}
