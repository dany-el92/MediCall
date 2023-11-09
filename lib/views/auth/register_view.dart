import 'package:flutter/material.dart';
import 'package:medicall/components/custom_text_form_field.dart';
import 'package:medicall/constants/colors.dart';
import 'package:medicall/utilities/extensions.dart';

import '../../constants/images.dart';

final _formKey = GlobalKey<FormState>();

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}



class _RegisterViewState extends State<RegisterView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController CFController= TextEditingController();
  TextEditingController nomeController= TextEditingController();
  TextEditingController cognomeController= TextEditingController();
  TextEditingController dataController= TextEditingController();
  TextEditingController genereController= TextEditingController();
  bool isObscure = true;

 Future<void> _selectDate() async{
   DateTime? _picked = await showDatePicker
   (context: context, 
   initialDate: DateTime.now(), 
   firstDate: DateTime(1900), 
   lastDate: DateTime(2100));

   if(_picked!= null){
      setState(() {
        dataController.text= _picked.toString().split(" ")[0];
      });
   }
  }

  String? dropDownValue;

  @override  

  Widget build(BuildContext context) {
    final size = context.mediaQuerySize;
    return Scaffold(
     body: Container(
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
            ])),
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
                      //Input Codice Fiscale
                      CustomTextFormField(
                        textInputAction: TextInputAction.next, 
                        labelText: 'Codice Fiscale', 
                        keyboardType: TextInputType.text, 
                        controller: CFController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Codice Fiscale non inserito';
                          }
                          return null;
                          },
                        ),
                      
                      //Input Nome
                       SizedBox(height: size.height * 0.02),
                      CustomTextFormField(
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


                      //Input Cognome
                      SizedBox(height: size.height * 0.02),
                      CustomTextFormField(
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

                      //Input Email
                      SizedBox(height: size.height * 0.02),
                      CustomTextFormField(
                        textInputAction: TextInputAction.next,
                        labelText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        suffixIcon: const Padding(
                          padding: EdgeInsets.only(right: 20.0),
                          child: Icon(
                            Icons.email,
                          ),
                        ),
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email non inserita';
                          }
                          return null;
                        },
                      ),
                    

                    //Input Password
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
                              color: Colors.black,
                            ),
                          ),
                        ),
                        controller: passwordController,
                        validator: null, //TODO: Add validator
                      ),


                      //Input Data di Nascita
                      SizedBox(height: size.height * 0.02),
                      CustomTextFormField(
                        onTap: _selectDate,
                        textInputAction: TextInputAction.next, 
                        labelText: 'Data di Nascita',
                        keyboardType: TextInputType.none, 
                        controller: dataController,
                        suffixIcon: const Padding(
                          padding: EdgeInsets.only(right: 20.0),
                          child:Icon(
                              Icons.calendar_today)
                          ),  
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Data non inserita';
                          }
                          return null;
                          },
                        ),
                      

                     

                      //Input Genere
                      SizedBox(height: size.height * 0.02),
                      /*CustomTextFormField(
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
                        items: <String>['Maschio','Femmina','Altro'].map<DropdownMenuItem<String>>((
                          String value){
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }
                        ).toList(),
                        hint: const Text('Genere'),
                        value: dropDownValue,
                        onChanged: (String? newValue){
                          setState(() {
                            dropDownValue=newValue!;
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
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          fillColor: Colors.white,
                          filled: true,
                        ),
                       ),


                      SizedBox(height: size.height * 0.04),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.black,
                          elevation: 20,
                          backgroundColor: AppColors.oro,
                          foregroundColor: Colors.black,
                          fixedSize:
                              Size(size.width * 0.95, size.height * 0.06),
                        ),
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Registrazione avvenuta con successo'),
                              ),
                            );
                            emailController.clear();
                            passwordController.clear();
                            CFController.clear();
                            nomeController.clear();
                            cognomeController.clear();
                            dataController.clear();
                            genereController.clear();
                          }
                        },
                        child: const Text(
                          ' REGISTRATI',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),       
    );
  }
}