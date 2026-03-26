-- KitaFlow: Row Level Security für alle Tabellen
-- Prinzip: Jeder sieht nur Daten seiner Einrichtung. Eltern nur eigene Kinder.

-- Enable RLS on ALL tables
ALTER TABLE einrichtungen ENABLE ROW LEVEL SECURITY;
ALTER TABLE gruppen_klassen ENABLE ROW LEVEL SECURITY;
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE mitarbeiter_einrichtung ENABLE ROW LEVEL SECURITY;
ALTER TABLE kinder ENABLE ROW LEVEL SECURITY;
ALTER TABLE allergien ENABLE ROW LEVEL SECURITY;
ALTER TABLE kontaktpersonen ENABLE ROW LEVEL SECURITY;
ALTER TABLE eltern_kind ENABLE ROW LEVEL SECURITY;
ALTER TABLE anwesenheit ENABLE ROW LEVEL SECURITY;
ALTER TABLE nachrichten ENABLE ROW LEVEL SECURITY;
ALTER TABLE nachricht_empfaenger ENABLE ROW LEVEL SECURITY;
ALTER TABLE nachricht_anhaenge ENABLE ROW LEVEL SECURITY;
ALTER TABLE essensplaene ENABLE ROW LEVEL SECURITY;
ALTER TABLE beobachtungen ENABLE ROW LEVEL SECURITY;
ALTER TABLE meilensteine ENABLE ROW LEVEL SECURITY;
ALTER TABLE ki_berichte ENABLE ROW LEVEL SECURITY;
ALTER TABLE dokumente ENABLE ROW LEVEL SECURITY;
ALTER TABLE eingewoehnung ENABLE ROW LEVEL SECURITY;
ALTER TABLE warteliste ENABLE ROW LEVEL SECURITY;
ALTER TABLE beitraege ENABLE ROW LEVEL SECURITY;
ALTER TABLE sepa_mandate ENABLE ROW LEVEL SECURITY;
ALTER TABLE stundenplan ENABLE ROW LEVEL SECURITY;
ALTER TABLE klassenbuch ENABLE ROW LEVEL SECURITY;
ALTER TABLE noten ENABLE ROW LEVEL SECURITY;
ALTER TABLE elternsprechtage ENABLE ROW LEVEL SECURITY;
ALTER TABLE ags ENABLE ROW LEVEL SECURITY;
ALTER TABLE ag_teilnahme ENABLE ROW LEVEL SECURITY;

-- ==========================================
-- PROFILES
-- ==========================================
-- Jeder kann sein eigenes Profil lesen
CREATE POLICY profiles_select_own ON profiles FOR SELECT USING (id = auth.uid());
-- Mitarbeiter sehen Kollegen ihrer Einrichtung
CREATE POLICY profiles_select_einrichtung ON profiles FOR SELECT USING (
  einrichtung_id = get_user_einrichtung_id()
);
-- Jeder kann sein eigenes Profil aktualisieren
CREATE POLICY profiles_update_own ON profiles FOR UPDATE USING (id = auth.uid());
-- Insert wird über den Trigger on_auth_user_created gesteuert
CREATE POLICY profiles_insert ON profiles FOR INSERT WITH CHECK (id = auth.uid());

-- ==========================================
-- EINRICHTUNGEN
-- ==========================================
-- Mitarbeiter sehen ihre Einrichtung
CREATE POLICY einrichtungen_select ON einrichtungen FOR SELECT USING (
  id = get_user_einrichtung_id()
  OR id IN (SELECT get_traeger_einrichtung_ids())
);
-- Leitung/Träger können ihre Einrichtung bearbeiten
CREATE POLICY einrichtungen_update ON einrichtungen FOR UPDATE USING (
  id = get_user_einrichtung_id() AND get_user_rolle() IN ('leitung', 'traeger')
);
-- Träger können Einrichtungen erstellen
CREATE POLICY einrichtungen_insert ON einrichtungen FOR INSERT WITH CHECK (
  get_user_rolle() IN ('leitung', 'traeger')
);

