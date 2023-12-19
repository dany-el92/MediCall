import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';

//Non è possibile modificare le variabili, se non nell'inizializzazione
@immutable
class AuthUser {
  final String? email;
  final bool isEmailVerified;

  //Tramite required dobbiamo obbligatoriamente specificare il parametro a cui facciamo riferimento
  const AuthUser({
    required this.isEmailVerified,
    required this.email,
  });

  factory AuthUser.fromFirebase(User user) => AuthUser(
        isEmailVerified: user.emailVerified,
        email: user.email,
      );
}
