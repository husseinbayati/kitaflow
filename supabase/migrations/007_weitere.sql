-- KitaFlow: Dokumente, Eingewöhnung, Warteliste, Beiträge
-- Verwaltungs- und Abrechnungstabellen

CREATE TABLE dokumente (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  einrichtung_id UUID NOT NULL REFERENCES einrichtungen(id) ON DELETE CASCADE,
  kind_id UUID REFERENCES kinder(id) ON DELETE CASCADE,
  typ TEXT NOT NULL CHECK (typ IN ('vertrag','einverstaendnis','attest','zeugnis','sonstiges')),
  titel TEXT NOT NULL,
  beschreibung TEXT,
  dateipfad TEXT NOT NULL,
  unterschrieben BOOLEAN DEFAULT false,
  unterschrieben_am TIMESTAMPTZ,
  unterschrieben_von TEXT,
  gueltig_bis DATE,
  erstellt_von UUID REFERENCES profiles(id),
  erstellt_am TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_dokumente_einrichtung ON dokumente(einrichtung_id);
CREATE INDEX idx_dokumente_kind ON dokumente(kind_id);

CREATE TABLE eingewoehnung (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  kind_id UUID NOT NULL REFERENCES kinder(id) ON DELETE CASCADE,
  startdatum DATE NOT NULL,
  enddatum DATE,
  phase TEXT NOT NULL DEFAULT 'grundphase' CHECK (phase IN ('grundphase','stabilisierung','schlussphase','abgeschlossen')),
  bezugsperson_id UUID REFERENCES profiles(id),
  notizen TEXT,
  eltern_feedback TEXT,
  erstellt_am TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE warteliste (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  einrichtung_id UUID NOT NULL REFERENCES einrichtungen(id) ON DELETE CASCADE,
  kind_vorname TEXT NOT NULL,
  kind_nachname TEXT NOT NULL,
  kind_geburtsdatum DATE NOT NULL,
  eltern_name TEXT NOT NULL,
  eltern_email TEXT,
  eltern_telefon TEXT,
  gewuenschtes_datum DATE,
  status TEXT NOT NULL DEFAULT 'wartend' CHECK (status IN ('wartend','angeboten','angenommen','abgelehnt','zurueckgezogen')),
  prioritaet INT DEFAULT 0,
  anmerkungen TEXT,
  erstellt_am TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_warteliste_einrichtung ON warteliste(einrichtung_id);

CREATE TABLE beitraege (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  kind_id UUID NOT NULL REFERENCES kinder(id) ON DELETE CASCADE,
  einrichtung_id UUID NOT NULL REFERENCES einrichtungen(id) ON DELETE CASCADE,
  betrag NUMERIC(10,2) NOT NULL,
  zeitraum_monat INT NOT NULL CHECK (zeitraum_monat BETWEEN 1 AND 12),
  zeitraum_jahr INT NOT NULL,
  status TEXT NOT NULL DEFAULT 'offen' CHECK (status IN ('offen','bezahlt','ueberfaellig','storniert')),
  faellig_am DATE NOT NULL,
  bezahlt_am DATE,
  zahlungsart TEXT,
  erstellt_am TIMESTAMPTZ DEFAULT now(),
  UNIQUE(kind_id, zeitraum_monat, zeitraum_jahr)
);

CREATE TABLE sepa_mandate (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  eltern_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  iban_verschluesselt TEXT NOT NULL,
  kontoinhaber TEXT NOT NULL,
  aktiv BOOLEAN DEFAULT true,
  erstellt_am TIMESTAMPTZ DEFAULT now()
);
