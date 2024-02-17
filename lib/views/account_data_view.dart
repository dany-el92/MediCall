import 'package:flutter/material.dart';
import 'package:medicall/constants/colors.dart';
import 'package:medicall/utilities/extensions.dart';

class AccountDataView extends StatefulWidget {
  final String cf, nome, cognome, genere, dataNascita;

  const AccountDataView(
      {Key? key,
      required this.cf,
      required this.nome,
      required this.cognome,
      required this.genere,
      required this.dataNascita})
      : super(key: key);

  @override
  State<AccountDataView> createState() => _AccountDataViewState();
}

class _AccountDataViewState extends State<AccountDataView> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController cognomeController = TextEditingController();
  TextEditingController CFController = TextEditingController();
  TextEditingController dataController = TextEditingController();
  TextEditingController genereController = TextEditingController();
  Icon genereIcon = const Icon(Icons.transgender);

  @override
  void initState() {
    super.initState();
    nomeController.text = widget.nome;
    cognomeController.text = widget.cognome;
    CFController.text = widget.cf;
    dataController.text = widget.dataNascita;
    genereController.text = widget.genere;
    if (widget.genere == "Maschio") {
      genereIcon = const Icon(Icons.male_rounded);
    } else if (widget.genere == "Femmina") {
      genereIcon = const Icon(Icons.female_rounded);
    }
  }

  @override
  void dispose() {
    nomeController.dispose();
    cognomeController.dispose();
    CFController.dispose();
    dataController.dispose();
    genereController.dispose();
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
            "Il mio profilo",
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.oro, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.blueAccent.shade700,
                            child: Text("${widget.nome[0]}${widget.cognome[0]}",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 30))),
                      ],
                    )
                  ],
                ),
                SizedBox(height: size.height * 0.05),
                TextField(
                  controller: CFController,
                  textInputAction: TextInputAction.none,
                  readOnly: true,
                  canRequestFocus: false,
                  decoration: const InputDecoration(
                      label: Text("Codice Fiscale"),
                      prefixIcon: Icon(Icons.verified_user),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      filled: true),
                ),
                SizedBox(height: size.height * 0.03),
                TextField(
                  controller: nomeController,
                  textInputAction: TextInputAction.none,
                  readOnly: true,
                  canRequestFocus: false,
                  decoration: const InputDecoration(
                      label: Text("Nome"),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      prefixIcon: Icon(Icons.abc),
                      filled: true),
                ),
                SizedBox(height: size.height * 0.03),
                TextField(
                  controller: cognomeController,
                  textInputAction: TextInputAction.none,
                  readOnly: true,
                  canRequestFocus: false,
                  decoration: const InputDecoration(
                      label: Text("Cognome"),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      prefixIcon: Icon(Icons.abc),
                      filled: true),
                ),
                SizedBox(height: size.height * 0.03),
                TextField(
                    controller: dataController,
                    textInputAction: TextInputAction.none,
                    readOnly: true,
                    canRequestFocus: false,
                    decoration: const InputDecoration(
                        label: Text("Data di Nascita"),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        prefixIcon: Icon(Icons.date_range),
                        filled: true)),
                SizedBox(height: size.height * 0.03),
                TextField(
                  controller: genereController,
                  textInputAction: TextInputAction.none,
                  readOnly: true,
                  canRequestFocus: false,
                  decoration: InputDecoration(
                      label: const Text("Genere"),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      prefixIcon: genereIcon,
                      filled: true),
                )
              ],
            ),
          ),
        ));
  }
}
