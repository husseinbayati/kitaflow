-- KitaFlow: Entwicklungsdokumentation
-- Beobachtungen, Meilensteine, KI-generierte Berichte

CREATE TABLE beobachtungen (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  kind_id UUID NOT NULL REFERENCES kinder(id) ON DELETE CASCADE,
  erzieher_id UUID NOT NULL REFERENCES profiles(id),
  einrichtung_id UUID NOT NULL REFERENCES einrichtungen(id) ON DELETE CASCADE,
  bereich TEXT NOT NULL CHECK (bereich IN ('motorik','sprache','sozial','kognitiv','emotional','kreativ')),
  titel TEXT NOT NULL,
  inhalt TEXT NOT NULL,
  datum DATE NOT NULL DEFAULT CURRENT_DATE,
  vertraulich BOOLEAN DEFAULT false,
  erstellt_am TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_beobachtungen_kind ON beobachtungen(kind_id);
CREATE INDEX idx_beobachtungen_einrichtung ON beobachtungen(einrichtung_id);

CREATE TABLE meilensteine (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  kind_id UUID NOT NULL REFERENCES kinder(id) ON DELETE CASCADE,
  bereich TEXT NOT NULL CHECK (bereich IN ('motorik','sprache','sozial','kognitiv','emotional','kreativ')),
  bezeichnung TEXT NOT NULL,
  erreicht_am DATE,
  notiz TEXT,
  erfasst_von UUID REFERENCES profiles(id),
  erstellt_am TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_meilensteine_kind ON meilensteine(kind_id);

CREATE TABLE ki_berichte (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  kind_id UUID NOT NULL REFERENCES kinder(id) ON DELETE CASCADE,
  berichtstyp TEXT NOT NULL,
  zeitraum_von DATE NOT NULL,
  zeitraum_bis DATE NOT NULL,
  inhalt TEXT NOT NULL,
  generiert_am TIMESTAMPTZ DEFAULT now(),
  generiert_von UUID REFERENCES profiles(id),
  freigegeben BOOLEAN DEFAULT false,
  freigegeben_von UUID REFERENCES profiles(id),
  freigegeben_am TIMESTAMPTZ
);

CREATE INDEX idx_ki_berichte_kind ON ki_berichte(kind_id);
