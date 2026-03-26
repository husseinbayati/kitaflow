// Zentrale Enums für KitaFlow.

/// Benutzerrolle im System.
enum UserRole {
  erzieher,
  lehrer,
  leitung,
  traeger,
  eltern,
}

/// Typ der Einrichtung.
enum InstitutionType {
  krippe,
  kita,
  grundschule,
  ogs,
  hort,
}

/// Anwesenheitsstatus eines Kindes.
enum AttendanceStatus {
  anwesend,
  abwesend,
  krank,
  urlaub,
  entschuldigt,
  unentschuldigt,
}

/// Nachrichtentyp.
enum MessageType {
  nachricht,
  elternbrief,
  ankuendigung,
  notfall,
}

/// Status eines Kindes in der Einrichtung.
enum ChildStatus {
  aktiv,
  eingewoehnung,
  abgemeldet,
  warteliste,
}

/// Mahlzeitentyp.
enum MealType {
  fruehstueck,
  mittagessen,
  snack,
}

/// Entwicklungsbereich für Beobachtungen.
enum DevelopmentArea {
  motorik,
  sprache,
  sozial,
  kognitiv,
  emotional,
  kreativ,
}

/// Allergene nach EU-Verordnung 1169/2011.
enum Allergen {
  gluten,
  krebstiere,
  eier,
  fisch,
  erdnuesse,
  soja,
  milch,
  schalenfruechte,
  sellerie,
  senf,
  sesam,
  schwefeldioxid,
  lupinen,
  weichtiere,
}

/// Schweregrad einer Allergie.
enum AllergySeverity {
  leicht,
  mittel,
  schwer,
  lebensbedrohlich,
}

/// Dokumententyp.
enum DocumentType {
  vertrag,
  einverstaendnis,
  attest,
  zeugnis,
  sonstiges,
}

/// Tab-Auswahl im Nachrichten-Screen.
enum NachrichtenTab {
  posteingang,
  gesendet,
  wichtig,
}

/// Termintyp für Kalendereinträge.
enum TerminTyp {
  allgemein,
  elternabend,
  fest,
  schliessung,
  ausflug,
  sonstiges,
}

/// RSVP-Status für Termin-Rückmeldungen.
enum RsvpStatus {
  zugesagt,
  abgesagt,
  vielleicht,
}

/// Beziehung Eltern-Kind.
enum ElternBeziehung {
  mutter,
  vater,
  sorgeberechtigt,
}

/// Eingewöhnungsphase (Berliner Modell).
enum EingewoehnungPhase {
  grundphase,
  stabilisierung,
  schlussphase,
  abgeschlossen,
}

/// Stimmung eines Kindes (Tagesnotiz).
enum Stimmung {
  sehr_gut,
  gut,
  neutral,
  schlecht,
  sehr_schlecht,
}
