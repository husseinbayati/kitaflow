import 'package:flutter/material.dart';
import '../extensions/l10n_extension.dart';
import 'enums.dart';

/// Lokalisierte Labels für alle Enums.
/// Ersetzt die hardcodierten displayName-Getter durch lokalisierte Strings.

extension UserRoleLabel on UserRole {
  String label(BuildContext context) {
    return switch (this) {
      UserRole.erzieher => context.l.enum_roleErzieher,
      UserRole.lehrer => context.l.enum_roleLehrer,
      UserRole.leitung => context.l.enum_roleLeitung,
      UserRole.traeger => context.l.enum_roleTraeger,
      UserRole.eltern => context.l.enum_roleEltern,
    };
  }
}

extension InstitutionTypeLabel on InstitutionType {
  String label(BuildContext context) {
    return switch (this) {
      InstitutionType.krippe => context.l.enum_institutionTypeKrippe,
      InstitutionType.kita => context.l.enum_institutionTypeKita,
      InstitutionType.grundschule => context.l.enum_institutionTypeGrundschule,
      InstitutionType.ogs => context.l.enum_institutionTypeOgs,
      InstitutionType.hort => context.l.enum_institutionTypeHort,
    };
  }
}

extension AttendanceStatusLabel on AttendanceStatus {
  String label(BuildContext context) {
    return switch (this) {
      AttendanceStatus.anwesend => context.l.enum_attendanceAnwesend,
      AttendanceStatus.abwesend => context.l.enum_attendanceAbwesend,
      AttendanceStatus.krank => context.l.enum_attendanceKrank,
      AttendanceStatus.urlaub => context.l.enum_attendanceUrlaub,
      AttendanceStatus.entschuldigt => context.l.enum_attendanceEntschuldigt,
      AttendanceStatus.unentschuldigt => context.l.enum_attendanceUnentschuldigt,
    };
  }
}

extension MessageTypeLabel on MessageType {
  String label(BuildContext context) {
    return switch (this) {
      MessageType.nachricht => context.l.enum_messageTypeNachricht,
      MessageType.elternbrief => context.l.enum_messageTypeElternbrief,
      MessageType.ankuendigung => context.l.enum_messageTypeAnkuendigung,
      MessageType.notfall => context.l.enum_messageTypeNotfall,
    };
  }
}

extension ChildStatusLabel on ChildStatus {
  String label(BuildContext context) {
    return switch (this) {
      ChildStatus.aktiv => context.l.enum_childStatusAktiv,
      ChildStatus.eingewoehnung => context.l.enum_childStatusEingewoehnung,
      ChildStatus.abgemeldet => context.l.enum_childStatusAbgemeldet,
      ChildStatus.warteliste => context.l.enum_childStatusWarteliste,
    };
  }
}

extension MealTypeLabel on MealType {
  String label(BuildContext context) {
    return switch (this) {
      MealType.fruehstueck => context.l.enum_mealTypeFruehstueck,
      MealType.mittagessen => context.l.enum_mealTypeMittagessen,
      MealType.snack => context.l.enum_mealTypeSnack,
    };
  }
}

extension DevelopmentAreaLabel on DevelopmentArea {
  String label(BuildContext context) {
    return switch (this) {
      DevelopmentArea.motorik => context.l.enum_developmentMotorik,
      DevelopmentArea.sprache => context.l.enum_developmentSprache,
      DevelopmentArea.sozial => context.l.enum_developmentSozialverhalten,
      DevelopmentArea.kognitiv => context.l.enum_developmentKognitiv,
      DevelopmentArea.emotional => context.l.enum_developmentEmotional,
      DevelopmentArea.kreativ => context.l.enum_developmentKreativitaet,
    };
  }
}

extension AllergenLabel on Allergen {
  String label(BuildContext context) {
    return switch (this) {
      Allergen.gluten => context.l.enum_allergenGluten,
      Allergen.krebstiere => context.l.enum_allergenKrebstiere,
      Allergen.eier => context.l.enum_allergenEier,
      Allergen.fisch => context.l.enum_allergenFisch,
      Allergen.erdnuesse => context.l.enum_allergenErdnuesse,
      Allergen.soja => context.l.enum_allergenSoja,
      Allergen.milch => context.l.enum_allergenMilch,
      Allergen.schalenfruechte => context.l.enum_allergenSchalenfruechte,
      Allergen.sellerie => context.l.enum_allergenSellerie,
      Allergen.senf => context.l.enum_allergenSenf,
      Allergen.sesam => context.l.enum_allergenSesam,
      Allergen.schwefeldioxid => context.l.enum_allergenSchwefeldioxid,
      Allergen.lupinen => context.l.enum_allergenLupinen,
      Allergen.weichtiere => context.l.enum_allergenWeichtiere,
    };
  }
}

