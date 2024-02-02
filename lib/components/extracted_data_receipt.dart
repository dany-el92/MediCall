class ExtractedData {
  String nome;
  String cognome;
  String CF;
  String impegnativa;
  String prescrizione;
  String auth;
  String esenzione;
  String codiceAsl;
  String data;
  List<bool> dataControl;

  ExtractedData({
    required this.nome,
    required this.cognome,
    required this.CF,
    required this.impegnativa,
    required this.prescrizione,
    required this.auth,
    required this.esenzione,
    required this.codiceAsl,
    required this.data,
    required this.dataControl,
  });
}
