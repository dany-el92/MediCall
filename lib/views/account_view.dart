import 'package:flutter/material.dart';
import 'package:medicall/authentication/auth_service.dart';
import 'package:medicall/constants/colors.dart';
import 'package:medicall/constants/routes.dart';
import 'package:medicall/utilities/extensions.dart';
import 'package:medicall/utilities/show_dialogs.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

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
                        child: const Text('SC',
                            style:
                                TextStyle(color: Colors.white, fontSize: 30))),
                    SizedBox(height: size.height * 0.03),
                    const Text("Samuele Antonio Cesaro",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                    SizedBox(height: size.height * 0.02),
                    const Text("RSSMRA99D20F205R",
                        style: TextStyle(
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
              onPressed: () {},
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
            SizedBox(height: size.height * 0.02),
            ElevatedButton.icon(
              onPressed: () {},
              icon:
                  const Icon(Icons.people_alt, color: AppColors.oro, size: 25),
              label: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "I miei familiari",
                    style: TextStyle(
                        color: AppColors.oro,
                        fontSize: 15,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.add, color: AppColors.oro, size: 25)
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
            const Text("Connessione",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
            SizedBox(height: size.height * 0.03),
            ElevatedButton.icon(
              onPressed: () {},
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
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.key, color: AppColors.oro, size: 25),
              label: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Password",
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
              onPressed: () {},
              icon: const Icon(Icons.delete, color: AppColors.oro, size: 25),
              label: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Elimina Account",
                    style: TextStyle(
                        color: AppColors.oro,
                        fontSize: 15,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.warning, color: AppColors.oro, size: 25)
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