-- ==========================================
-- GRUPPEN_KLASSEN
-- ==========================================
CREATE POLICY gruppen_select ON gruppen_klassen FOR SELECT USING (
  einrichtung_id = get_user_einrichtung_id()
  OR einrichtung_id IN (SELECT get_traeger_einrichtung_ids())
);
CREATE POLICY gruppen_manage ON gruppen_klassen FOR ALL USING (
  einrichtung_id = get_user_einrichtung_id() AND get_user_rolle() IN ('leitung', 'traeger')
);

-- ==========================================
-- KINDER
-- ==========================================
-- Mitarbeiter sehen Kinder ihrer Einrichtung
CREATE POLICY kinder_select_einrichtung ON kinder FOR SELECT USING (
  einrichtung_id = get_user_einrichtung_id()
);
-- Eltern sehen nur ihre eigenen Kinder
CREATE POLICY kinder_select_eltern ON kinder FOR SELECT USING (
  is_eltern_von(id)
);
-- Träger sehen alle Kinder ihrer Einrichtungen
CREATE POLICY kinder_select_traeger ON kinder FOR SELECT USING (
  einrichtung_id IN (SELECT get_traeger_einrichtung_ids())
);
-- Erzieher/Leitung können Kinder verwalten
CREATE POLICY kinder_manage ON kinder FOR ALL USING (
  einrichtung_id = get_user_einrichtung_id()
  AND get_user_rolle() IN ('erzieher', 'lehrer', 'leitung')
);

-- ==========================================
-- ALLERGIEN
-- ==========================================
CREATE POLICY allergien_select ON allergien FOR SELECT USING (
  kind_id IN (SELECT id FROM kinder WHERE einrichtung_id = get_user_einrichtung_id())
  OR is_eltern_von(kind_id)
);
CREATE POLICY allergien_manage ON allergien FOR ALL USING (
  kind_id IN (SELECT id FROM kinder WHERE einrichtung_id = get_user_einrichtung_id())
  AND get_user_rolle() IN ('erzieher', 'lehrer', 'leitung')
);

-- ==========================================
-- KONTAKTPERSONEN
-- ==========================================
CREATE POLICY kontakt_select ON kontaktpersonen FOR SELECT USING (
  kind_id IN (SELECT id FROM kinder WHERE einrichtung_id = get_user_einrichtung_id())
  OR is_eltern_von(kind_id)
);
CREATE POLICY kontakt_manage ON kontaktpersonen FOR ALL USING (
  kind_id IN (SELECT id FROM kinder WHERE einrichtung_id = get_user_einrichtung_id())
  AND get_user_rolle() IN ('erzieher', 'leitung')
);

-- ==========================================
-- ELTERN_KIND
-- ==========================================
CREATE POLICY eltern_kind_select ON eltern_kind FOR SELECT USING (
  eltern_id = auth.uid()
  OR kind_id IN (SELECT id FROM kinder WHERE einrichtung_id = get_user_einrichtung_id())
);
CREATE POLICY eltern_kind_manage ON eltern_kind FOR ALL USING (
  kind_id IN (SELECT id FROM kinder WHERE einrichtung_id = get_user_einrichtung_id())
  AND get_user_rolle() IN ('leitung')
);

-- ==========================================
-- ANWESENHEIT
-- ==========================================
CREATE POLICY anwesenheit_select ON anwesenheit FOR SELECT USING (
  einrichtung_id = get_user_einrichtung_id()
  OR is_eltern_von(kind_id)
);
CREATE POLICY anwesenheit_manage ON anwesenheit FOR ALL USING (
  einrichtung_id = get_user_einrichtung_id()
  AND get_user_rolle() IN ('erzieher', 'lehrer', 'leitung')
);

-- ==========================================
-- NACHRICHTEN
-- ==========================================
CREATE POLICY nachrichten_select ON nachrichten FOR SELECT USING (
  einrichtung_id = get_user_einrichtung_id()
  OR absender_id = auth.uid()
  OR id IN (SELECT nachricht_id FROM nachricht_empfaenger WHERE empfaenger_id = auth.uid())
);
CREATE POLICY nachrichten_insert ON nachrichten FOR INSERT WITH CHECK (
  einrichtung_id = get_user_einrichtung_id()
);

