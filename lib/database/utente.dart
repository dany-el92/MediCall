import 'dart:convert';

UtenteList utenteListFromJson(String str) =>
    UtenteList.fromJson(json.decode(str));

String utenteListToJson(UtenteList data) => json.encode(data.toJson());

class UtenteList {
  List<Utente>? items;

  UtenteList({
    this.items,
  });

  factory UtenteList.fromJson(Map<String, dynamic> json) => UtenteList(
        items: json["items"] == null
            ? []
            : List<Utente>.from(json["items"]!.map((x) => Utente.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "items": items!.isEmpty
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Utente {
  String? codiceFiscale;
  String? email;
  String? nome;
  String? cognome;
  String? dataNascita;
  String? genere;
  String? password;
  String? familiare;

  Utente({
    this.codiceFiscale,
    this.email,
    this.nome,
    this.cognome,
    this.dataNascita,
    this.genere,
    this.password,
    this.familiare,
  });

  factory Utente.fromJson(Map<String, dynamic> json) => Utente(
        codiceFiscale: json["codice_fiscale"],
        email: json["email"],
        nome: json["nome"],
        cognome: json["cognome"],
        dataNascita: json["data_nascita"],
        genere: json["genere"],
        password: json["password"],
        familiare: json["familiare"],
      );

  Map<String, dynamic> toJson() => {
        "codice_fiscale": codiceFiscale,
        "email": email,
        "nome": nome,
        "cognome": cognome,
        "data_nascita": dataNascita,
        "genere": genere,
        "password": password,
        "familiare": familiare,
      };
}
