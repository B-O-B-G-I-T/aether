class RegexConstants {
  // Regex pour les emails
  static final RegExp email =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  // Regex pour les identifiants (3 à 16 caractères, lettres, chiffres, _ ou -)
  static final RegExp identifiant = RegExp(r'^[a-zA-Z0-9_-]{3,16}$');

  static final RegExp passworddefault = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$%^&*(),.?":{}|<>])[A-Za-z\d!@#\$%^&*(),.?":{}|<>]{8,20}$');

  // Regex pour le mot de passe (8-20 caractères, sans validation supplémentaire)
  static final RegExp password = RegExp(r'^.{8,20}$');

  // Regex pour le code client (exemple : "C5998")
  static final RegExp codeClient = RegExp(r'^[A-Za-z0-9]+$');

  // Code postal : 5 chiffres
  static final RegExp codePostal = RegExp(r'^\d{5}$');

  // Téléphone : Numéro français (06 XX XX XX XX ou 07 XX XX XX XX)
  static final RegExp phone = RegExp(r'^(0[67])(\d{8})$');

  static final RegExp sixDigits = RegExp(r'^\d{6}$');
}