CREATE POLICY ne_select ON nachricht_empfaenger FOR SELECT USING (
  empfaenger_id = auth.uid()
  OR nachricht_id IN (SELECT id FROM nachrichten WHERE absender_id = auth.uid())
);
CREATE POLICY ne_update ON nachricht_empfaenger FOR UPDATE USING (
  empfaenger_id = auth.uid()
);

CREATE POLICY na_select ON nachricht_anhaenge FOR SELECT USING (
  nachricht_id IN (SELECT id FROM nachrichten WHERE einrichtung_id = get_user_einrichtung_id())
  OR nachricht_id IN (SELECT nachricht_id FROM nachricht_empfaenger WHERE empfaenger_id = auth.uid())
);

-- ==========================================
-- ESSENSPLAENE
-- ==========================================
CREATE POLICY essensplan_select ON essensplaene FOR SELECT USING (
  einrichtung_id = get_user_einrichtung_id()
  OR einrichtung_id IN (SELECT get_traeger_einrichtung_ids())
  -- Eltern sehen Essensplan der Einrichtung ihrer Kinder
  OR einrichtung_id IN (
    SELECT k.einrichtung_id FROM kinder k
    JOIN eltern_kind ek ON ek.kind_id = k.id
    WHERE ek.eltern_id = auth.uid()
  )
);
CREATE POLICY essensplan_manage ON essensplaene FOR ALL USING (
  einrichtung_id = get_user_einrichtung_id()
  AND get_user_rolle() IN ('erzieher', 'leitung')
);

-- ==========================================
-- BEOBACHTUNGEN + MEILENSTEINE + KI_BERICHTE
-- ==========================================
CREATE POLICY beobachtungen_select ON beobachtungen FOR SELECT USING (
  einrichtung_id = get_user_einrichtung_id()
);
CREATE POLICY beobachtungen_manage ON beobachtungen FOR ALL USING (
  einrichtung_id = get_user_einrichtung_id()
  AND get_user_rolle() IN ('erzieher', 'lehrer', 'leitung')
);

CREATE POLICY meilensteine_select ON meilensteine FOR SELECT USING (
  kind_id IN (SELECT id FROM kinder WHERE einrichtung_id = get_user_einrichtung_id())
  OR is_eltern_von(kind_id)
);
CREATE POLICY meilensteine_manage ON meilensteine FOR ALL USING (
  kind_id IN (SELECT id FROM kinder WHERE einrichtung_id = get_user_einrichtung_id())
  AND get_user_rolle() IN ('erzieher', 'lehrer', 'leitung')
);

CREATE POLICY ki_berichte_select ON ki_berichte FOR SELECT USING (
  kind_id IN (SELECT id FROM kinder WHERE einrichtung_id = get_user_einrichtung_id())
  OR (is_eltern_von(kind_id) AND freigegeben = true)
);

-- ==========================================
-- DOKUMENTE
-- ==========================================
CREATE POLICY dokumente_select ON dokumente FOR SELECT USING (
  einrichtung_id = get_user_einrichtung_id()
  OR (kind_id IS NOT NULL AND is_eltern_von(kind_id))
);
CREATE POLICY dokumente_manage ON dokumente FOR ALL USING (
  einrichtung_id = get_user_einrichtung_id()
  AND get_user_rolle() IN ('leitung')
);

-- ==========================================
-- EINGEWOEHNUNG
-- ==========================================
CREATE POLICY eingewoehnung_select ON eingewoehnung FOR SELECT USING (
  kind_id IN (SELECT id FROM kinder WHERE einrichtung_id = get_user_einrichtung_id())
  OR is_eltern_von(kind_id)
);
CREATE POLICY eingewoehnung_manage ON eingewoehnung FOR ALL USING (
  kind_id IN (SELECT id FROM kinder WHERE einrichtung_id = get_user_einrichtung_id())
  AND get_user_rolle() IN ('erzieher', 'leitung')
);

-- ==========================================
-- WARTELISTE
-- ==========================================
CREATE POLICY warteliste_select ON warteliste FOR SELECT USING (
  einrichtung_id = get_user_einrichtung_id()
  AND get_user_rolle() IN ('leitung', 'traeger')
);
CREATE POLICY warteliste_manage ON warteliste FOR ALL USING (
  einrichtung_id = get_user_einrichtung_id()
  AND get_user_rolle() IN ('leitung')
);

