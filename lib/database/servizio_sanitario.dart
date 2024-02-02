import 'dart:convert';

SSList ssListFromJson(String str) => SSList.fromJson(json.decode(str));

String ssListToJson(SSList data) => json.encode(data.toJson());

class SSList {
    List<SS>? items;

    SSList({
        this.items,
    });

    factory SSList.fromJson(Map<String, dynamic> json) => SSList(
        items: json["items"]==null ? [] : List<SS>.from(json["items"]!.map((x) => SS.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "items": items!.isEmpty ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    };
}

class SS {
    int? idServizio;
    String? tipo;

    SS({
        this.idServizio,
        this.tipo,
    });

    factory SS.fromJson(Map<String, dynamic> json) => SS(
        idServizio: json["id_servizio"],
        tipo: json["tipo"],
    );

    Map<String, dynamic> toJson() => {
        "id_servizio": idServizio,
        "tipo": tipo,
    };
}
