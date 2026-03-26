-- KitaFlow Phase 10: RLS für Eltern-App Tabellen

-- Enable RLS on all new tables
ALTER TABLE einladungen ENABLE ROW LEVEL SECURITY;
ALTER TABLE termine ENABLE ROW LEVEL SECURITY;
ALTER TABLE termin_rueckmeldungen ENABLE ROW LEVEL SECURITY;
ALTER TABLE push_einstellungen ENABLE ROW LEVEL SECURITY;
ALTER TABLE fotos ENABLE ROW LEVEL SECURITY;
ALTER TABLE foto_kinder ENABLE ROW LEVEL SECURITY;

-- ==========================================
-- EINLADUNGEN
-- ==========================================
-- Leitung kann alle Einladungen ihrer Einrichtung sehen
CREATE POLICY einladungen_select_leitung ON einladungen FOR SELECT USING (
  einrichtung_id = get_user_einrichtung_id() AND get_user_rolle() = 'leitung'
);
-- Eltern sehen ihre eigenen eingelösten Einladungen
CREATE POLICY einladungen_select_eltern ON einladungen FOR SELECT USING (
  eingeloest_von = auth.uid()
);
-- Leitung kann Einladungen erstellen
CREATE POLICY einladungen_insert ON einladungen FOR INSERT WITH CHECK (
  einrichtung_id = get_user_einrichtung_id() AND get_user_rolle() = 'leitung'
);
-- Leitung kann Einladungen aktualisieren
CREATE POLICY einladungen_update_leitung ON einladungen FOR UPDATE USING (
  einrichtung_id = get_user_einrichtung_id() AND get_user_rolle() = 'leitung'
);
-- Eltern können eine Einladung einlösen (nur wenn noch nicht eingelöst und aktiv)
CREATE POLICY einladungen_update_eltern ON einladungen FOR UPDATE USING (
  eingeloest_von IS NULL AND aktiv = true
) WITH CHECK (
  eingeloest_von = auth.uid()
);
-- Leitung kann Einladungen löschen
CREATE POLICY einladungen_delete ON einladungen FOR DELETE USING (
  einrichtung_id = get_user_einrichtung_id() AND get_user_rolle() = 'leitung'
);

-- ==========================================
-- TERMINE
-- ==========================================
-- Mitarbeiter sehen Termine ihrer Einrichtung
CREATE POLICY termine_select_staff ON termine FOR SELECT USING (
  einrichtung_id = get_user_einrichtung_id()
  AND get_user_rolle() IN ('erzieher', 'lehrer', 'leitung')
);
-- Eltern sehen Termine der Einrichtung ihrer Kinder
CREATE POLICY termine_select_eltern ON termine FOR SELECT USING (
  einrichtung_id IN (
    SELECT k.einrichtung_id FROM kinder k
    JOIN eltern_kind ek ON ek.kind_id = k.id
    WHERE ek.eltern_id = auth.uid()
  )
);
-- Mitarbeiter können Termine erstellen
CREATE POLICY termine_insert ON termine FOR INSERT WITH CHECK (
  einrichtung_id = get_user_einrichtung_id()
  AND get_user_rolle() IN ('erzieher', 'lehrer', 'leitung')
);
-- Mitarbeiter können Termine aktualisieren
CREATE POLICY termine_update ON termine FOR UPDATE USING (
  einrichtung_id = get_user_einrichtung_id()
  AND get_user_rolle() IN ('erzieher', 'lehrer', 'leitung')
);
-- Mitarbeiter können Termine löschen
CREATE POLICY termine_delete ON termine FOR DELETE USING (
  einrichtung_id = get_user_einrichtung_id()
  AND get_user_rolle() IN ('erzieher', 'lehrer', 'leitung')
);

-- ==========================================
-- TERMIN_RUECKMELDUNGEN
-- ==========================================
-- Eltern sehen ihre eigenen Rückmeldungen
CREATE POLICY tr_select_eltern ON termin_rueckmeldungen FOR SELECT USING (
  eltern_id = auth.uid()
);
-- Mitarbeiter sehen alle Rückmeldungen ihrer Einrichtung
CREATE POLICY tr_select_staff ON termin_rueckmeldungen FOR SELECT USING (
  termin_id IN (SELECT id FROM termine WHERE einrichtung_id = get_user_einrichtung_id())
  AND get_user_rolle() IN ('erzieher', 'lehrer', 'leitung')
);
-- Eltern können Rückmeldungen erstellen
CREATE POLICY tr_insert ON termin_rueckmeldungen FOR INSERT WITH CHECK (
  eltern_id = auth.uid()
);
-- Eltern können ihre Rückmeldungen aktualisieren
CREATE POLICY tr_update ON termin_rueckmeldungen FOR UPDATE USING (
  eltern_id = auth.uid()
);

