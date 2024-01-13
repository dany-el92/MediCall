import 'dart:convert';
import 'dart:io';
import 'package:medicall/utilities/show_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicall/utilities/permission_request.dart';
import 'package:medicall/utilities/request.dart';
import 'package:medicall/views/scan_result_view.dart';
import 'package:url_launcher/url_launcher.dart';

class ImagePickerService {
  Future<PickedFile> pickImage({required ImageSource source}) async {
    final xFileSource = await ImagePicker().pickImage(source: source);
    if(xFileSource != null){
       return PickedFile(xFileSource.path);
    }
    return PickedFile('');
  }

  Future<void> printTextFromUrl(BuildContext context) async {
    //TODO: cambiare url del server
    var data = await getData('http://10.0.2.2:5000/');
    var decodedData = jsonDecode(data);
    //chiave del JSON del server
    var text = decodedData['url'];

    final Uri url = Uri.parse(text);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<XFile?> chooseImageFile(BuildContext context) async {
    try {
      return await showModalBottomSheet(
          context: context, builder: (builder) => bottomSheet(context));
    } catch (e) {
      print('errore');
    }
    return null;
  }

  Future<void> scanImage(File file, BuildContext context) async {
    final textRecognizer = TextRecognizer();
    final navigator = Navigator.of(context);
    try {
      final inputImage = InputImage.fromFile(file);
      final recognizerText = await textRecognizer.processImage(inputImage);
      //Inserisce in una variable text il testo riconosciuto
      //String text = recognizerText.text;
      String nome='', cognome='', impegnativa='', CF='', auth='',esenzione='',data='',provincia='',asl='', prescrizione='', imp1='',imp2='', codice_asl='';
      RegExp exp_nc= RegExp(r"(((DELL'ASSISTITO:) |(DELLASSISTITO:) |(DELL'ASSISTITO) |(DELLASSISTITO) )[A-Za-z ]+|((DELL'ASSISTITO:)\n|(DELLASSISTITO:)\n|(DELL'ASSISTITO)\n|(DELLASSISTITO)\n)[A-Za-z ]+)");
      RegExp exp_nc2 = RegExp(r"(DELL'ASSISTITO:)|(DELLASSISTITO:)|(DELL'ASSISTITO)|(DELLASSISTITO)");
      RegExp exp_imp = RegExp(r'^("\d{3}\w{2}\*)|(\*\d{3}\w{2}\*)|(\d{3}\w{2})|("\d{3}\w{2})|(\*\d{3}\w{2})|(\d{3}\w{2}")|(\d{3}\w{2}\*)$');
      RegExp exp_imp2= RegExp(r'^("\d{10}\*)|(\*\d{10}\*)|(\d{10})|("\d{10})|(\*\d{10})|(\d{10}")|(\d{10}\*)$');
      RegExp exp_CF= RegExp(r'^("(?:[A-Z][AEIOU][AEIOUX]|[AEIOU]X{2}|[B-DF-HJ-NP-TV-Z]{2}[A-Z]){2}(?:[\dLMNP-V]{2}(?:[A-EHLMPR-T](?:[04LQ][1-9MNP-V]|[15MR][\dLMNP-V]|[26NS][0-8LMNP-U])|[DHPS][37PT][0L]|[ACELMRT][37PT][01LM]|[AC-EHLMPR-T][26NS][9V])|(?:[02468LNQSU][048LQU]|[13579MPRTV][26NS])B[26NS][9V])(?:[A-MZ][1-9MNP-V][\dLMNP-V]{2}|[A-M][0L](?:[1-9MNP-V][\dLMNP-V]|[0L][1-9MNP-V]))[A-Z]\*)|(\*(?:[A-Z][AEIOU][AEIOUX]|[AEIOU]X{2}|[B-DF-HJ-NP-TV-Z]{2}[A-Z]){2}(?:[\dLMNP-V]{2}(?:[A-EHLMPR-T](?:[04LQ][1-9MNP-V]|[15MR][\dLMNP-V]|[26NS][0-8LMNP-U])|[DHPS][37PT][0L]|[ACELMRT][37PT][01LM]|[AC-EHLMPR-T][26NS][9V])|(?:[02468LNQSU][048LQU]|[13579MPRTV][26NS])B[26NS][9V])(?:[A-MZ][1-9MNP-V][\dLMNP-V]{2}|[A-M][0L](?:[1-9MNP-V][\dLMNP-V]|[0L][1-9MNP-V]))[A-Z]\*)|("(?:[A-Z][AEIOU][AEIOUX]|[AEIOU]X{2}|[B-DF-HJ-NP-TV-Z]{2}[A-Z]){2}(?:[\dLMNP-V]{2}(?:[A-EHLMPR-T](?:[04LQ][1-9MNP-V]|[15MR][\dLMNP-V]|[26NS][0-8LMNP-U])|[DHPS][37PT][0L]|[ACELMRT][37PT][01LM]|[AC-EHLMPR-T][26NS][9V])|(?:[02468LNQSU][048LQU]|[13579MPRTV][26NS])B[26NS][9V])(?:[A-MZ][1-9MNP-V][\dLMNP-V]{2}|[A-M][0L](?:[1-9MNP-V][\dLMNP-V]|[0L][1-9MNP-V]))[A-Z]")|((?:[A-Z][AEIOU][AEIOUX]|[AEIOU]X{2}|[B-DF-HJ-NP-TV-Z]{2}[A-Z]){2}(?:[\dLMNP-V]{2}(?:[A-EHLMPR-T](?:[04LQ][1-9MNP-V]|[15MR][\dLMNP-V]|[26NS][0-8LMNP-U])|[DHPS][37PT][0L]|[ACELMRT][37PT][01LM]|[AC-EHLMPR-T][26NS][9V])|(?:[02468LNQSU][048LQU]|[13579MPRTV][26NS])B[26NS][9V])(?:[A-MZ][1-9MNP-V][\dLMNP-V]{2}|[A-M][0L](?:[1-9MNP-V][\dLMNP-V]|[0L][1-9MNP-V]))[A-Z])|("(?:[A-Z][AEIOU][AEIOUX]|[AEIOU]X{2}|[B-DF-HJ-NP-TV-Z]{2}[A-Z]){2}(?:[\dLMNP-V]{2}(?:[A-EHLMPR-T](?:[04LQ][1-9MNP-V]|[15MR][\dLMNP-V]|[26NS][0-8LMNP-U])|[DHPS][37PT][0L]|[ACELMRT][37PT][01LM]|[AC-EHLMPR-T][26NS][9V])|(?:[02468LNQSU][048LQU]|[13579MPRTV][26NS])B[26NS][9V])(?:[A-MZ][1-9MNP-V][\dLMNP-V]{2}|[A-M][0L](?:[1-9MNP-V][\dLMNP-V]|[0L][1-9MNP-V]))[A-Z])|(\*(?:[A-Z][AEIOU][AEIOUX]|[AEIOU]X{2}|[B-DF-HJ-NP-TV-Z]{2}[A-Z]){2}(?:[\dLMNP-V]{2}(?:[A-EHLMPR-T](?:[04LQ][1-9MNP-V]|[15MR][\dLMNP-V]|[26NS][0-8LMNP-U])|[DHPS][37PT][0L]|[ACELMRT][37PT][01LM]|[AC-EHLMPR-T][26NS][9V])|(?:[02468LNQSU][048LQU]|[13579MPRTV][26NS])B[26NS][9V])(?:[A-MZ][1-9MNP-V][\dLMNP-V]{2}|[A-M][0L](?:[1-9MNP-V][\dLMNP-V]|[0L][1-9MNP-V]))[A-Z])|((?:[A-Z][AEIOU][AEIOUX]|[AEIOU]X{2}|[B-DF-HJ-NP-TV-Z]{2}[A-Z]){2}(?:[\dLMNP-V]{2}(?:[A-EHLMPR-T](?:[04LQ][1-9MNP-V]|[15MR][\dLMNP-V]|[26NS][0-8LMNP-U])|[DHPS][37PT][0L]|[ACELMRT][37PT][01LM]|[AC-EHLMPR-T][26NS][9V])|(?:[02468LNQSU][048LQU]|[13579MPRTV][26NS])B[26NS][9V])(?:[A-MZ][1-9MNP-V][\dLMNP-V]{2}|[A-M][0L](?:[1-9MNP-V][\dLMNP-V]|[0L][1-9MNP-V]))[A-Z]\*)|((?:[A-Z][AEIOU][AEIOUX]|[AEIOU]X{2}|[B-DF-HJ-NP-TV-Z]{2}[A-Z]){2}(?:[\dLMNP-V]{2}(?:[A-EHLMPR-T](?:[04LQ][1-9MNP-V]|[15MR][\dLMNP-V]|[26NS][0-8LMNP-U])|[DHPS][37PT][0L]|[ACELMRT][37PT][01LM]|[AC-EHLMPR-T][26NS][9V])|(?:[02468LNQSU][048LQU]|[13579MPRTV][26NS])B[26NS][9V])(?:[A-MZ][1-9MNP-V][\dLMNP-V]{2}|[A-M][0L](?:[1-9MNP-V][\dLMNP-V]|[0L][1-9MNP-V]))[A-Z]")$');
      RegExp exp_auth= RegExp(r"\d{30}");
      RegExp exp_ese= RegExp(r"((ESENZIONE:) (([A-Z]{1}\d{2})|([A-Za-z ]+)|(\d{3})))|((ESENZIONE) (([A-Z]{1}\d{2})|([A-Za-z ]+)|(\d{3})))|((ESENZIONE:)(([A-Z]{1}\d{2})|([A-Za-z ]+)|(\d{3})))");
      RegExp exp_data= RegExp(r"DATA: (3[01]|[12][0-9]|0?[1-9])(\/|-)(1[0-2]|0?[1-9])\2([0-9]{2})?[0-9]{2}");
      RegExp exp_pr= RegExp(r"((SIGLA PROVINCIA) [A-Z]{2})|((SIGLA PROVINCIA:) [A-Z]{2})|((SIGLA PROVINCIA:)[A-Z]{2}|((SIGLA PROVINCIA)[A-Z]{2}))");
      RegExp exp_asl= RegExp(r"((CODICE ASL:) \d{3})|((CODICE ASL) \d{3})|((CODICEASL) \d{3})|((CODICEASL:) \d{3})");
      RegExp exp_pre= RegExp(r"\d{2}\.\d{1,2}(\.\d{1})? [\w()-. ]+");
      RegExpMatch? match_cn;
      RegExpMatch? match_imp;
      RegExpMatch? match_imp2;
      RegExpMatch? match_CF;
      RegExpMatch? match_auth;
      RegExpMatch? match_ese;
      RegExpMatch? match_data;
      RegExpMatch? match_pr;
      RegExpMatch? match_asl;
      RegExpMatch? match_pre;
      int counter=0;
      String x='';
      for (TextBlock block in recognizerText.blocks){
        match_cn= exp_nc.firstMatch(block.text);
        if(match_cn != null){
          nome= _getNome(nome, cognome, match_cn);
          cognome= _getCognome(nome, cognome, match_cn);
          //print(nome);
          //print(cognome);
        }
        else if(exp_nc2.firstMatch(block.text)!=null){
          counter++;
        }
        else if(counter==1){
          counter++;
          if(_checkNomeCognome(block.text, exp_ese, exp_pr, exp_imp)){
            nome='';
            cognome='';
          }
          else{
          nome= _getNome2(block.text);
          cognome=_getCognome2(block.text);
          }
          //print(nome);
          //print(cognome);
        }

        if(block.text.length==5 || block.text.length==6 || block.text.length==7){
          match_imp = exp_imp.firstMatch(block.text);
          if(match_imp != null){
            imp1= match_imp[0]!;
            //print(imp1);
          }
        }
        

        if(block.text.length==10 || block.text.length==11 || block.text.length==12){
          match_imp2 = exp_imp2.firstMatch(block.text);
          if(match_imp2 != null){
            imp2= match_imp2[0]!;
            //print(imp2);
          }
        }
        
        x=_checkCF(block);
        if(x.isNotEmpty){
          match_CF= exp_CF.firstMatch(x);
        }
        else if(block.text.length==18 || block.text.length==17 || block.text.length==16){
          match_CF= exp_CF.firstMatch(block.text);
        }
        if(match_CF!=null){
          CF=match_CF[0]!;
          //print(CF);
        }
        

        match_auth= exp_auth.firstMatch(block.text);
        if(match_auth !=null){
          auth=match_auth[0]!;
          //print(auth);
        }

        match_ese= exp_ese.firstMatch(block.text);
        if(match_ese !=null){
          esenzione=_getEsenzione(esenzione, match_ese);
          //print(esenzione);
        }

        match_data= exp_data.firstMatch(block.text);
        if(match_data !=null){
          data= _getData(match_data);
          //print(data);
        }

        match_pr= exp_pr.firstMatch(block.text);
        if(match_pr != null){
          provincia=_getProvincia(match_pr);
          //print(provincia);
        }

        match_asl= exp_asl.firstMatch(block.text);
        if(match_asl!=null){
          asl=_getASL(match_asl);
          //print(asl);
        }

        match_pre = exp_pre.firstMatch(block.text);
        if(match_pre != null){
          prescrizione+= (match_pre[0]!+"\n");
          //print(prescrizione);
        }
      }
      textRecognizer.close();

      if(imp1.isNotEmpty && imp2.isNotEmpty){
        impegnativa= imp1+imp2;
        //print(impegnativa);
      }
      if(provincia.isNotEmpty && asl.isNotEmpty){
        codice_asl= provincia+asl;
        //print(codice_asl);
      }
      
      impegnativa= impegnativa.replaceAll(RegExp(r'"'),'');
      impegnativa= impegnativa.replaceAll(RegExp(r'\*'),'');
      //print(impegnativa);
      CF=CF.replaceAll(RegExp(r'"'),'');
      CF=CF.replaceAll(RegExp(r'\*'),'');
      //print(CF);

      List<bool> datacontrol= [nome.isNotEmpty,cognome.isNotEmpty,CF.isNotEmpty,impegnativa.isNotEmpty,prescrizione.isNotEmpty,auth.isNotEmpty,esenzione.isNotEmpty,codice_asl.isNotEmpty,data.isNotEmpty];
      if(!_checkData(datacontrol)){
        final hasClosed= await showErrorOCRDialog(context);
        if(hasClosed){
          openSourceCamera(context);
        }
       /* ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Non è stato possibile scannerizzare alcune informazioni dalla ricetta. Per favore riprova in un ambiente più luminoso')));
        Future.delayed(const Duration(seconds: 4), () async{
          await ImagePickerService().chooseImageFile(context);
        });
        */
        
      }
      else{
        await navigator.push(
        MaterialPageRoute(
          builder: (context) => ResultScreen(nome: nome, cognome: cognome, CF: CF, impegnativa: impegnativa, prescrizione: prescrizione, auth: auth, esenzione: esenzione, codice_asl: codice_asl,data: data,),
          ),
        );
      }
      
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred when scanning text'),
        ),
      );
    }
  }

  Future<void> openSourceCamera(BuildContext context) async{
    final file= await pickImage(source: ImageSource.camera);
    XFile selected = XFile(file.path);
    if(selected.path.isNotEmpty){
      if(!context.mounted) return;
      await scanImage(File(selected.path), context);
    } else{
      if(!context.mounted) return;
    }
  }

  Widget bottomSheet(BuildContext context) {
    Future<void> openSource(ImageSource source) async {
      final file = await pickImage(source: source);
      XFile selected = XFile(file.path);
      if (selected.path.isNotEmpty) {
        if (!context.mounted) return;
        Navigator.pop(context, selected);
        await scanImage(File(selected.path), context);
      } else {
        if (!context.mounted) return;
        Navigator.pop(context, XFile(''));
      }
    }

    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          const Text(
            'Scegli immagine',
            style: TextStyle(
              fontSize: 14,
              letterSpacing: 0.02,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: () async {
                  final bool cameraStatus =
                      await GetPermissions.getCameraPermission();
                  if (cameraStatus) {
                    openSource(ImageSource.camera);
                  }
                },
                icon: const Icon(Icons.camera_alt),
                label: const Text('Camera'),
              ),
              TextButton.icon(
                onPressed: () async {
                  final bool galleryStatus =
                      await GetPermissions.getStoragePermission();
                  if (galleryStatus) {
                    openSource(ImageSource.gallery);
                  }
                },
                icon: const Icon(Icons.image),
                label: const Text('Galleria'),
              ),
            ],
          )
        ],
      ),
    );
  }

  String _getNome(String nome, String cognome, RegExpMatch exp){
      List<String> lista= exp[0]!.split(' ');
      int counter=0;
      for( String x in lista){
        counter++;
        switch(counter){
          case 1:
          break;
          case 2:
          cognome=x;
          break;
          case >=3:
          nome+=(x+' ');
          break;
        }
      }

      if(nome.isEmpty){
        List<String> lista= exp[0]!.split('\n');
        int counter=0;
        for( String x in lista[1].split(' ')){
        counter++;
        switch(counter){
          case 1:
          cognome=x;
          break;
          case >=2:
          nome+=(x+' ');
          break;
          }
        }
      }

     return nome; 
  }

  String _getCognome(String nome, String cognome, RegExpMatch expMatch){
      List<String> lista= expMatch[0]!.split('\n');
      int counter=0;
      if(lista.length>=2){
        for( String x in lista[1].split(' ')){
          counter++;
          switch(counter){
            case 1:
            cognome=x;
            break;
            case 2:
            nome+=(x+' ');
            break;
          }
        }
      }

      else if(cognome.isEmpty){
        List<String> lista= expMatch[0]!.split(' ');
        int counter=0;
        for( String x in lista){
        counter++;
        switch(counter){
          case 1:
          break;
          case 2:
          cognome=x;
          break;
          case >=3:
          nome+=(x+' ');
         }
        }
      }

     return cognome; 
  }

  String _getEsenzione (String esenzione, RegExpMatch expMatch){
      if(expMatch[0]!.contains((RegExp(' ')),10) || expMatch[0]!.contains((RegExp(' ')),9)){
        List<String> lista= expMatch[0]!.split(' ');
        int counter=0;
        for( String x in lista){
          counter++;
          switch(counter){
            case 1:
            break;
            case 2:
            esenzione=(x+' ');
            break;
            case >=3:
            esenzione+=x;
            break;
          }
        }
      }
      else{
        List<String> lista = expMatch[0]!.split(':');
        int counter=0;
        for(String x in lista){
          counter++;
          switch(counter){
            case 1:
            break;
            case 2:
            esenzione=(x+' ');
            break;
            case >=3:
            esenzione+=x;
            break;
          }
        }
      }
      
      
      return esenzione;
  }

  String _getData (RegExpMatch expMatch){
      List<String> lista= expMatch[0]!.split(' ');
      return lista[1];
  }

  String _getProvincia (RegExpMatch expMatch){
      String x='';
      List<String> lista= expMatch[0]!.split(' ');
      if(lista.length>=3){
        x =lista[2];
      }
      else{
        lista=expMatch[0]!.split(':');
        x=lista[1];
      }

      return x;
  }

  String _getASL (RegExpMatch expMatch){
      String x='';
      List<String> lista= expMatch[0]!.split(' ');
      if(lista.length==3){
        x=lista[2];
      }
      else{
        x=lista[1];
      }
      return x;
  }

  String _getCognome2(String nc){
    List<String> lista= nc.split(' ');
    return lista[0];
  }

  String _getNome2(String nc){
    List<String> lista= nc.split(' ');
    int counter=0;
    String nome='';
    for( String x in lista){
        counter++;
        switch(counter){
          case 1:
          break;
          case 2:
          nome=(x+' ');
          break;
          case >=3:
          nome+=(x+' ');
          break;
        }
      }
     return nome;     
  }

  bool _checkData(List<bool> lista){
    int counter=0;
    for( bool x in lista){
      if(x){
        counter++;
      }
    }

    if(counter >=6){
      return true;
    }
    return false;    
  }

  String _checkCF(TextBlock block){
    String z='';
    if(block.text.length==18){
      int counter=-1;
      for(String x in block.text.split('')){
        counter++;
        switch(counter){
          case 1 || 2 || 3 || 4 || 5 || 6 || 9 || 12 || 16 :
          if(x=='0'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, 'O');
            }
            else{
              z=z.replaceRange(counter, counter+1, 'O');
            }
            
          }
          else if(x=='5'){
            if(z.isEmpty){
               z=block.text.replaceRange(counter, counter+1, 'S');
            }
            else{
              z=z.replaceRange(counter, counter+1, 'S');
            }
           
          }
          else if(x=='8'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, 'B');
            }
            else{
              z=z.replaceRange(counter, counter+1, 'B');
            }
            
          }
          else if(x=='1'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, 'I');
            }
            else{
              z=z.replaceRange(counter, counter+1, 'I');
            }
          }

          else if(x=='7'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, 'T');
            }
            else{
              z=z.replaceRange(counter, counter+1, 'T');
            }
          }

          else if(x=='3'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, 'E');
            }
            else{
              z=z.replaceRange(counter, counter+1, 'E');
            }
          }

          else if(x=='4'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, 'A');
            }
            else{
              z=z.replaceRange(counter, counter+1, 'A');
            }
          }

          break;

          case 7 || 8 || 10 || 11 || 13 || 14 || 15:
          if(x=='O'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, '0');
            }
            else{
              z=z.replaceRange(counter, counter+1, '0');
            }
            
          }
          else if(x=='S'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, '5');
            }
            else{
              z=z.replaceRange(counter, counter+1, '5');
            }
          }
          else if(x=='B'){
            if(z.isEmpty){
               z=block.text.replaceRange(counter, counter+1, '8');
            }
            else{
              z=z.replaceRange(counter, counter+1, '8');
            }
          }

          else if(x=='I'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, '1');
            }
            else{
              z=z.replaceRange(counter, counter+1, '1');
            }
          }

          else if(x=='A'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, '4');
            }
            else{
              z=z.replaceRange(counter, counter+1, '4');
            }
          }

          else if(x=='T'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, '7');
            }
            else{
              z=z.replaceRange(counter, counter+1, '7');
            }
          }

          else if(x=='E'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, '3');
            }
            else{
              z=z.replaceRange(counter, counter+1, '3');
            }
          }
          break;
        }
      }
    }
    else if(block.text.length==16){
      int counter=-1;
      for(String x in block.text.split('')){
        counter++;
        switch(counter){
          case 0 || 1 || 2 || 3 || 4 || 5 || 8 || 11 || 15:
          if(x=='0'){
            if(z.isEmpty){
               z=block.text.replaceRange(counter, counter+1, 'O');
            }
            else{
              z=z.replaceRange(counter, counter+1, 'O');
            }
           
          }
          else if(x=='5'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, 'S');
            }
            else{
              z=z.replaceRange(counter, counter+1, 'S');
            }
            
          }
          else if(x=='8'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, 'B');
            }
            else{
              z=z.replaceRange(counter, counter+1, 'B');
            }
            
          }

          else if(x=='1'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, 'I');
            }
            else{
              z=z.replaceRange(counter, counter+1, 'I');
            }
          }

          else if(x=='7'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, 'T');
            }
            else{
              z=z.replaceRange(counter, counter+1, 'T');
            }
          }

          else if(x=='3'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, 'E');
            }
            else{
              z=z.replaceRange(counter, counter+1, 'E');
            }
          }

          else if(x=='4'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, 'A');
            }
            else{
              z=z.replaceRange(counter, counter+1, 'A');
            }
          }
          break;

          case 6 || 7 || 9 || 10 || 12 || 13 || 14:
          if(x=='O'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, '0');
            }
            else{
              z=z.replaceRange(counter, counter+1, '0');
            }
            
          }
          else if(x=='S'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, '5');
            }
            else{
              z=z.replaceRange(counter, counter+1, '5');
            }
            
          }
          else if(x=='B'){
            if(z.isEmpty){
               z=block.text.replaceRange(counter, counter+1, '8');
            }
            else{
              z=z.replaceRange(counter, counter+1, '8');
            }
           
          }

           else if(x=='I'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, '1');
            }
            else{
              z=z.replaceRange(counter, counter+1, '1');
            }
          }

          else if(x=='A'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, '4');
            }
            else{
              z=z.replaceRange(counter, counter+1, '4');
            }
          }

          else if(x=='T'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, '7');
            }
            else{
              z=z.replaceRange(counter, counter+1, '7');
            }
          }

          else if(x=='E'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, '3');
            }
            else{
              z=z.replaceRange(counter, counter+1, '3');
            }
          }
          break;
        }
      }
    }
    else if(block.text.length==17 && ((block.text.contains(RegExp(r'\*'),16)) || (block.text.contains(RegExp(r'"'),16)))){
      int counter=-1;
      for(String x in block.text.split('')){
        counter++;
        switch(counter){
          case 0 || 1 || 2 || 3 || 4 || 5 || 8 || 11 || 15:
          if(x=='0'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, 'O');
            }
            else{
              z=z.replaceRange(counter, counter+1, 'O');
            }
          }
          else if(x=='5'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, 'S');
            }
            else{
              z=z.replaceRange(counter, counter+1, 'S');
            }
          }
          else if(x=='8'){
            if(z.isEmpty){
               z=block.text.replaceRange(counter, counter+1, 'B');
            }
            else{
              z=z.replaceRange(counter, counter+1, 'B');
            }
           
          }

          else if(x=='1'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, 'I');
            }
            else{
              z=z.replaceRange(counter, counter+1, 'I');
            }
          }

          else if(x=='7'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, 'T');
            }
            else{
              z=z.replaceRange(counter, counter+1, 'T');
            }
          }

          else if(x=='3'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, 'E');
            }
            else{
              z=z.replaceRange(counter, counter+1, 'E');
            }
          }

          else if(x=='4'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, 'A');
            }
            else{
              z=z.replaceRange(counter, counter+1, 'A');
            }
          }
          break;

          case  6 || 7 || 9 || 10 || 12 || 13 || 14:
          if(x=='O'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, '0');
            }
            else{
              z=z.replaceRange(counter, counter+1, '0');
            }
            
          }
          else if(x=='S'){
            if(z.isEmpty){
               z=block.text.replaceRange(counter, counter+1, '5');
            }
            else{
              z=z.replaceRange(counter, counter+1, '5');
            }
           
          }
          else if(x=='B'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, '8');
            }
            else{
              z=z.replaceRange(counter, counter+1, '8');
            }
            
          }

           else if(x=='I'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, '1');
            }
            else{
              z=z.replaceRange(counter, counter+1, '1');
            }
          }

          else if(x=='A'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, '4');
            }
            else{
              z=z.replaceRange(counter, counter+1, '4');
            }
          }

          else if(x=='T'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, '7');
            }
            else{
              z=z.replaceRange(counter, counter+1, '7');
            }
          }

          else if(x=='E'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, '3');
            }
            else{
              z=z.replaceRange(counter, counter+1, '3');
            }
          }
          break;
        }
      }
    }
    else if(block.text.length==17 && ((block.text.contains(RegExp(r'\*'),0)) || (block.text.contains(RegExp(r'"'),0)))){
      int counter=-1;
      for(String x in block.text.split('')){
        counter++;
        switch(counter){
          case  1 || 2 || 3 || 4 || 5 || 6 || 9 || 12 || 16 :
          if(x=='0'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, 'O');
            }
            else{
              z=z.replaceRange(counter, counter+1, 'O');
            }
            
            }
          else if(x=='5'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, 'S');
            }
            else{
              z=z.replaceRange(counter, counter+1, 'S');
            }
            
          }
          else if(x=='8'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, 'B');
            }
            else{
              z=z.replaceRange(counter, counter+1, 'B');
            }
            
          }

          else if(x=='1'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, 'I');
            }
            else{
              z=z.replaceRange(counter, counter+1, 'I');
            }
          }

          else if(x=='7'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, 'T');
            }
            else{
              z=z.replaceRange(counter, counter+1, 'T');
            }
          }

          else if(x=='3'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, 'E');
            }
            else{
              z=z.replaceRange(counter, counter+1, 'E');
            }
          }

          else if(x=='4'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, 'A');
            }
            else{
              z=z.replaceRange(counter, counter+1, 'A');
            }
          }
          break;

          case 7 || 8 || 10 || 11 || 13 || 14 || 15:
          if(x=='O'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, '0');
            }
            else{
              z=z.replaceRange(counter, counter+1, '0');
            }
            
          }
          else if(x=='S'){
            if(z.isEmpty){
               z=block.text.replaceRange(counter, counter+1, '5');
            }
            else{
              z=z.replaceRange(counter, counter+1, '5');
            }
           
          }
          else if(x=='B'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, '8');
            }
            else{
              z=z.replaceRange(counter, counter+1, '8');
            }
            
          }

           else if(x=='I'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, '1');
            }
            else{
              z=z.replaceRange(counter, counter+1, '1');
            }
          }

          else if(x=='A'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, '4');
            }
            else{
              z=z.replaceRange(counter, counter+1, '4');
            }
          }

          else if(x=='T'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, '7');
            }
            else{
              z=z.replaceRange(counter, counter+1, '7');
            }
          }

          else if(x=='E'){
            if(z.isEmpty){
              z=block.text.replaceRange(counter, counter+1, '3');
            }
            else{
              z=z.replaceRange(counter, counter+1, '3');
            }
          }
          break;
        }
      }
      
    }

    return z;    
  }

  bool _checkNomeCognome(String x, RegExp exp_ese, RegExp exp_pr, RegExp exp_imp){
    RegExp exp_altro= RegExp(r"(ALTRO:)|(ALTRO)");
    RegExp exp_cap= RegExp(r"(CAP:)|(CAP)");
    RegExp exp_indirizzo= RegExp(r"(INDIRIZZO:)|(INDIRIZZO)");
    RegExp exp_citta= RegExp(r"(CITTA':)|(CITTA:)|(CITTA')|(CITTA)");
    RegExp exp_ssn = RegExp(r"(SERVIZIO)|(SANITARIO)|(NAZIONALE)");
    RegExp exp_pre = RegExp(r"(PRESCRIZIONE)");
    RegExpMatch? match_altro, match_cap, match_indirizzo, match_ese, match_pr, match_imp, match_citta, match_ssn, match_pre;
    match_altro=exp_altro.firstMatch(x);
    match_cap=exp_cap.firstMatch(x);
    match_indirizzo=exp_indirizzo.firstMatch(x);
    match_ese=exp_ese.firstMatch(x);
    match_pr=exp_pr.firstMatch(x);
    match_imp=exp_imp.firstMatch(x);
    match_citta=exp_citta.firstMatch(x);
    match_ssn=exp_ssn.firstMatch(x);
    match_pre=exp_pre.firstMatch(x);
    if(match_altro!=null || match_pr!=null || match_cap!=null || match_indirizzo!=null || match_ese!=null || match_imp!=null || match_citta!=null || match_ssn!=null || match_pre!=null){
      return true;
    }

    return false;
  }

}
