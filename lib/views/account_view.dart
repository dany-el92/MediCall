import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicall/authentication/auth_service.dart';
import 'package:medicall/constants/colors.dart';
import 'package:medicall/constants/routes.dart';
import 'package:medicall/database/utente.dart';
import 'package:medicall/utilities/api_services.dart';
import 'package:medicall/utilities/extensions.dart';
import 'package:medicall/utilities/show_dialogs.dart';
import 'package:medicall/views/account_password_data_view.dart';
import 'package:medicall/views/account_data_view.dart';
//import 'package:medicall/views/account_email_data_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountView extends StatelessWidget {
  final Utente utente;

  const AccountView({super.key, required this.utente});

  @override
  Widget build(BuildContext context) {
    final size = context.mediaQuerySize;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 23,
                  backgroundColor: AppColors.bluChiaro,
                  child: IconButton(
                    onPressed: () async {
                      final shouldLogout = await showLogOutDialog(context);
                      //True se l'utente sceglie di uscire, false se annulla
                      if (shouldLogout) {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.remove("email");
                        prefs.remove("password");
                        prefs.clear();
                        await AuthService.firebase().logOut();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Routes.loginView, (_) => false);
                      }
                    },
                    icon: const Icon(
                      Icons.exit_to_app,
                      size: 25,
                    ),
                    tooltip: "Disconnettiti",
                    color: AppColors.oro,
                  ),
                )
              ],
            ),
            SizedBox(height: size.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.blueAccent.shade700,
                        child: Text("${utente.nome![0]}${utente.cognome![0]}",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 30))),
                    SizedBox(height: size.height * 0.03),
                    Text("${utente.nome} ${utente.cognome}",
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                    SizedBox(height: size.height * 0.02),
                    Text("${utente.codiceFiscale}",
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.normal))
                  ],
                )
              ],
            ),
            SizedBox(height: size.height * 0.03),
            const Divider(color: AppColors.bluScuro, thickness: 1.5),
            SizedBox(height: size.height * 0.03),
            const Text(
              "Identità",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            SizedBox(height: size.height * 0.03),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.person,
                color: AppColors.oro,
                size: 25,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AccountDataView(
                        cf: utente.codiceFiscale!,
                        nome: utente.nome!,
                        cognome: utente.cognome!,
                        genere: utente.genere!,
                        dataNascita: utente.dataNascita!,
                        email: utente.email!,)));
              },
              label: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Il mio profilo",
                      style: TextStyle(
                          color: AppColors.oro,
                          fontSize: 15,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.bold)),
                  Icon(Icons.arrow_forward_ios, color: AppColors.oro, size: 25)
                ],
              ),
              style: ElevatedButton.styleFrom(
                alignment: Alignment.centerLeft,
                backgroundColor: AppColors.bluChiaro,
                foregroundColor: Colors.black,
                fixedSize: Size(size.width * 0.95, size.height * 0.06),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            // SizedBox(height: size.height * 0.02),
            // ElevatedButton.icon(
            //   onPressed: () {},
            //   icon:
            //       const Icon(Icons.people_alt, color: AppColors.oro, size: 25),
            //   label: const Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         "I miei familiari",
            //         style: TextStyle(
            //             color: AppColors.oro,
            //             fontSize: 15,
            //             letterSpacing: 1.0,
            //             fontWeight: FontWeight.bold),
            //       ),
            //       Icon(Icons.add, color: AppColors.oro, size: 25)
            //     ],
            //   ),
            //   style: ElevatedButton.styleFrom(
            //     alignment: Alignment.centerLeft,
            //     backgroundColor: AppColors.bluChiaro,
            //     foregroundColor: Colors.black,
            //     fixedSize: Size(size.width * 0.95, size.height * 0.06),
            //     elevation: 4,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(15),
            //     ),
            //   ),
            // ),
            SizedBox(height: size.height * 0.05),
            const Text("Connessione",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
            SizedBox(height: size.height * 0.03),
   /*         ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AccountEmailDataView(
                        email: utente.email!,
                        nome: utente.nome!,
                        cognome: utente.cognome!)));
              },
              icon: const Icon(Icons.email, color: AppColors.oro, size: 25),
              label: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Email",
                    style: TextStyle(
                        color: AppColors.oro,
                        fontSize: 15,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.arrow_forward_ios, color: AppColors.oro, size: 25)
                ],
              ),
              style: ElevatedButton.styleFrom(
                alignment: Alignment.centerLeft,
                backgroundColor: AppColors.bluChiaro,
                foregroundColor: Colors.black,
                fixedSize: Size(size.width * 0.95, size.height * 0.06),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
             SizedBox(height: size.height * 0.02),
   */          ElevatedButton.icon(
               onPressed: () {
                 Navigator.of(context).push(MaterialPageRoute(
                     builder: (context) => AccountPasswordDataView(
                         cognome: utente.cognome!,
                         nome: utente.nome!,
                         password: utente.password!,
                         cf: utente.codiceFiscale!,
                         email: utente.email!)));
               },
               icon: const Icon(Icons.key, color: AppColors.oro, size: 25),
               label: const Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text(
                     "Modifica Password",
                     style: TextStyle(
                         color: AppColors.oro,
                         fontSize: 15,
                         letterSpacing: 1.0,
                         fontWeight: FontWeight.bold),
                   ),
                   Icon(Icons.arrow_forward_ios, color: AppColors.oro, size: 25)
                 ],
               ),
               style: ElevatedButton.styleFrom(
                 alignment: Alignment.centerLeft,
                 backgroundColor: AppColors.bluChiaro,
                 foregroundColor: Colors.black,
                 fixedSize: Size(size.width * 0.95, size.height * 0.06),
                 elevation: 4,
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(15),
                 ),
               ),
             ),
            SizedBox(height: size.height * 0.05),
            const Text("Riservatezza",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
            SizedBox(height: size.height * 0.03),
            ElevatedButton.icon(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                final choose = await showDeleteAccountDialog(context);
                if (choose) {
                  APIServices.deleteUtente(utente.codiceFiscale!);
                  prefs.remove("email");
                  prefs.remove("password");
                  prefs.clear();
                  final user = FirebaseAuth.instance.currentUser!;
                  await user.reauthenticateWithCredential(
                      EmailAuthProvider.credential(
                          email: utente.email!, password: utente.password!));
                  await user.delete();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(Routes.loginView, (_) => false);
                }
              },
              icon: const Icon(Icons.delete, color: Colors.red, size: 25),
              label: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Elimina Account",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.warning, color: Colors.red, size: 25)
                ],
              ),
              style: ElevatedButton.styleFrom(
                alignment: Alignment.centerLeft,
                backgroundColor: AppColors.bluChiaro,
                foregroundColor: Colors.black,
                fixedSize: Size(size.width * 0.95, size.height * 0.06),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.05),
            // Spazio sotto il pulsante elimina account
          ],
        ),
      ),
    );
  }
}
