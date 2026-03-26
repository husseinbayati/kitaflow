-- KitaFlow: Kern-Tabellen
-- Einrichtungen, Gruppen/Klassen, Profiles, Mitarbeiter-Zuordnung

CREATE TABLE einrichtungen (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  typ TEXT NOT NULL CHECK (typ IN ('krippe','kita','grundschule','ogs','hort')),
  adresse_strasse TEXT,
  adresse_plz TEXT,
  adresse_ort TEXT,
  adresse_bundesland TEXT,
  telefon TEXT,
  email TEXT,
  website TEXT,
  traeger_id UUID REFERENCES einrichtungen(id) ON DELETE SET NULL,
  einstellungen JSONB DEFAULT '{}',
  aktiv BOOLEAN DEFAULT true,
  erstellt_am TIMESTAMPTZ DEFAULT now(),
  aktualisiert_am TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE gruppen_klassen (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  einrichtung_id UUID NOT NULL REFERENCES einrichtungen(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  typ TEXT NOT NULL CHECK (typ IN ('gruppe','klasse')),
  max_kinder INT,
  altersspanne_von INT,
  altersspanne_bis INT,
  farbe TEXT,
  aktiv BOOLEAN DEFAULT true,
  schuljahr TEXT,
  erstellt_am TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_gruppen_einrichtung ON gruppen_klassen(einrichtung_id);

CREATE TABLE profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email TEXT,
  vorname TEXT NOT NULL DEFAULT '',
  nachname TEXT NOT NULL DEFAULT '',
  rolle TEXT NOT NULL CHECK (rolle IN ('erzieher','lehrer','leitung','traeger','eltern')),
  einrichtung_id UUID REFERENCES einrichtungen(id) ON DELETE SET NULL,
  telefon TEXT,
  avatar_url TEXT,
  sprache TEXT DEFAULT 'de',
  push_token TEXT,
  aktiv BOOLEAN DEFAULT true,
  email_verifiziert BOOLEAN DEFAULT false,
  einstellungen JSONB DEFAULT '{}',
  erstellt_am TIMESTAMPTZ DEFAULT now(),
  aktualisiert_am TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_profiles_einrichtung ON profiles(einrichtung_id);
CREATE INDEX idx_profiles_rolle ON profiles(rolle);

CREATE TABLE mitarbeiter_einrichtung (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  mitarbeiter_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  einrichtung_id UUID NOT NULL REFERENCES einrichtungen(id) ON DELETE CASCADE,
  rolle_in_einrichtung TEXT NOT NULL,
  gruppe_id UUID REFERENCES gruppen_klassen(id) ON DELETE SET NULL,
  aktiv_seit DATE DEFAULT CURRENT_DATE,
  aktiv_bis DATE,
  UNIQUE(mitarbeiter_id, einrichtung_id)
);
