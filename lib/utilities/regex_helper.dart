import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:medicall/constants/regex.dart';

class RegexHelper {
  static String getAicNumber(String text) {
    // Define the regular expression
    RegExp expAic = RegexConstants.aicNumber;

    // Apply the regular expression to the text
    Iterable<RegExpMatch> matches = expAic.allMatches(text);

    // If there is a match, return the matched string
    if (matches.isNotEmpty) {
      if(matches.first.group(2)!=null){
        return matches.first.group(2)!;
      }
      else{
        return matches.first.group(4)!;
      }
      //return matches.first.group(1)!;
    }

    // If there is no match, return the original text
    return text;
  }

  static String getNome(String nome, String cognome, RegExpMatch exp) {
    List<String> lista=exp[0]!.split('\n');
    if(lista.length>=2){
       int counter = 0;
      for (String x in lista[1].split(' ')) {
        counter++;
        switch (counter) {
          case 1:
            cognome = x;
            break;
          case >= 2:
            nome += ('$x ');
            break;
        }
      }
    } else if(exp[0]!.contains(RegExp(':'),14)|| exp[0]!.contains(RegExp(':'),13)){
         List<String> lista=exp[0]!.split(':');
         int counter=0;
         for(String x in lista[1].trim().split(' ')){
           counter++;
           switch(counter){
             case 1:
             cognome=x;
             break;
             case >=2:
             nome += ('$x ');
             break;
            }
          }
    } else if(nome.isEmpty){
         List<String> lista = exp[0]!.split(' ');
          int counter = 0;
          for (String x in lista) {
            counter++;
            switch (counter) {
              case 1:
                break;
              case 2:
                cognome = x;
                break;
              case >= 3:
                nome += ('$x ');
                break;
            }
          }
    }
  
    /*if (nome.isEmpty) {
      List<String> lista = exp[0]!.split('\n');
      int counter = 0;
      for (String x in lista[1].split(' ')) {
        counter++;
        switch (counter) {
          case 1:
            cognome = x;
            break;
          case >= 2:
            nome += ('$x ');
            break;
        }
      }
    }
    */

    return nome;
  }

  static String getCognome(String nome, String cognome, RegExpMatch expMatch) {
    List<String> lista = expMatch[0]!.split('\n');
    int counter = 0;
    if (lista.length >= 2) {
      for (String x in lista[1].split(' ')) {
        counter++;
        switch (counter) {
          case 1:
            cognome = x;
            break;
          case 2:
            nome += ('$x ');
            break;
        }
      }
    } else if(expMatch[0]!.contains(RegExp(':'),14)|| expMatch[0]!.contains(RegExp(':'),13)){
       List<String> lista=expMatch[0]!.split(':');
         int counter=0;
         for(String x in lista[1].trim().split(' ')){
           counter++;
           switch(counter){
             case 1:
             cognome=x;
             break;
             case >=2:
             nome += ('$x ');
             break;
            }
          }
    } else if (cognome.isEmpty) {
      List<String> lista = expMatch[0]!.split(' ');
      int counter = 0;
      for (String x in lista) {
        counter++;
        switch (counter) {
          case 1:
            break;
          case 2:
            cognome = x;
            break;
          case >= 3:
            nome += ('$x ');
        }
      }
    }

    return cognome;
  }

  static String getEsenzione(String esenzione, RegExpMatch expMatch) {
    if (expMatch[0]!.contains((RegExp(' ')), 10) ||
        expMatch[0]!.contains((RegExp(' ')), 9)) {
      List<String> lista = expMatch[0]!.split(' ');
      int counter = 0;
      for (String x in lista) {
        counter++;
        switch (counter) {
          case 1:
            break;
          case 2:
            esenzione = ('$x ');
            break;
          case 3:
            esenzione += x;
            break;
        }
      }
    } else {
      List<String> lista = expMatch[0]!.split(':');
      int counter = 0;
      for (String x in lista) {
        counter++;
        switch (counter) {
          case 1:
            break;
          case 2:
            esenzione = ('$x ');
            break;
          case 3:
            esenzione += x;
            break;
        }
      }
    }

    return esenzione;
  }

