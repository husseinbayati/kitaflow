-- KitaFlow: Anwesenheit
-- Tägliche An-/Abwesenheitserfassung für Kinder

CREATE TABLE anwesenheit (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  kind_id UUID NOT NULL REFERENCES kinder(id) ON DELETE CASCADE,
  datum DATE NOT NULL DEFAULT CURRENT_DATE,
  ankunft_zeit TIME,
  abgeholt_zeit TIME,
  status TEXT NOT NULL DEFAULT 'anwesend' CHECK (status IN ('anwesend','abwesend','krank','urlaub','entschuldigt','unentschuldigt')),
  abgeholt_von TEXT,
  gebracht_von TEXT,
  notiz TEXT,
  erfasst_von UUID REFERENCES profiles(id),
  einrichtung_id UUID NOT NULL REFERENCES einrichtungen(id) ON DELETE CASCADE,
  erstellt_am TIMESTAMPTZ DEFAULT now(),
  UNIQUE(kind_id, datum)
);

CREATE INDEX idx_anwesenheit_kind_datum ON anwesenheit(kind_id, datum);
CREATE INDEX idx_anwesenheit_einrichtung_datum ON anwesenheit(einrichtung_id, datum);
