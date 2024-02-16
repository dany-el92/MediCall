import 'dart:convert';

CentroList centroListFromJson(String str) =>
    CentroList.fromJson(json.decode(str));

String centroListToJson(CentroList data) => json.encode(data.toJson());

class CentroList {
  List<Centro>? items;

  CentroList({
    this.items,
  });

  factory CentroList.fromJson(Map<String, dynamic> json) => CentroList(
        items: json["items"] == null
            ? []
            : List<Centro>.from(json["items"]!.map((x) => Centro.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "items": items!.isEmpty
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Centro {
  int? idCentro;
  String? nome;
  String? indirizzo;
  String? cap;
  String? provincia;
  String? citta;
  String? descrizione;

  Centro(
      {this.idCentro,
      this.nome,
      this.indirizzo,
      this.cap,
      this.provincia,
      this.citta,
      this.descrizione});

  factory Centro.fromJson(Map<String, dynamic> json) => Centro(
      idCentro: json["id_centro"],
      nome: json["nome"],
      indirizzo: json["indirizzo"],
      cap: json["cap"],
      provincia: json["provincia"],
      citta: json["citta"],
      descrizione: json["descrizione"]);

  Map<String, dynamic> toJson() => {
        "id_centro": idCentro,
        "nome": nome,
        "indirizzo": indirizzo,
        "cap": cap,
        "provincia": provincia,
        "citta": citta,
        "descrizione": descrizione
      };
}
