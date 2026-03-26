-- KitaFlow: Grundschule + OGS/Hort spezifische Tabellen
-- Stundenplan, Klassenbuch, Noten, Elternsprechtage, AGs

CREATE TABLE stundenplan (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  klasse_id UUID NOT NULL REFERENCES gruppen_klassen(id) ON DELETE CASCADE,
  wochentag INT NOT NULL CHECK (wochentag BETWEEN 1 AND 5),
  stunde INT NOT NULL CHECK (stunde BETWEEN 1 AND 10),
  fach TEXT NOT NULL,
  lehrer_id UUID REFERENCES profiles(id),
  raum TEXT,
  schuljahr TEXT NOT NULL,
  UNIQUE(klasse_id, wochentag, stunde, schuljahr)
);

CREATE TABLE klassenbuch (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  klasse_id UUID NOT NULL REFERENCES gruppen_klassen(id) ON DELETE CASCADE,
  datum DATE NOT NULL,
  stunde INT NOT NULL,
  fach TEXT NOT NULL,
  thema TEXT,
  hausaufgaben TEXT,
  fehlende_schueler UUID[] DEFAULT '{}',
  lehrer_id UUID NOT NULL REFERENCES profiles(id),
  erstellt_am TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_klassenbuch_klasse_datum ON klassenbuch(klasse_id, datum);

CREATE TABLE noten (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  kind_id UUID NOT NULL REFERENCES kinder(id) ON DELETE CASCADE,
  fach TEXT NOT NULL,
  note_typ TEXT NOT NULL CHECK (note_typ IN ('klassenarbeit','test','muendlich','mitarbeit','zeugnis')),
  note NUMERIC(3,1) NOT NULL,
  datum DATE NOT NULL,
  lehrer_id UUID NOT NULL REFERENCES profiles(id),
  schuljahr TEXT NOT NULL,
  halbjahr INT NOT NULL CHECK (halbjahr IN (1,2)),
  kommentar TEXT,
  erstellt_am TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_noten_kind ON noten(kind_id);

CREATE TABLE elternsprechtage (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  einrichtung_id UUID NOT NULL REFERENCES einrichtungen(id) ON DELETE CASCADE,
  datum DATE NOT NULL,
  zeitslots JSONB NOT NULL DEFAULT '[]',
  lehrer_id UUID NOT NULL REFERENCES profiles(id),
  erstellt_am TIMESTAMPTZ DEFAULT now()
);

-- OGS / Hort

CREATE TABLE ags (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  einrichtung_id UUID NOT NULL REFERENCES einrichtungen(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  beschreibung TEXT,
  leiter_id UUID REFERENCES profiles(id),
  max_teilnehmer INT,
  wochentag INT CHECK (wochentag BETWEEN 1 AND 5),
  zeit_von TIME,
  zeit_bis TIME,
  aktiv BOOLEAN DEFAULT true,
  erstellt_am TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE ag_teilnahme (
  kind_id UUID NOT NULL REFERENCES kinder(id) ON DELETE CASCADE,
  ag_id UUID NOT NULL REFERENCES ags(id) ON DELETE CASCADE,
  angemeldet_am TIMESTAMPTZ DEFAULT now(),
  PRIMARY KEY(kind_id, ag_id)
);
