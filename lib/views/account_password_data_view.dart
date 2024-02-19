import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicall/authentication/auth_service.dart';
import 'package:medicall/constants/colors.dart';
import 'package:medicall/constants/routes.dart';
import 'package:medicall/utilities/api_services.dart';
import 'package:medicall/utilities/extensions.dart';
import 'package:medicall/utilities/show_dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPasswordDataView extends StatefulWidget {

  final String password, nome, cognome, cf, email;

  const AccountPasswordDataView({
    Key? key,
    required this.password,
    required this.nome,
    required this.cognome,
    required this.cf,
    required this.email}) : super(key: key);

  @override
  State<AccountPasswordDataView> createState() => _AccountPasswordDataViewState();
}

class _AccountPasswordDataViewState extends State<AccountPasswordDataView> {

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose(){
    passwordController.dispose();
    confirmPasswordController.dispose();
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
          "Modifica Password",
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
                obscuringCharacter: '*',
                textInputAction: TextInputAction.next,
                canRequestFocus: true,
                decoration: const InputDecoration(label: Text("Nuova Password"), prefixIcon: Icon(Icons.key), floatingLabelBehavior: FloatingLabelBehavior.always, filled: true),
              ),
              SizedBox(height: size.height * 0.05),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                obscuringCharacter: '*',
                textInputAction: TextInputAction.done,
                canRequestFocus: true,
                decoration: const InputDecoration(label: Text("Conferma Password"), prefixIcon: Icon(Icons.key), floatingLabelBehavior: FloatingLabelBehavior.always, filled: true),
              ),
              SizedBox(height: size.height * 0.35),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.black,
                  elevation: 20,
                  backgroundColor: AppColors.bluChiaro,
                  fixedSize: Size(size.width* 0.95, size.height * 0.06)
                ),
                onPressed: () async{
                  if(passwordController.text.isNotEmpty && confirmPasswordController.text.isNotEmpty && passwordController.text == confirmPasswordController.text){
                    final prefs = await SharedPreferences.getInstance();
                    final user = FirebaseAuth.instance.currentUser!;
                    await user.reauthenticateWithCredential(
                        EmailAuthProvider.credential(
                            email: widget.email, password: widget.password));

                    user.updatePassword(passwordController.text);
                    APIServices.updateUtente(passwordController.text, widget.cf);
                    prefs.remove("email");
                    prefs.remove("password");
                    prefs.clear();
                    final end = await showNewPasswordConfirmedDialog(context);
                    if(end){
                      await AuthService.firebase().logOut();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                            Routes.loginView, (_) => false);
                    }
                    
                  } else{
                    showMissingPasswordDetailsDialog(context);
                  }
                }, 
                child: const Text(
                  "MODIFICA PASSWORD",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColors.oro
                  ),
                )
              )
            ],
          ),
        ),
      ) ,
    );
  }
}