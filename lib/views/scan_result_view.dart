import 'package:flutter/material.dart';
import 'package:medicall/components/custom_text_form_field.dart';
import 'package:medicall/constants/colors.dart';
import 'package:medicall/database/ricetta_medica.dart';
import 'package:medicall/database/scansione.dart';
import 'package:medicall/database/utente.dart';
import 'package:medicall/utilities/api_services.dart';
import 'package:medicall/utilities/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _formKey = GlobalKey<FormState>();

class ResultScreen extends StatefulWidget {
  final String nome,
      cognome,
      CF,
      impegnativa,
      prescrizione,
      auth,
      esenzione,
      codice_asl,
      data;

  const ResultScreen(
      {Key? key,
      required this.nome,
      required this.cognome,
      required this.CF,
      required this.impegnativa,
      required this.prescrizione,
      required this.auth,
      required this.esenzione,
      required this.codice_asl,
      required this.data})
      : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController cognomeController = TextEditingController();
  TextEditingController CFController = TextEditingController();
  TextEditingController esenzioneController = TextEditingController();
  TextEditingController prescrizioneController = TextEditingController();
  TextEditingController codice_autenticazione_Controller =
      TextEditingController();
  TextEditingController codice_asl_Controller = TextEditingController();
  TextEditingController dataController = TextEditingController();
  TextEditingController impegnativaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nomeController.text = widget.nome;
    cognomeController.text = widget.cognome;
    CFController.text = widget.CF;
    esenzioneController.text = widget.esenzione;
    prescrizioneController.text = widget.prescrizione;
    codice_asl_Controller.text = widget.codice_asl;
    dataController.text = widget.data;
    impegnativaController.text = widget.impegnativa;
    codice_autenticazione_Controller.text = widget.auth;
  }

  @override
  Widget build(BuildContext context) {
    final size = context.mediaQuerySize;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        //iconTheme: const IconThemeData(color: AppColors.oro),
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.bluScuro,
        elevation: 5,
        shadowColor: Colors.black,
        toolbarHeight: size.height * 0.08,
        title: const Text(
          "Dati Ricetta",
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.oro, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomTextFormField(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          textInputAction: TextInputAction.next,
                          labelText: 'Codice Fiscale',
                          keyboardType: TextInputType.text,
                          controller: CFController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Codice Fiscale non inserito';
                            }

                            if (!RegExp(
                                    r"^(?:[A-Z][AEIOU][AEIOUX]|[AEIOU]X{2}|[B-DF-HJ-NP-TV-Z]{2}[A-Z]){2}(?:[\dLMNP-V]{2}(?:[A-EHLMPR-T](?:[04LQ][1-9MNP-V]|[15MR][\dLMNP-V]|[26NS][0-8LMNP-U])|[DHPS][37PT][0L]|[ACELMRT][37PT][01LM]|[AC-EHLMPR-T][26NS][9V])|(?:[02468LNQSU][048LQU]|[13579MPRTV][26NS])B[26NS][9V])(?:[A-MZ][1-9MNP-V][\dLMNP-V]{2}|[A-M][0L](?:[1-9MNP-V][\dLMNP-V]|[0L][1-9MNP-V]))[A-Z]$")
                                .hasMatch(value)) {
                              return 'Codice Fiscale inserito non esistente';
                            }

                            return null;
                          },
                        ),
                        SizedBox(height: size.height * 0.02),
                        CustomTextFormField(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          textInputAction: TextInputAction.next,
                          labelText: 'Nome',
                          keyboardType: TextInputType.name,
                          controller: nomeController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nome non inserito';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: size.height * 0.02),
                        CustomTextFormField(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          textInputAction: TextInputAction.next,
                          labelText: 'Cognome',
                          keyboardType: TextInputType.name,
                          controller: cognomeController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Cognome non inserito';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: size.height * 0.02),
                        CustomTextFormField(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          textInputAction: TextInputAction.next,
                          labelText: 'Codice Impegnativa (15 Cifre)',
                          keyboardType: TextInputType.number,
                          controller: impegnativaController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Codice Impegnativa non inserito';
                            }

                            if (!RegExp(r"\d{3}\w{2}\d{10}").hasMatch(value)) {
                              return 'Codice Impegnativa non valido';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: size.height * 0.02),
                        CustomTextFormField(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          textInputAction: TextInputAction.next,
                          labelText: 'Codice Autenticazione (30 cifre)',
                          keyboardType: TextInputType.number,
                          controller: codice_autenticazione_Controller,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Codice Autenticazione non inserito';
                            }

                            if (!RegExp(r"\d{30}").hasMatch(value)) {
                              return 'Codice Autenticazione non valido';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: size.height * 0.02),
                        CustomTextFormField(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          textInputAction: TextInputAction.next,
                          labelText:
                              'Codice ASL (Sigla Provincia + Codice di 3 cifre)',
                          keyboardType: TextInputType.text,
                          controller: codice_asl_Controller,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Codice ASL non inserito';
                            }

                            if (!RegExp(r"[A-Z]{2}\d{3}").hasMatch(value)) {
                              return 'Codice ASL non valido';
                            }

                            return null;
                          },
                        ),
                        SizedBox(height: size.height * 0.02),
                        CustomTextFormField(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          textInputAction: TextInputAction.next,
                          labelText: 'Prescrizione',
                          keyboardType: TextInputType.text,
                          controller: prescrizioneController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Prescrizione non inserita';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: size.height * 0.02),
                        CustomTextFormField(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          textInputAction: TextInputAction.next,
                          labelText: 'Data (gg/mm/aaaa)',
                          keyboardType: TextInputType.text,
                          controller: dataController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Data non inserita';
                            }

                            if (!RegExp(
                                    r"(3[01]|[12][0-9]|0?[1-9])(\/|-)(1[0-2]|0?[1-9])\2([0-9]{2})?[0-9]{2}")
                                .hasMatch(value)) {
                              return 'Data non valida (gg/mm/aaaa)';
                            }

                            return null;
                          },
                        ),
                        SizedBox(height: size.height * 0.02),
                        CustomTextFormField(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          textInputAction: TextInputAction.done,
                          labelText: 'Esenzione',
                          keyboardType: TextInputType.text,
                          controller: esenzioneController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Esenzione non inserita';
                            }

                            if (!RegExp(r"([A-Z]{1}\d{2})|([A-Za-z ]+)|(\d{3})")
                                .hasMatch(value)) {
                              return 'Esenzione non valida';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: size.height * 0.026),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.black,
                            elevation: 20,
                            backgroundColor: AppColors.bluChiaro,
                            fixedSize:
                                Size(size.width * 0.95, size.height * 0.06),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {

                              Ricetta ricetta= Ricetta(
                                impegnativa: impegnativaController.text,
                                codiceAsl: codice_asl_Controller.text,
                                codiceAutenticazione: codice_autenticazione_Controller.text,
                                nome: nomeController.text,
                                cf: CFController.text,
                                esenzione: esenzioneController.text,
                                prescrizione: prescrizioneController.text,
                                data: dataController.text,
                                cognome: cognomeController.text,
                              );

                              APIServices.addRicetta(ricetta);
                              final prefs= await SharedPreferences.getInstance();
                              String? email= prefs.getString("email");
                              String? password= prefs.getString("password");
                              if(email!=null && password!=null){
                                Utente? u = await APIServices.getUtente(email, password);
                                Scansione s=Scansione(idCf: u!.codiceFiscale,idImpegnativa: impegnativaController.text);
                                APIServices.addScansione(s);
                              }
                              
                              
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                      'Ricetta salvata con successo'),
                                  backgroundColor: Colors.green,
                                  behavior: SnackBarBehavior.floating,
                                  dismissDirection: DismissDirection.up,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  margin: EdgeInsets.only(
                                      bottom: size.height - 210,
                                      right: 10,
                                      left: 10),
                                ),
                              );
                              prescrizioneController.clear();
                              CFController.clear();
                              nomeController.clear();
                              cognomeController.clear();
                              dataController.clear();
                              esenzioneController.clear();
                              codice_asl_Controller.clear();
                              codice_autenticazione_Controller.clear();
                              impegnativaController.clear();
                              Navigator.pop(context);
                            }
                          },
                          child: const Text(
                            ' SALVA RICETTA',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: AppColors.oro),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )),
          )
        ],
      ),
    );
  }
}
