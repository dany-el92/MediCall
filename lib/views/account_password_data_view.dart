import 'package:flutter/material.dart';
import 'package:medicall/constants/colors.dart';
import 'package:medicall/utilities/extensions.dart';

class AccountPasswordDataView extends StatefulWidget {

  final String password, nome, cognome;

  const AccountPasswordDataView({
    Key? key,
    required this.password,
    required this.nome,
    required this.cognome}) : super(key: key);

  @override
  State<AccountPasswordDataView> createState() => _AccountPasswordDataViewState();
}

class _AccountPasswordDataViewState extends State<AccountPasswordDataView> {

  TextEditingController passwordController = TextEditingController();

  @override
  void initState(){
    super.initState();
    passwordController.text = widget.password;
  }

  @override
  void dispose(){
    passwordController.dispose();
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
          "Password",
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
                              style:
                              const TextStyle(color: Colors.white, fontSize: 30))),
                    ],
                  )
                ],
              ),
              SizedBox(height: size.height * 0.05),
              TextField(
                controller: passwordController ,
                obscureText: true,
                obscuringCharacter: "*",
                textInputAction: TextInputAction.none,
                readOnly: true,
                canRequestFocus: false,
                decoration: const InputDecoration(label: Text("Password"), prefixIcon: Icon(Icons.key), floatingLabelBehavior: FloatingLabelBehavior.always, filled: true),
              ),
            ],
          ),
        ),
      ) ,
    );
  }
}