import 'package:flutter/material.dart';
import 'package:medicall/authentication/auth_exceptions.dart';
import 'package:medicall/authentication/auth_service.dart';
import 'package:medicall/components/custom_text_form_field.dart';
import 'package:medicall/constants/colors.dart';
import 'package:medicall/constants/routes.dart';
import 'package:medicall/utilities/extensions.dart';
import 'package:email_validator/email_validator.dart';
import 'package:medicall/utilities/show_dialogs.dart';
import '../../constants/images.dart';

final _formKey = GlobalKey<FormState>();

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _CFController;
  late final TextEditingController _nomeController;
  late final TextEditingController _cognomeController;
  late final TextEditingController _dataController;
  late final TextEditingController _genereController;
  bool isObscure = true;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _CFController = TextEditingController();
    _nomeController = TextEditingController();
    _cognomeController = TextEditingController();
    _dataController = TextEditingController();
    _genereController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _CFController.dispose();
    _nomeController.dispose();
    _cognomeController.dispose();
    _dataController.dispose();
    _genereController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));

    if (_picked != null) {
      setState(() {
        _dataController.text = _picked.toString().split(" ")[0];
      });
    }
  }

  String? dropDownValue;

  @override
  Widget build(BuildContext context) {
    final size = context.mediaQuerySize;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.5, 0),
                end: Alignment(0.5, 1),
                colors: [
                  AppColors.bluChiaro,
                  AppColors.bluMedio,
                  AppColors.bluScuro,
                ],
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.1),
                      Image.asset(ImageConstant.imgLogo),
                      SizedBox(height: size.height * 0.03),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Input Codice Fiscale
                          CustomTextFormField(
                            textInputAction: TextInputAction.next,
                            labelText: 'Codice Fiscale',
                            keyboardType: TextInputType.text,
                            controller: _CFController,
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

                          // Input Nome
                          SizedBox(height: size.height * 0.02),
                          CustomTextFormField(
                            textInputAction: TextInputAction.next,
                            labelText: 'Nome',
                            keyboardType: TextInputType.name,
                            controller: _nomeController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Nome non inserito';
                              }
                              return null;
                            },
                          ),

                          // Input Cognome
                          SizedBox(height: size.height * 0.02),
                          CustomTextFormField(
                            textInputAction: TextInputAction.next,
                            labelText: 'Cognome',
                            keyboardType: TextInputType.name,
                            controller: _cognomeController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Cognome non inserito';
                              }
                              return null;
                            },
                          ),

                          // Input Email
                          SizedBox(height: size.height * 0.02),
                          CustomTextFormField(
                            textInputAction: TextInputAction.next,
                            labelText: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            suffixIcon: const Padding(
                              padding: EdgeInsets.only(right: 20.0),
                              child: Icon(
                                Icons.email,
                                color: AppColors.bluChiaro,
                              ),
                            ),
                            controller: _emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email non inserita';
                              }

                              if (!EmailValidator.validate(value)) {
                                return 'Email inserita non valida';
                              }
                              return null;
                            },
                          ),

                          // Input Password
                          SizedBox(height: size.height * 0.02),
                          CustomTextFormField(
                            textInputAction: TextInputAction.next,
                            labelText: 'Password',
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: isObscure,
                            suffixIcon: IconButton(
                              highlightColor: Colors.transparent,
                              onPressed: () {
                                setState(() {
                                  isObscure = !isObscure;
                                });
                              },
                              style: IconButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              icon: Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Icon(
                                  isObscure
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: AppColors.bluChiaro,
                                ),
                              ),
                            ),
                            controller: _passwordController,
                            validator: null, // TODO: Add validator
                          ),

                          // Input Data di Nascita
                          SizedBox(height: size.height * 0.02),
                          CustomTextFormField(
                            onTap: _selectDate,
                            textInputAction: TextInputAction.next,
                            labelText: 'Data di Nascita',
                            keyboardType: TextInputType.none,
                            controller: _dataController,
                            suffixIcon: const Padding(
                                padding: EdgeInsets.only(right: 20.0),
                                child: Icon(
                                  Icons.calendar_today,
                                  color: AppColors.bluChiaro,
                                )),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Data non inserita';
                              }
                              return null;
                            },
                          ),

                          // Input Genere
                          SizedBox(height: size.height * 0.02),
                          /*
                          CustomTextFormField(
                            textInputAction: TextInputAction.done,
                            labelText: 'Genere',
                            keyboardType: TextInputType.none,
                            controller: genereController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Genere non inserito';
                              }
                              return null;
                            },
                          ),
                          */
                          DropdownButtonFormField<String>(
                            items: <String>['Maschio', 'Femmina', 'Altro']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            hint: const Text('Genere'),
                            value: dropDownValue,
                            onChanged: (String? newValue) {
                              setState(() {
                                dropDownValue = newValue!;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Genere non inserito';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 15,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                              labelStyle: const TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              fillColor: Colors.white,
                              filled: true,
                              icon: null, // Rimuovi la freccia predefinita
                            ),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: AppColors.bluChiaro,
                            ),
                          ),

                          SizedBox(height: size.height * 0.04),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shadowColor: Colors.black,
                              elevation: 20,
                              backgroundColor: AppColors.oro,
                              fixedSize:
                                  Size(size.width * 0.95, size.height * 0.06),
                            ),
                            onPressed: () async {
                              //Ultimo testo che l'utente ha digitato nei campi
                              final email = _emailController.text;
                              final password = _passwordController.text;

                              try {
                                await AuthService.firebase().createUser(
                                  email: email,
                                  password: password,
                                );

                                AuthService.firebase().sendEmailVerification();
                                //Non rimuove tutte le view precedenti, ma fa solo una push della nuova schermata su quelle già presenti
                                Navigator.of(context)
                                    .pushNamed(Routes.verifyMailView);
                              } on WeakPasswordAuthException {
                                await showErrorDialog(
                                    context, 'Password debole');
                              } on EmailAlreadyInUseAuthException {
                                await showErrorDialog(
                                    context, 'Email già in uso');
                              } on InvalidEmailAuthException {
                                await showErrorDialog(
                                    context, 'Email non valida');
                              } on GenericAuthException {
                                await showErrorDialog(
                                    context, 'Errore di registrazione');
                              }
                              // if (_formKey.currentState?.validate() ?? false) {
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //     const SnackBar(
                              //       content: Text(
                              //           'Registrazione avvenuta con successo'),
                              //     ),
                              //   );
                              //   emailController.clear();
                              //   passwordController.clear();
                              //   CFController.clear();
                              //   nomeController.clear();
                              //   cognomeController.clear();
                              //   dataController.clear();
                              //   genereController.clear();
                              //   Navigator.pop(context);
                              // }
                            },
                            child: const Text(
                              ' REGISTRATI',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.bluMedio),
                            ),
                          ),
                          // Spazio sotto il pulsante di registrazione
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Hai già un account?',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      Routes.loginView, (route) => false);
                                },
                                child: const Text(
                                  'Accedi',
                                  style: TextStyle(
                                    color: AppColors.oro,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
