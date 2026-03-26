-- KitaFlow: Nachrichten-System
-- Nachrichten, Empfänger-Tracking, Anhänge

CREATE TABLE nachrichten (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  absender_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  einrichtung_id UUID NOT NULL REFERENCES einrichtungen(id) ON DELETE CASCADE,
  typ TEXT NOT NULL DEFAULT 'nachricht' CHECK (typ IN ('nachricht','elternbrief','ankuendigung','notfall')),
  betreff TEXT NOT NULL,
  inhalt TEXT NOT NULL,
  empfaenger_typ TEXT NOT NULL DEFAULT 'alle' CHECK (empfaenger_typ IN ('alle','gruppe','einzeln')),
  gruppe_id UUID REFERENCES gruppen_klassen(id) ON DELETE SET NULL,
  wichtig BOOLEAN DEFAULT false,
  erstellt_am TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_nachrichten_einrichtung ON nachrichten(einrichtung_id);
CREATE INDEX idx_nachrichten_absender ON nachrichten(absender_id);

CREATE TABLE nachricht_empfaenger (
  nachricht_id UUID NOT NULL REFERENCES nachrichten(id) ON DELETE CASCADE,
  empfaenger_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  gelesen BOOLEAN DEFAULT false,
  gelesen_am TIMESTAMPTZ,
  PRIMARY KEY(nachricht_id, empfaenger_id)
);

CREATE TABLE nachricht_anhaenge (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nachricht_id UUID NOT NULL REFERENCES nachrichten(id) ON DELETE CASCADE,
  dateiname TEXT NOT NULL,
  dateipfad TEXT NOT NULL,
  dateityp TEXT,
  dateigroesse BIGINT,
  erstellt_am TIMESTAMPTZ DEFAULT now()
);