-- ==========================================
-- BEITRAEGE + SEPA
-- ==========================================
CREATE POLICY beitraege_select ON beitraege FOR SELECT USING (
  einrichtung_id = get_user_einrichtung_id()
  OR is_eltern_von(kind_id)
);
CREATE POLICY beitraege_manage ON beitraege FOR ALL USING (
  einrichtung_id = get_user_einrichtung_id()
  AND get_user_rolle() IN ('leitung', 'traeger')
);

CREATE POLICY sepa_select ON sepa_mandate FOR SELECT USING (
  eltern_id = auth.uid()
);
CREATE POLICY sepa_manage ON sepa_mandate FOR ALL USING (
  eltern_id = auth.uid()
);

-- ==========================================
-- SCHUL-TABELLEN
-- ==========================================
CREATE POLICY stundenplan_select ON stundenplan FOR SELECT USING (
  klasse_id IN (SELECT id FROM gruppen_klassen WHERE einrichtung_id = get_user_einrichtung_id())
);
CREATE POLICY stundenplan_manage ON stundenplan FOR ALL USING (
  klasse_id IN (SELECT id FROM gruppen_klassen WHERE einrichtung_id = get_user_einrichtung_id())
  AND get_user_rolle() IN ('lehrer', 'leitung')
);

CREATE POLICY klassenbuch_select ON klassenbuch FOR SELECT USING (
  klasse_id IN (SELECT id FROM gruppen_klassen WHERE einrichtung_id = get_user_einrichtung_id())
);
CREATE POLICY klassenbuch_manage ON klassenbuch FOR ALL USING (
  klasse_id IN (SELECT id FROM gruppen_klassen WHERE einrichtung_id = get_user_einrichtung_id())
  AND get_user_rolle() IN ('lehrer', 'leitung')
);

CREATE POLICY noten_select ON noten FOR SELECT USING (
  kind_id IN (SELECT id FROM kinder WHERE einrichtung_id = get_user_einrichtung_id())
  OR is_eltern_von(kind_id)
);
CREATE POLICY noten_manage ON noten FOR ALL USING (
  kind_id IN (SELECT id FROM kinder WHERE einrichtung_id = get_user_einrichtung_id())
  AND get_user_rolle() IN ('lehrer', 'leitung')
);

CREATE POLICY elternsprechtage_select ON elternsprechtage FOR SELECT USING (
  einrichtung_id = get_user_einrichtung_id()
);
CREATE POLICY elternsprechtage_manage ON elternsprechtage FOR ALL USING (
  einrichtung_id = get_user_einrichtung_id()
  AND get_user_rolle() IN ('lehrer', 'leitung')
);

CREATE POLICY ags_select ON ags FOR SELECT USING (
  einrichtung_id = get_user_einrichtung_id()
);
CREATE POLICY ags_manage ON ags FOR ALL USING (
  einrichtung_id = get_user_einrichtung_id()
  AND get_user_rolle() IN ('leitung')
);

CREATE POLICY ag_teilnahme_select ON ag_teilnahme FOR SELECT USING (
  ag_id IN (SELECT id FROM ags WHERE einrichtung_id = get_user_einrichtung_id())
  OR is_eltern_von(kind_id)
);
CREATE POLICY ag_teilnahme_manage ON ag_teilnahme FOR ALL USING (
  ag_id IN (SELECT id FROM ags WHERE einrichtung_id = get_user_einrichtung_id())
  AND get_user_rolle() IN ('leitung', 'erzieher')
);

-- ==========================================
-- MITARBEITER_EINRICHTUNG
-- ==========================================
CREATE POLICY me_select ON mitarbeiter_einrichtung FOR SELECT USING (
  einrichtung_id = get_user_einrichtung_id()
);
CREATE POLICY me_manage ON mitarbeiter_einrichtung FOR ALL USING (
  einrichtung_id = get_user_einrichtung_id()
  AND get_user_rolle() IN ('leitung', 'traeger')
);
