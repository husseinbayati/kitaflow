-- KitaFlow: Trigger-Funktionen, Helper-Funktionen, Views

-- 1. Auto-Update aktualisiert_am
CREATE OR REPLACE FUNCTION update_aktualisiert_am()
RETURNS TRIGGER AS $$
BEGIN
  NEW.aktualisiert_am = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger auf alle Tabellen mit aktualisiert_am
CREATE TRIGGER tr_einrichtungen_updated BEFORE UPDATE ON einrichtungen FOR EACH ROW EXECUTE FUNCTION update_aktualisiert_am();
CREATE TRIGGER tr_profiles_updated BEFORE UPDATE ON profiles FOR EACH ROW EXECUTE FUNCTION update_aktualisiert_am();
CREATE TRIGGER tr_kinder_updated BEFORE UPDATE ON kinder FOR EACH ROW EXECUTE FUNCTION update_aktualisiert_am();

-- 2. Auto-create Profile bei neuem Auth-User
CREATE OR REPLACE FUNCTION on_auth_user_created()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, email, vorname, nachname, rolle)
  VALUES (
    NEW.id,
    NEW.email,
    COALESCE(NEW.raw_user_meta_data->>'vorname', ''),
    COALESCE(NEW.raw_user_meta_data->>'nachname', ''),
    COALESCE(NEW.raw_user_meta_data->>'rolle', 'eltern')
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION on_auth_user_created();

-- 3. RLS Helper: Einrichtungs-ID des eingeloggten Users
CREATE OR REPLACE FUNCTION get_user_einrichtung_id()
RETURNS UUID AS $$
  SELECT einrichtung_id FROM public.profiles WHERE id = auth.uid();
$$ LANGUAGE sql STABLE SECURITY DEFINER;

-- 4. RLS Helper: Rolle des eingeloggten Users
CREATE OR REPLACE FUNCTION get_user_rolle()
RETURNS TEXT AS $$
  SELECT rolle FROM public.profiles WHERE id = auth.uid();
$$ LANGUAGE sql STABLE SECURITY DEFINER;

-- 5. RLS Helper: Prüft ob User Elternteil des Kindes ist
CREATE OR REPLACE FUNCTION is_eltern_von(p_kind_id UUID)
RETURNS BOOLEAN AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.eltern_kind
    WHERE eltern_id = auth.uid() AND kind_id = p_kind_id
  );
$$ LANGUAGE sql STABLE SECURITY DEFINER;

-- 6. Helper: Alle Einrichtungs-IDs eines Trägers
CREATE OR REPLACE FUNCTION get_traeger_einrichtung_ids()
RETURNS SETOF UUID AS $$
  SELECT id FROM public.einrichtungen
  WHERE traeger_id IN (
    SELECT einrichtung_id FROM public.profiles WHERE id = auth.uid()
  )
  UNION
  SELECT einrichtung_id FROM public.profiles WHERE id = auth.uid();
$$ LANGUAGE sql STABLE SECURITY DEFINER;

-- 7. View: Heutige Anwesenheit mit Kind-Details
CREATE OR REPLACE VIEW v_anwesenheit_heute AS
SELECT
  a.id,
  a.kind_id,
  k.vorname,
  k.nachname,
  k.gruppe_id,
  g.name AS gruppe_name,
  a.status,
  a.ankunft_zeit,
  a.abgeholt_zeit,
  a.notiz,
  a.einrichtung_id
FROM anwesenheit a
JOIN kinder k ON k.id = a.kind_id
LEFT JOIN gruppen_klassen g ON g.id = k.gruppe_id
WHERE a.datum = CURRENT_DATE;

-- 8. View: Ungelesene Nachrichten pro User
CREATE OR REPLACE VIEW v_nachrichten_ungelesen AS
SELECT
  ne.empfaenger_id,
  n.id AS nachricht_id,
  n.betreff,
  n.typ,
  n.wichtig,
  n.erstellt_am,
  p.vorname AS absender_vorname,
  p.nachname AS absender_nachname
FROM nachricht_empfaenger ne
JOIN nachrichten n ON n.id = ne.nachricht_id
JOIN profiles p ON p.id = n.absender_id
WHERE ne.gelesen = false;