  static String getData(RegExpMatch expMatch) {
    List<String> lista = expMatch[0]!.split(' ');
    return lista[1];
  }

  static String getProvincia(RegExpMatch expMatch) {
    String x = '';
    List<String> lista = expMatch[0]!.split(' ');
    if (lista.length >= 3) {
      x = lista[2];
    } else {
      lista = expMatch[0]!.split(':');
      x = lista[1];
    }

    return x;
  }

  static String getASL(RegExpMatch expMatch) {
    String x = '';
    List<String> lista = expMatch[0]!.split(' ');
    if (lista.length == 3) {
      x = lista[2];
    } else {
      x = lista[1];
    }
    return x;
  }

  static String getCognome2(String nc) {
    List<String> lista = nc.split(' ');
    return lista[0];
  }

  static String getNome2(String nc) {
    List<String> lista = nc.split(' ');
    int counter = 0;
    String nome = '';
    for (String x in lista) {
      counter++;
      switch (counter) {
        case 1:
          break;
        case 2:
          nome = ('$x ');
          break;
        case >= 3:
          nome += ('$x ');
          break;
      }
    }
    return nome;
  }

  static bool checkData(List<bool> lista) {
    int counter = 0;
    for (bool x in lista) {
      if (x) {
        counter++;
      }
    }

    if (counter >= 6) {
      return true;
    }
    return false;
  }

