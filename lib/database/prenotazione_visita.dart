import 'dart:convert';

PrenotazioneList prenotazioneListFromJson(String str) => PrenotazioneList.fromJson(json.decode(str));

String prenotazioneListToJson(PrenotazioneList data) => json.encode(data.toJson());

class PrenotazioneList {
    List<Prenotazione>? items;

    PrenotazioneList({
        this.items,
    });

    factory PrenotazioneList.fromJson(Map<String, dynamic> json) => PrenotazioneList(
        items: json["items"] == null ? [] : List<Prenotazione>.from(json["items"]!.map((x) => Prenotazione.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "items": items!.isEmpty ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    };
}

class Prenotazione {
    int? idVisita;
    String? idUtente;
    int? idCm;
    int? idTipo;
    String? dataPrenotazione;
    String? orario;

    Prenotazione({
        this.idVisita,
        this.idUtente,
        this.idCm,
        this.idTipo,
        this.dataPrenotazione,
        this.orario,
    });

    factory Prenotazione.fromJson(Map<String, dynamic> json) => Prenotazione(
        idVisita: json["id_visita"],
        idUtente: json["id_utente"],
        idCm: json["id_cm"],
        idTipo: json["id_tipo"],
        dataPrenotazione: json["data_prenotazione"],
        orario: json["orario"],
    );

    Map<String, dynamic> toJson() => {
        "id_visita": idVisita,
        "id_utente": idUtente,
        "id_cm": idCm,
        "id_tipo": idTipo,
        "data_prenotazione": dataPrenotazione,
        "orario": orario,
    };
}
