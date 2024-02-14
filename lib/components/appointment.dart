import 'package:flutter/material.dart';
import 'dart:convert';

AppointmentList appointmentListFromJson(String str) => AppointmentList.fromJson(json.decode(str));

String appointmentListToJson(AppointmentList data) => json.encode(data.toJson());

class AppointmentList {
    List<Appointment>? items;

    AppointmentList({
        this.items,
    });

    factory AppointmentList.fromJson(Map<String, dynamic> json) => AppointmentList(
        items: json["items"] == null ? [] : List<Appointment>.from(json["items"]!.map((x) => Appointment.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "items": items!.isEmpty ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    };
}

class Appointment {
    String? centroNome;
    String? prescrizione;
    DateTime? dataPrenotazione;
    TimeOfDay? orario;

    Appointment({
        this.centroNome,
        this.prescrizione,
        this.dataPrenotazione,
        this.orario,
    });

    factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        centroNome: json["centro_nome"],
        prescrizione: json["prescrizione"],
        dataPrenotazione: json["data_prenotazione"] == null ? null : DateTime.parse(json["data_prenotazione"]),
        orario: TimeOfDay(hour: int.parse(json["orario"].toString().split(":")[0]),minute: int.parse(json["orario"].toString().split(":")[1])),
    );

    Map<String, dynamic> toJson() => {
        "centro_nome": centroNome,
        "prescrizione": prescrizione,
        "data_prenotazione": dataPrenotazione?.toIso8601String(),
        "orario": orario,
    };
}





/*class Appointment {
  final String nomeCentro;
  final String prestazione;
  final DateTime data;
  final TimeOfDay ora;

  Appointment({
    required this.nomeCentro,
    required this.prestazione,
    required this.data,
    required this.ora,
  });
}
*/