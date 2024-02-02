import 'dart:convert';

ScansioneList scansioneListFromJson(String str) => ScansioneList.fromJson(json.decode(str));

String scansioneListToJson(ScansioneList data) => json.encode(data.toJson());

class ScansioneList {
    List<Scansione>? items;

    ScansioneList({
        this.items,
    });

    factory ScansioneList.fromJson(Map<String, dynamic> json) => ScansioneList(
        items: json["items"] == null ? [] : List<Scansione>.from(json["items"]!.map((x) => Scansione.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "items": items!.isEmpty ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    };
}

class Scansione {
    String? idImpegnativa;
    String? idCf;

    Scansione({
        this.idImpegnativa,
        this.idCf,
    });

    factory Scansione.fromJson(Map<String, dynamic> json) => Scansione(
        idImpegnativa: json["id_impegnativa"],
        idCf: json["id_cf"],
    );

    Map<String, dynamic> toJson() => {
        "id_impegnativa": idImpegnativa,
        "id_cf": idCf,
    };
}