extension AllergySeverityLabel on AllergySeverity {
  String label(BuildContext context) {
    return switch (this) {
      AllergySeverity.leicht => context.l.enum_allergySeverityLeicht,
      AllergySeverity.mittel => context.l.enum_allergySeverityMittel,
      AllergySeverity.schwer => context.l.enum_allergySeveritySchwer,
      AllergySeverity.lebensbedrohlich => context.l.enum_allergySeverityLebensbedrohlich,
    };
  }
}

extension DocumentTypeLabel on DocumentType {
  String label(BuildContext context) {
    return switch (this) {
      DocumentType.vertrag => context.l.enum_documentTypeVertrag,
      DocumentType.einverstaendnis => context.l.enum_documentTypeEinverstaendnis,
      DocumentType.attest => context.l.enum_documentTypeAttest,
      DocumentType.zeugnis => context.l.enum_documentTypeZeugnis,
      DocumentType.sonstiges => context.l.enum_documentTypeSonstiges,
    };
  }
}

extension NachrichtenTabLabel on NachrichtenTab {
  String label(BuildContext context) {
    return switch (this) {
      NachrichtenTab.posteingang => context.l.enum_nachrichtenTabPosteingang,
      NachrichtenTab.gesendet => context.l.enum_nachrichtenTabGesendet,
      NachrichtenTab.wichtig => context.l.enum_nachrichtenTabWichtig,
    };
  }
}

extension TerminTypLabel on TerminTyp {
  String label(BuildContext context) {
    return switch (this) {
      TerminTyp.allgemein => context.l.enum_terminTypAllgemein,
      TerminTyp.elternabend => context.l.enum_terminTypElternabend,
      TerminTyp.fest => context.l.enum_terminTypFestFeier,
      TerminTyp.schliessung => context.l.enum_terminTypSchliessung,
      TerminTyp.ausflug => context.l.enum_terminTypAusflug,
      TerminTyp.sonstiges => context.l.enum_terminTypSonstiges,
    };
  }
}

extension RsvpStatusLabel on RsvpStatus {
  String label(BuildContext context) {
    return switch (this) {
      RsvpStatus.zugesagt => context.l.enum_rsvpZugesagt,
      RsvpStatus.abgesagt => context.l.enum_rsvpAbgesagt,
      RsvpStatus.vielleicht => context.l.enum_rsvpVielleicht,
    };
  }
}

extension ElternBeziehungLabel on ElternBeziehung {
  String label(BuildContext context) {
    return switch (this) {
      ElternBeziehung.mutter => context.l.enum_elternBeziehungMutter,
      ElternBeziehung.vater => context.l.enum_elternBeziehungVater,
      ElternBeziehung.sorgeberechtigt => context.l.enum_elternBeziehungSorgeberechtigt,
    };
  }
}

extension EingewoehnungPhaseLabel on EingewoehnungPhase {
  String label(BuildContext context) {
    return switch (this) {
      EingewoehnungPhase.grundphase => context.l.enum_phaseGrundphase,
      EingewoehnungPhase.stabilisierung => context.l.enum_phaseStabilisierung,
      EingewoehnungPhase.schlussphase => context.l.enum_phaseSchlussphase,
      EingewoehnungPhase.abgeschlossen => context.l.enum_phaseAbgeschlossen,
    };
  }
}

extension StimmungLabel on Stimmung {
  String label(BuildContext context) {
    return switch (this) {
      Stimmung.sehr_gut => context.l.enum_stimmungSehrGut,
      Stimmung.gut => context.l.enum_stimmungGut,
      Stimmung.neutral => context.l.enum_stimmungNeutral,
      Stimmung.schlecht => context.l.enum_stimmungSchlecht,
      Stimmung.sehr_schlecht => context.l.enum_stimmungSehrSchlecht,
    };
  }

  String get emoji {
    return switch (this) {
      Stimmung.sehr_gut => '😄',
      Stimmung.gut => '🙂',
      Stimmung.neutral => '😐',
      Stimmung.schlecht => '😟',
      Stimmung.sehr_schlecht => '😢',
    };
  }
}
