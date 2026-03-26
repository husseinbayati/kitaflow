-- KitaFlow: Tagesnotizen für Eingewöhnung
-- Strukturierte tägliche Beobachtungen während der Eingewöhnungsphase

CREATE TABLE eingewoehnung_tagesnotizen (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  eingewoehnung_id UUID NOT NULL REFERENCES eingewoehnung(id) ON DELETE CASCADE,
  datum DATE NOT NULL,
  dauer_minuten INT,
  trennungsverhalten INT CHECK (trennungsverhalten BETWEEN 1 AND 5),
  trennungsverhalten_text TEXT,
  essen TEXT,
  schlaf TEXT,
  spiel TEXT,
  stimmung TEXT CHECK (stimmung IN ('sehr_gut','gut','neutral','schlecht','sehr_schlecht')),
  notizen_intern TEXT,
  notizen_eltern TEXT,
  erstellt_von UUID REFERENCES profiles(id),
  erstellt_am TIMESTAMPTZ DEFAULT now(),
  UNIQUE(eingewoehnung_id, datum)
);

CREATE INDEX idx_tagesnotizen_eingewoehnung ON eingewoehnung_tagesnotizen(eingewoehnung_id);
CREATE INDEX idx_tagesnotizen_datum ON eingewoehnung_tagesnotizen(datum);

-- RLS
ALTER TABLE eingewoehnung_tagesnotizen ENABLE ROW LEVEL SECURITY;

CREATE POLICY tagesnotizen_select ON eingewoehnung_tagesnotizen FOR SELECT USING (
  eingewoehnung_id IN (
    SELECT e.id FROM eingewoehnung e
    JOIN kinder k ON e.kind_id = k.id
    WHERE k.einrichtung_id = get_user_einrichtung_id()
  )
  OR eingewoehnung_id IN (
    SELECT e.id FROM eingewoehnung e WHERE is_eltern_von(e.kind_id)
  )
);

CREATE POLICY tagesnotizen_manage ON eingewoehnung_tagesnotizen FOR ALL USING (
  eingewoehnung_id IN (
    SELECT e.id FROM eingewoehnung e
    JOIN kinder k ON e.kind_id = k.id
    WHERE k.einrichtung_id = get_user_einrichtung_id()
  )
  AND get_user_rolle() IN ('erzieher', 'leitung')
);
