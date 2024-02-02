import 'dart:convert';

RicettaList ricettaListFromJson(String str) =>
    RicettaList.fromJson(json.decode(str));

String ricettaListToJson(RicettaList data) => json.encode(data.toJson());

class RicettaList {
  List<Ricetta>? items;

  RicettaList({
    this.items,
  });

  factory RicettaList.fromJson(Map<String, dynamic> json) => RicettaList(
        items: json["items"] == null
            ? []
            : List<Ricetta>.from(
                json["items"]!.map((x) => Ricetta.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "items": items!.isEmpty
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Ricetta {
  String? impegnativa;
  String? codiceAsl;
  String? codiceAutenticazione;
  String? nome;
  String? cf;
  String? esenzione;
  String? prescrizione;
  String? data;
  String? cognome;

  Ricetta({
    this.impegnativa,
    this.codiceAsl,
    this.codiceAutenticazione,
    this.nome,
    this.cf,
    this.esenzione,
    this.prescrizione,
    this.data,
    this.cognome,
  });

  factory Ricetta.fromJson(Map<String, dynamic> json) => Ricetta(
        impegnativa: json["impegnativa"],
        codiceAsl: json["codice_asl"],
        codiceAutenticazione: json["codice_autenticazione"],
        nome: json["nome"],
        cf: json["cf"],
        esenzione: json["esenzione"],
        prescrizione: json["prescrizione"],
        data: json["data"],
        cognome: json["cognome"],
      );

  Map<String, dynamic> toJson() => {
        "impegnativa": impegnativa,
        "codice_asl": codiceAsl,
        "codice_autenticazione": codiceAutenticazione,
        "nome": nome,
        "cf": cf,
        "esenzione": esenzione,
        "prescrizione": prescrizione,
        "data": data,
        "cognome": cognome,
      };
}
