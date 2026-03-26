-- KitaFlow: Kinder, Allergien, Kontaktpersonen, Eltern-Kind-Verknüpfung

CREATE TABLE kinder (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  vorname TEXT NOT NULL,
  nachname TEXT NOT NULL,
  geburtsdatum DATE NOT NULL,
  geschlecht TEXT CHECK (geschlecht IN ('maennlich','weiblich','divers')),
  avatar_url TEXT,
  einrichtung_id UUID NOT NULL REFERENCES einrichtungen(id) ON DELETE CASCADE,
  gruppe_id UUID REFERENCES gruppen_klassen(id) ON DELETE SET NULL,
  status TEXT NOT NULL DEFAULT 'aktiv' CHECK (status IN ('aktiv','eingewoehnung','abgemeldet','warteliste')),
  eintrittsdatum DATE,
  austrittsdatum DATE,
  notizen TEXT,
  erstellt_am TIMESTAMPTZ DEFAULT now(),
  aktualisiert_am TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_kinder_einrichtung ON kinder(einrichtung_id);
CREATE INDEX idx_kinder_gruppe ON kinder(gruppe_id);

CREATE TABLE allergien (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  kind_id UUID NOT NULL REFERENCES kinder(id) ON DELETE CASCADE,
  allergen TEXT NOT NULL,
  schweregrad TEXT NOT NULL DEFAULT 'mittel' CHECK (schweregrad IN ('leicht','mittel','schwer','lebensbedrohlich')),
  hinweise TEXT,
  erstellt_am TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_allergien_kind ON allergien(kind_id);

CREATE TABLE kontaktpersonen (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  kind_id UUID NOT NULL REFERENCES kinder(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  beziehung TEXT NOT NULL,
  telefon TEXT,
  email TEXT,
  ist_abholberechtigt BOOLEAN DEFAULT false,
  ist_notfallkontakt BOOLEAN DEFAULT false,
  prioritaet INT DEFAULT 1,
  erstellt_am TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_kontakt_kind ON kontaktpersonen(kind_id);

CREATE TABLE eltern_kind (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  eltern_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  kind_id UUID NOT NULL REFERENCES kinder(id) ON DELETE CASCADE,
  beziehung TEXT NOT NULL CHECK (beziehung IN ('mutter','vater','sorgeberechtigt')),
  ist_hauptkontakt BOOLEAN DEFAULT false,
  erstellt_am TIMESTAMPTZ DEFAULT now(),
  UNIQUE(eltern_id, kind_id)
);
