import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicall/constants/colors.dart';
import 'package:medicall/constants/images.dart';
import 'package:medicall/database/ricetta_medica.dart';
import 'package:medicall/database/utente.dart';
import 'package:medicall/utilities/api_services.dart';
import 'package:medicall/utilities/image_picker_service.dart';
import 'package:medicall/views/prescription_data_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrescriptionView extends StatefulWidget {
  const PrescriptionView({super.key});

  @override
  State<PrescriptionView> createState() => _PrescriptionViewState();
}

class _PrescriptionViewState extends State<PrescriptionView> {

  late Future<RicettaList?> rlist;

  Future<RicettaList?> getAllRicetteUtente() async{
    final prefs= await SharedPreferences.getInstance();
    String? email = prefs.getString("email");
    String? password = prefs.getString("password");
    if(email!=null && password!=null){
      Utente? u = await APIServices.getUtente(email, password);
      RicettaList? ricette = await APIServices.getRicetteFromUtente(u!);
      return ricette;
    }

    return null;
  }

  @override
  void initState(){
    super.initState();
    rlist = getAllRicetteUtente();
  }

  @override
  void dispose(){
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
        final success = await ImagePickerService().regexText(context);
        if(success!=null && success){
          setState(() {
            rlist=getAllRicetteUtente();
          });
        }
        },
        foregroundColor: Colors.white,
        extendedPadding: const EdgeInsets.symmetric(horizontal: 7.5),
        backgroundColor: AppColors.bluChiaro,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Aggiungi ricetta'),
        extendedTextStyle:
            const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: FutureBuilder<RicettaList?>(
        future: rlist , 
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top:230)
                  ),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(),
                  )
                ],
              ),
            );

          } else if(snapshot.hasData){
            final ricette= snapshot.data!;
            if(ricette.items!.isNotEmpty){
              return withPrescription(ricette);

            } else {
              return noPrescription();
            }
            
          } else{
            return noPrescription();
          }
        })
    );
  }

  Widget noPrescription(){
    return Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(15),
            child: Row(children: [
              Text('Le mie ricette',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  )),
            ]),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  ImageConstant.prescriptionImage,
                  height: 200,
                  width: 200,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Gestisci le tue ricette',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'Salva le tue ricette e tienile sempre con te per averle sempre a portata di mano e non perderle mai più!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                //const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      );
  }

  Widget withPrescription(RicettaList list){
    return Column(
      children: [
         const Padding(
            padding: EdgeInsets.all(15),
            child: Row(children: [
              Text('Le mie ricette',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  )),
            ]),
          ),
          Expanded(
            child: ListView.builder(
            itemCount: list.items!.length,
            itemBuilder: (context, index){
              final ricetta = list.items![index];
              return Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: AppColors.bluChiaro),
                child: ListTile(
                  title:Text("${ricetta.nome}${ricetta.cognome}",style: const TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Text(ricetta.prescrizione!),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  leading: const Icon(Icons.receipt_long_rounded),
                  iconColor: AppColors.oro,
                  textColor: AppColors.oro,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PrescriptionDataView(ricetta: ricetta)));
                    },
                  ),
                );
              }
            )
          )
      ],
    );
  }
}
