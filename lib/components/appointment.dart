import 'package:flutter/material.dart';

class Appointment {
  final String nomeDottore;
  final String prestazione;
  final DateTime data;
  final TimeOfDay ora;

  Appointment({
    required this.nomeDottore,
    required this.prestazione,
    required this.data,
    required this.ora,
  });
}