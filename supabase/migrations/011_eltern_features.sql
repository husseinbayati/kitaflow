-- KitaFlow Phase 10: Eltern-App Tabellen

-- 1. Einladungen — Einladungscodes für Eltern-Kind-Verknüpfung
CREATE TABLE einladungen (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  einrichtung_id UUID NOT NULL REFERENCES einrichtungen(id) ON DELETE CASCADE,
  kind_id UUID NOT NULL REFERENCES kinder(id) ON DELETE CASCADE,
  code TEXT NOT NULL UNIQUE,
  erstellt_von UUID NOT NULL REFERENCES profiles(id),
  eingeloest_von UUID REFERENCES profiles(id),
  eingeloest_am TIMESTAMPTZ,
  gueltig_bis TIMESTAMPTZ NOT NULL,
  aktiv BOOLEAN DEFAULT true,
  erstellt_am TIMESTAMPTZ DEFAULT now()
);

-- 2. Termine — Kalendereinträge der Einrichtung
CREATE TABLE termine (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  einrichtung_id UUID NOT NULL REFERENCES einrichtungen(id) ON DELETE CASCADE,
  titel TEXT NOT NULL,
  beschreibung TEXT,
  datum DATE NOT NULL,
  uhrzeit_von TIME,
  uhrzeit_bis TIME,
  typ TEXT NOT NULL CHECK (typ IN ('allgemein','elternabend','fest','schliessung','ausflug','sonstiges')),
  gruppe_id UUID REFERENCES gruppen_klassen(id) ON DELETE SET NULL,
  erstellt_von UUID NOT NULL REFERENCES profiles(id),
  erstellt_am TIMESTAMPTZ DEFAULT now(),
  aktualisiert_am TIMESTAMPTZ DEFAULT now()
);

-- 3. Termin-Rückmeldungen — RSVP von Eltern
CREATE TABLE termin_rueckmeldungen (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  termin_id UUID NOT NULL REFERENCES termine(id) ON DELETE CASCADE,
  eltern_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  status TEXT NOT NULL CHECK (status IN ('zugesagt','abgesagt','vielleicht')),
  erstellt_am TIMESTAMPTZ DEFAULT now(),
  aktualisiert_am TIMESTAMPTZ DEFAULT now(),
  UNIQUE(termin_id, eltern_id)
);

-- 4. Push-Einstellungen — Benachrichtigungspräferenzen pro User
CREATE TABLE push_einstellungen (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL UNIQUE REFERENCES profiles(id) ON DELETE CASCADE,
  nachrichten BOOLEAN DEFAULT true,
  anwesenheit BOOLEAN DEFAULT true,
  termine BOOLEAN DEFAULT true,
  essensplan BOOLEAN DEFAULT false,
  notfall BOOLEAN DEFAULT true,
  ruhezeit_von TIME,
  ruhezeit_bis TIME,
  erstellt_am TIMESTAMPTZ DEFAULT now(),
  aktualisiert_am TIMESTAMPTZ DEFAULT now()
);

-- 5. Fotos — Von Mitarbeitern hochgeladene Fotos
CREATE TABLE fotos (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  einrichtung_id UUID NOT NULL REFERENCES einrichtungen(id) ON DELETE CASCADE,
  gruppe_id UUID REFERENCES gruppen_klassen(id) ON DELETE SET NULL,
  hochgeladen_von UUID NOT NULL REFERENCES profiles(id),
  storage_pfad TEXT NOT NULL,
  beschreibung TEXT,
  datum DATE NOT NULL DEFAULT CURRENT_DATE,
  sichtbar_fuer_eltern BOOLEAN DEFAULT false,
  erstellt_am TIMESTAMPTZ DEFAULT now()
);

-- 6. Foto-Kinder — Welche Kinder auf welchem Foto
CREATE TABLE foto_kinder (
  foto_id UUID NOT NULL REFERENCES fotos(id) ON DELETE CASCADE,
  kind_id UUID NOT NULL REFERENCES kinder(id) ON DELETE CASCADE,
  PRIMARY KEY (foto_id, kind_id)
);

-- Indexes
CREATE INDEX idx_einladungen_code ON einladungen(code);
CREATE INDEX idx_einladungen_einrichtung ON einladungen(einrichtung_id);
CREATE INDEX idx_termine_einrichtung_datum ON termine(einrichtung_id, datum);
CREATE INDEX idx_termin_rueckmeldungen_termin ON termin_rueckmeldungen(termin_id);
CREATE INDEX idx_fotos_einrichtung ON fotos(einrichtung_id);
CREATE INDEX idx_fotos_datum ON fotos(datum);
CREATE INDEX idx_foto_kinder_kind ON foto_kinder(kind_id);

-- Trigger: aktualisiert_am automatisch setzen (Funktion aus 009_functions.sql)
CREATE TRIGGER tr_termine_updated BEFORE UPDATE ON termine FOR EACH ROW EXECUTE FUNCTION update_aktualisiert_am();
CREATE TRIGGER tr_termin_rueckmeldungen_updated BEFORE UPDATE ON termin_rueckmeldungen FOR EACH ROW EXECUTE FUNCTION update_aktualisiert_am();
CREATE TRIGGER tr_push_einstellungen_updated BEFORE UPDATE ON push_einstellungen FOR EACH ROW EXECUTE FUNCTION update_aktualisiert_am();