  static String checkCF(TextBlock block) {
    String z = '';
    if (block.text.length == 18) {
      int counter = -1;
      for (String x in block.text.split('')) {
        counter++;
        switch (counter) {
          case 1 || 2 || 3 || 4 || 5 || 6 || 9 || 12 || 16:
            if (x == '0') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, 'O');
              } else {
                z = z.replaceRange(counter, counter + 1, 'O');
              }
            } else if (x == '5') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, 'S');
              } else {
                z = z.replaceRange(counter, counter + 1, 'S');
              }
            } else if (x == '8') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, 'B');
              } else {
                z = z.replaceRange(counter, counter + 1, 'B');
              }
            } else if (x == '1') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, 'I');
              } else {
                z = z.replaceRange(counter, counter + 1, 'I');
              }
            } else if (x == '7') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, 'T');
              } else {
                z = z.replaceRange(counter, counter + 1, 'T');
              }
            } else if (x == '3') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, 'E');
              } else {
                z = z.replaceRange(counter, counter + 1, 'E');
              }
            } else if (x == '4') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, 'A');
              } else {
                z = z.replaceRange(counter, counter + 1, 'A');
              }
            }

            break;

          case 7 || 8 || 10 || 11 || 13 || 14 || 15:
            if (x == 'O') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, '0');
              } else {
                z = z.replaceRange(counter, counter + 1, '0');
              }
            } else if (x == 'S') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, '5');
              } else {
                z = z.replaceRange(counter, counter + 1, '5');
              }
            } else if (x == 'B') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, '8');
              } else {
                z = z.replaceRange(counter, counter + 1, '8');
              }
            } else if (x == 'I') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, '1');
              } else {
                z = z.replaceRange(counter, counter + 1, '1');
              }
            } else if (x == 'A') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, '4');
              } else {
                z = z.replaceRange(counter, counter + 1, '4');
              }
            } else if (x == 'T') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, '7');
              } else {
                z = z.replaceRange(counter, counter + 1, '7');
              }
            } else if (x == 'E') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, '3');
              } else {
                z = z.replaceRange(counter, counter + 1, '3');
              }
            }
            break;
        }
      }
    } else if (block.text.length == 16) {
      int counter = -1;
      for (String x in block.text.split('')) {
        counter++;
        switch (counter) {
          case 0 || 1 || 2 || 3 || 4 || 5 || 8 || 11 || 15:
            if (x == '0') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, 'O');
              } else {
                z = z.replaceRange(counter, counter + 1, 'O');
              }
            } else if (x == '5') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, 'S');
              } else {
                z = z.replaceRange(counter, counter + 1, 'S');
              }
            } else if (x == '8') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, 'B');
              } else {
                z = z.replaceRange(counter, counter + 1, 'B');
              }
            } else if (x == '1') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, 'I');
              } else {
                z = z.replaceRange(counter, counter + 1, 'I');
              }
            } else if (x == '7') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, 'T');
              } else {
                z = z.replaceRange(counter, counter + 1, 'T');
              }
            } else if (x == '3') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, 'E');
              } else {
                z = z.replaceRange(counter, counter + 1, 'E');
              }
            } else if (x == '4') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, 'A');
              } else {
                z = z.replaceRange(counter, counter + 1, 'A');
              }
            }
            break;

          case 6 || 7 || 9 || 10 || 12 || 13 || 14:
            if (x == 'O') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, '0');
              } else {
                z = z.replaceRange(counter, counter + 1, '0');
              }
            } else if (x == 'S') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, '5');
              } else {
                z = z.replaceRange(counter, counter + 1, '5');
              }
            } else if (x == 'B') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, '8');
              } else {
                z = z.replaceRange(counter, counter + 1, '8');
              }
            } else if (x == 'I') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, '1');
              } else {
                z = z.replaceRange(counter, counter + 1, '1');
              }
            } else if (x == 'A') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, '4');
              } else {
                z = z.replaceRange(counter, counter + 1, '4');
              }
            } else if (x == 'T') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, '7');
              } else {
                z = z.replaceRange(counter, counter + 1, '7');
              }
            } else if (x == 'E') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, '3');
              } else {
                z = z.replaceRange(counter, counter + 1, '3');
              }
            }
            break;
        }
      }
    } else if (block.text.length == 17 &&
        ((block.text.contains(RegExp(r'\*'), 16)) ||
            (block.text.contains(RegExp(r'"'), 16)))) {
      int counter = -1;
      for (String x in block.text.split('')) {
        counter++;
        switch (counter) {
          case 0 || 1 || 2 || 3 || 4 || 5 || 8 || 11 || 15:
            if (x == '0') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, 'O');
              } else {
                z = z.replaceRange(counter, counter + 1, 'O');
              }
            } else if (x == '5') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, 'S');
              } else {
                z = z.replaceRange(counter, counter + 1, 'S');
              }
            } else if (x == '8') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, 'B');
              } else {
                z = z.replaceRange(counter, counter + 1, 'B');
              }
            } else if (x == '1') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, 'I');
              } else {
                z = z.replaceRange(counter, counter + 1, 'I');
              }
            } else if (x == '7') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, 'T');
              } else {
                z = z.replaceRange(counter, counter + 1, 'T');
              }
            } else if (x == '3') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, 'E');
              } else {
                z = z.replaceRange(counter, counter + 1, 'E');
              }
            } else if (x == '4') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, 'A');
              } else {
                z = z.replaceRange(counter, counter + 1, 'A');
              }
            }
            break;

          case 6 || 7 || 9 || 10 || 12 || 13 || 14:
            if (x == 'O') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, '0');
              } else {
                z = z.replaceRange(counter, counter + 1, '0');
              }
            } else if (x == 'S') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, '5');
              } else {
                z = z.replaceRange(counter, counter + 1, '5');
              }
            } else if (x == 'B') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, '8');
              } else {
                z = z.replaceRange(counter, counter + 1, '8');
              }
            } else if (x == 'I') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, '1');
              } else {
                z = z.replaceRange(counter, counter + 1, '1');
              }
            } else if (x == 'A') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, '4');
              } else {
                z = z.replaceRange(counter, counter + 1, '4');
              }
            } else if (x == 'T') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, '7');
              } else {
                z = z.replaceRange(counter, counter + 1, '7');
              }
            } else if (x == 'E') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, '3');
              } else {
                z = z.replaceRange(counter, counter + 1, '3');
              }
            }
            break;
        }
      }
    } else if (block.text.length == 17 &&
        ((block.text.contains(RegExp(r'\*'), 0)) ||
            (block.text.contains(RegExp(r'"'), 0)))) {
      int counter = -1;
      for (String x in block.text.split('')) {
        counter++;
        switch (counter) {
          case 1 || 2 || 3 || 4 || 5 || 6 || 9 || 12 || 16:
            if (x == '0') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, 'O');
              } else {
                z = z.replaceRange(counter, counter + 1, 'O');
              }
            } else if (x == '5') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, 'S');
              } else {
                z = z.replaceRange(counter, counter + 1, 'S');
              }
            } else if (x == '8') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, 'B');
              } else {
                z = z.replaceRange(counter, counter + 1, 'B');
              }
            } else if (x == '1') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, 'I');
              } else {
                z = z.replaceRange(counter, counter + 1, 'I');
              }
            } else if (x == '7') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, 'T');
              } else {
                z = z.replaceRange(counter, counter + 1, 'T');
              }
            } else if (x == '3') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, 'E');
              } else {
                z = z.replaceRange(counter, counter + 1, 'E');
              }
            } else if (x == '4') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, 'A');
              } else {
                z = z.replaceRange(counter, counter + 1, 'A');
              }
            }
            break;

          case 7 || 8 || 10 || 11 || 13 || 14 || 15:
            if (x == 'O') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, '0');
              } else {
                z = z.replaceRange(counter, counter + 1, '0');
              }
            } else if (x == 'S') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, '5');
              } else {
                z = z.replaceRange(counter, counter + 1, '5');
              }
            } else if (x == 'B') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, '8');
              } else {
                z = z.replaceRange(counter, counter + 1, '8');
              }
            } else if (x == 'I') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, '1');
              } else {
                z = z.replaceRange(counter, counter + 1, '1');
              }
            } else if (x == 'A') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, '4');
              } else {
                z = z.replaceRange(counter, counter + 1, '4');
              }
            } else if (x == 'T') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, '7');
              } else {
                z = z.replaceRange(counter, counter + 1, '7');
              }
            } else if (x == 'E') {
              if (z.isEmpty) {
                z = block.text.replaceRange(counter, counter + 1, '3');
              } else {
                z = z.replaceRange(counter, counter + 1, '3');
              }
            }
            break;
        }
      }
    }

    return z;
  }

  static bool checkNomeCognome(
      String x, RegExp expEse, RegExp expPr, RegExp expImp, RegExp expCF) {
    RegExp expAltro = RegExp(r"(ALTRO:)|(ALTRO)");
    RegExp expCap = RegExp(r"(CAP:)|(CAP)");
    RegExp expIndirizzo = RegExp(r"(INDIRIZZO:)|(INDIRIZZO)");
    RegExp expCitta = RegExp(r"(CITTA':)|(CITTA:)|(CITTA')|(CITTA)");
    RegExp expSsn = RegExp(r"(SERVIZIO)|(SANITARIO)|(NAZIONALE)");
    RegExp expPre = RegExp(r"(PRESCRIZIONE)");
    RegExp expProv = RegExp(r"(PROV:)|(PROV)");
    RegExpMatch? matchAltro,
        matchCap,
        matchIndirizzo,
        matchEse,
        matchPr,
        matchImp,
        matchCitta,
        matchSsn,
        matchPre,
        matchProv,
        matchCF;
    matchAltro = expAltro.firstMatch(x);
    matchCap = expCap.firstMatch(x);
    matchIndirizzo = expIndirizzo.firstMatch(x);
    matchEse = expEse.firstMatch(x);
    matchPr = expPr.firstMatch(x);
    matchImp = expImp.firstMatch(x);
    matchCitta = expCitta.firstMatch(x);
    matchSsn = expSsn.firstMatch(x);
    matchPre = expPre.firstMatch(x);
    matchProv = expProv.firstMatch(x);
    matchCF= expCF.firstMatch(x);
    if (matchAltro != null ||
        matchPr != null ||
        matchCap != null ||
        matchIndirizzo != null ||
        matchEse != null ||
        matchImp != null ||
        matchCitta != null ||
        matchSsn != null ||
        matchPre != null ||
        matchProv != null ||
        matchCF != null) {
      return true;
    }

    return false;
  }
}
