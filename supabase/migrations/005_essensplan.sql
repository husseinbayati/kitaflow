-- KitaFlow: Essensplan
-- Mahlzeitenplanung mit Allergen-Tracking

CREATE TABLE essensplaene (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  einrichtung_id UUID NOT NULL REFERENCES einrichtungen(id) ON DELETE CASCADE,
  datum DATE NOT NULL,
  mahlzeit_typ TEXT NOT NULL CHECK (mahlzeit_typ IN ('fruehstueck','mittagessen','snack')),
  gericht_name TEXT NOT NULL,
  beschreibung TEXT,
  allergene TEXT[] DEFAULT '{}',
  vegetarisch BOOLEAN DEFAULT false,
  vegan BOOLEAN DEFAULT false,
  bild_url TEXT,
  erstellt_von UUID REFERENCES profiles(id),
  erstellt_am TIMESTAMPTZ DEFAULT now(),
  UNIQUE(einrichtung_id, datum, mahlzeit_typ)
);

CREATE INDEX idx_essensplan_einrichtung_datum ON essensplaene(einrichtung_id, datum);
