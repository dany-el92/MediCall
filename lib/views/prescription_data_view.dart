import 'package:flutter/material.dart';
import 'package:medicall/components/custom_text_form_field.dart';
import 'package:medicall/constants/colors.dart';
import 'package:medicall/database/ricetta_medica.dart';
import 'package:medicall/utilities/api_services.dart';
import 'package:medicall/utilities/extensions.dart';
import 'package:medicall/utilities/show_dialogs.dart';

class PrescriptionDataView extends StatefulWidget {

  final Ricetta ricetta;

  const PrescriptionDataView({Key? key, required this.ricetta}) : super(key: key);

  @override
  State<PrescriptionDataView> createState() => _PrescriptionDataViewState();
}

class _PrescriptionDataViewState extends State<PrescriptionDataView> {

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
    nomeController.text = widget.ricetta.nome!;
    cognomeController.text = widget.ricetta.cognome!;
    CFController.text = widget.ricetta.cf!;
    esenzioneController.text = widget.ricetta.esenzione!;
    prescrizioneController.text = widget.ricetta.prescrizione!;
    codice_asl_Controller.text = widget.ricetta.codiceAsl!;
    dataController.text = widget.ricetta.data!;
    impegnativaController.text = widget.ricetta.impegnativa!;
    codice_autenticazione_Controller.text = widget.ricetta.codiceAutenticazione!;
  }

  @override
  void dispose(){
    nomeController.dispose();
    cognomeController.dispose();
    CFController.dispose();
    esenzioneController.dispose();
    prescrizioneController.dispose();
    codice_asl_Controller.dispose();
    dataController.dispose();
    impegnativaController.dispose();
    codice_autenticazione_Controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
     final size = context.mediaQuerySize;
    return Scaffold(
       appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.oro),
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
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.02),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomTextFormField(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        textInputAction: TextInputAction.none,
                        labelText: 'Codice Fiscale',
                        keyboardType: TextInputType.none,
                        controller: CFController,
                      ),
                      SizedBox(height: size.height * 0.02),
                      CustomTextFormField(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        textInputAction: TextInputAction.none,
                        labelText: 'Nome',
                        keyboardType: TextInputType.none,
                        controller: nomeController,
                      ),
                      SizedBox(height: size.height * 0.02),
                      CustomTextFormField(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        textInputAction: TextInputAction.none,
                        labelText: 'Cognome',
                        keyboardType: TextInputType.none,
                        controller: cognomeController,
                      ),
                      SizedBox(height: size.height * 0.02),
                      CustomTextFormField(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        textInputAction: TextInputAction.none,
                        labelText: 'Codice Impegnativa',
                        keyboardType: TextInputType.none,
                        controller: impegnativaController,
                      ),
                      SizedBox(height: size.height * 0.02),
                      CustomTextFormField(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        textInputAction: TextInputAction.none,
                        labelText: 'Codice Autenticazione',
                        keyboardType: TextInputType.none,
                        controller: codice_autenticazione_Controller,
                      ),
                      SizedBox(height: size.height * 0.02),
                      CustomTextFormField(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        textInputAction: TextInputAction.none,
                        labelText:
                            'Codice ASL',
                        keyboardType: TextInputType.none,
                        controller: codice_asl_Controller,
                      ),
                      SizedBox(height: size.height * 0.02),
                      CustomTextFormField(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        textInputAction: TextInputAction.none,
                        labelText: 'Prescrizione',
                        keyboardType: TextInputType.none,
                        controller: prescrizioneController,
                      ),
                      SizedBox(height: size.height * 0.02),
                      CustomTextFormField(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        textInputAction: TextInputAction.none,
                        labelText: 'Data',
                        keyboardType: TextInputType.none,
                        controller: dataController,
                      ),
                      SizedBox(height: size.height * 0.02),
                      CustomTextFormField(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        textInputAction: TextInputAction.none,
                        labelText: 'Esenzione',
                        keyboardType: TextInputType.none,
                        controller: esenzioneController,
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
                        onPressed: () async{
                          final choose = await showDeletePrescriptionDialog(context);
                          if(choose){
                            APIServices.deleteRicetta(widget.ricetta.impegnativa!);
                            Navigator.pop(context,true);
                          }
                        }, 
                        child: const Text(
                          "ELIMINA RICETTA",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.red
                          ),
                        )
                      ),
                    ],
                  )
                ],
              ),
            )),
          )
        ],
      ),
    );
  }
}