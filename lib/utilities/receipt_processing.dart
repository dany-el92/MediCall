import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:medicall/components/extracted_data_receipt.dart';
import 'package:medicall/constants/regex.dart';
import 'package:medicall/utilities/regex_helper.dart';

ExtractedData processTextBlocks(List<TextBlock> blocks) {
  String nome = '',
      cognome = '',
      CF = '',
      impegnativa = '',
      auth = '',
      esenzione = '',
      data = '',
      provincia = '',
      asl = '',
      prescrizione = '',
      imp1 = '',
      imp2 = '',
      codiceAsl = '';

  RegExpMatch? matchCn;
  RegExpMatch? matchImp;
  RegExpMatch? matchImp2;
  RegExpMatch? matchCf;
  RegExpMatch? matchAuth;
  RegExpMatch? matchEse;
  RegExpMatch? matchData;
  RegExpMatch? matchPr;
  RegExpMatch? matchAsl;
  RegExpMatch? matchPre;
  int counter = 0;
  String x = '';

  for (TextBlock block in blocks) {
    matchCn = RegexConstants.expNc.firstMatch(block.text);
    if (matchCn != null) {
      nome = RegexHelper.getNome(nome, cognome, matchCn);
      cognome = RegexHelper.getCognome(nome, cognome, matchCn);
      //print(nome);
      //print(cognome);
    } else if (RegexConstants.expNc2.firstMatch(block.text) != null) {
      counter++;
    } else if (counter == 1) {
      counter++;
      if (RegexHelper.checkNomeCognome(block.text, RegexConstants.expEse,
          RegexConstants.expPr, RegexConstants.expImp)) {
        nome = '';
        cognome = '';
      } else {
        nome = RegexHelper.getNome2(block.text);
        cognome = RegexHelper.getCognome2(block.text);
      }
      //print(nome);
      //print(cognome);
    }

    if (block.text.length == 5 ||
        block.text.length == 6 ||
        block.text.length == 7) {
      matchImp = RegexConstants.expImp.firstMatch(block.text);
      if (matchImp != null) {
        imp1 = matchImp[0]!;
        //print(imp1);
      }
    }

    if (block.text.length == 10 ||
        block.text.length == 11 ||
        block.text.length == 12) {
      matchImp2 = RegexConstants.expImp2.firstMatch(block.text);
      if (matchImp2 != null) {
        imp2 = matchImp2[0]!;
        //print(imp2);
      }
    }

    x = RegexHelper.checkCF(block);
    if (x.isNotEmpty) {
      matchCf = RegexConstants.expCf.firstMatch(x);
    } else if (block.text.length == 18 ||
        block.text.length == 17 ||
        block.text.length == 16) {
      matchCf = RegexConstants.expCf.firstMatch(block.text);
    }
    if (matchCf != null) {
      CF = matchCf[0]!;
      //print(CF);
    }

    matchAuth = RegexConstants.expAuth.firstMatch(block.text);
    if (matchAuth != null) {
      auth = matchAuth[0]!;
      //print(auth);
    }

    matchEse = RegexConstants.expEse.firstMatch(block.text);
    if (matchEse != null) {
      esenzione = RegexHelper.getEsenzione(esenzione, matchEse);
      //print(esenzione);
    }

    matchData = RegexConstants.expData.firstMatch(block.text);
    if (matchData != null) {
      data = RegexHelper.getData(matchData);
      //print(data);
    }

    matchPr = RegexConstants.expPr.firstMatch(block.text);
    if (matchPr != null) {
      provincia = RegexHelper.getProvincia(matchPr);
      //print(provincia);
    }

    matchAsl = RegexConstants.expAsl.firstMatch(block.text);
    if (matchAsl != null) {
      asl = RegexHelper.getASL(matchAsl);
      //print(asl);
    }

    matchPre = RegexConstants.expPre.firstMatch(block.text);
    if (matchPre != null) {
      prescrizione += ("${matchPre[0]!}\n");
      //print(prescrizione);
    }
  }

  if (imp1.isNotEmpty && imp2.isNotEmpty) {
    impegnativa = imp1 + imp2;
    //print(impegnativa);
  }
  if (provincia.isNotEmpty && asl.isNotEmpty) {
    codiceAsl = provincia + asl;
    //print(codice_asl);
  }

  impegnativa = impegnativa.replaceAll(RegExp(r'"'), '');
  impegnativa = impegnativa.replaceAll(RegExp(r'\*'), '');
  //print(impegnativa);
  CF = CF.replaceAll(RegExp(r'"'), '');
  CF = CF.replaceAll(RegExp(r'\*'), '');
  //print(CF);

  List<bool> dataControl = [
    nome.isNotEmpty,
    cognome.isNotEmpty,
    CF.isNotEmpty,
    impegnativa.isNotEmpty,
    prescrizione.isNotEmpty,
    auth.isNotEmpty,
    esenzione.isNotEmpty,
    codiceAsl.isNotEmpty,
    data.isNotEmpty
  ];

  return ExtractedData(
    nome: nome,
    cognome: cognome,
    CF: CF,
    impegnativa: impegnativa,
    prescrizione: prescrizione,
    auth: auth,
    esenzione: esenzione,
    codiceAsl: codiceAsl,
    data: data,
    dataControl: dataControl,
  );
}