-- ==========================================
-- PUSH_EINSTELLUNGEN
-- ==========================================
-- Jeder kann seine eigenen Einstellungen sehen
CREATE POLICY push_select ON push_einstellungen FOR SELECT USING (
  user_id = auth.uid()
);
-- Jeder kann seine eigenen Einstellungen erstellen
CREATE POLICY push_insert ON push_einstellungen FOR INSERT WITH CHECK (
  user_id = auth.uid()
);
-- Jeder kann seine eigenen Einstellungen aktualisieren
CREATE POLICY push_update ON push_einstellungen FOR UPDATE USING (
  user_id = auth.uid()
);
-- Jeder kann seine eigenen Einstellungen löschen
CREATE POLICY push_delete ON push_einstellungen FOR DELETE USING (
  user_id = auth.uid()
);

-- ==========================================
-- FOTOS
-- ==========================================
-- Mitarbeiter sehen Fotos ihrer Einrichtung
CREATE POLICY fotos_select_staff ON fotos FOR SELECT USING (
  einrichtung_id = get_user_einrichtung_id()
  AND get_user_rolle() IN ('erzieher', 'lehrer', 'leitung')
);
-- Eltern sehen freigegebene Fotos, auf denen ihr Kind ist
CREATE POLICY fotos_select_eltern ON fotos FOR SELECT USING (
  sichtbar_fuer_eltern = true
  AND id IN (
    SELECT fk.foto_id FROM foto_kinder fk
    JOIN eltern_kind ek ON ek.kind_id = fk.kind_id
    WHERE ek.eltern_id = auth.uid()
  )
);
-- Mitarbeiter können Fotos erstellen
CREATE POLICY fotos_insert ON fotos FOR INSERT WITH CHECK (
  einrichtung_id = get_user_einrichtung_id()
  AND get_user_rolle() IN ('erzieher', 'lehrer', 'leitung')
);
-- Mitarbeiter können Fotos aktualisieren
CREATE POLICY fotos_update ON fotos FOR UPDATE USING (
  einrichtung_id = get_user_einrichtung_id()
  AND get_user_rolle() IN ('erzieher', 'lehrer', 'leitung')
);
-- Mitarbeiter können Fotos löschen
CREATE POLICY fotos_delete ON fotos FOR DELETE USING (
  einrichtung_id = get_user_einrichtung_id()
  AND get_user_rolle() IN ('erzieher', 'lehrer', 'leitung')
);

-- ==========================================
-- FOTO_KINDER
-- ==========================================
-- Mitarbeiter sehen Foto-Kind-Verknüpfungen ihrer Einrichtung
CREATE POLICY fk_select_staff ON foto_kinder FOR SELECT USING (
  foto_id IN (SELECT id FROM fotos WHERE einrichtung_id = get_user_einrichtung_id())
  AND get_user_rolle() IN ('erzieher', 'lehrer', 'leitung')
);
-- Eltern sehen Verknüpfungen ihrer eigenen Kinder
CREATE POLICY fk_select_eltern ON foto_kinder FOR SELECT USING (
  kind_id IN (
    SELECT ek.kind_id FROM eltern_kind ek WHERE ek.eltern_id = auth.uid()
  )
);
-- Mitarbeiter können Foto-Kind-Verknüpfungen erstellen
CREATE POLICY fk_insert ON foto_kinder FOR INSERT WITH CHECK (
  foto_id IN (SELECT id FROM fotos WHERE einrichtung_id = get_user_einrichtung_id())
  AND get_user_rolle() IN ('erzieher', 'lehrer', 'leitung')
);
-- Mitarbeiter können Foto-Kind-Verknüpfungen löschen
CREATE POLICY fk_delete ON foto_kinder FOR DELETE USING (
  foto_id IN (SELECT id FROM fotos WHERE einrichtung_id = get_user_einrichtung_id())
  AND get_user_rolle() IN ('erzieher', 'lehrer', 'leitung')
);
