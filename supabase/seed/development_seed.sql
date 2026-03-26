-- KitaFlow Development Seed Data
-- HINWEIS: Profiles werden über auth.users Trigger erstellt.
-- Dieses Seed erstellt nur Einrichtungen, Gruppen, Kinder etc.

-- Erst Einrichtungen
-- Use fixed UUIDs for referencing

-- Träger
INSERT INTO einrichtungen (id, name, typ, adresse_strasse, adresse_plz, adresse_ort, adresse_bundesland, telefon, email)
VALUES
  ('a0000000-0000-0000-0000-000000000001', 'Bildungswerk Sonnenschein e.V.', 'kita', 'Hauptstraße 1', '10115', 'Berlin', 'Berlin', '030-1234567', 'info@sonnenschein-ev.de');

-- Kita 1
INSERT INTO einrichtungen (id, name, typ, adresse_strasse, adresse_plz, adresse_ort, adresse_bundesland, telefon, email, traeger_id)
VALUES
  ('a0000000-0000-0000-0000-000000000002', 'Kita Regenbogen', 'kita', 'Gartenweg 12', '10117', 'Berlin', 'Berlin', '030-2345678', 'kita-regenbogen@sonnenschein-ev.de', 'a0000000-0000-0000-0000-000000000001');

-- Kita 2
INSERT INTO einrichtungen (id, name, typ, adresse_strasse, adresse_plz, adresse_ort, adresse_bundesland, telefon, email, traeger_id)
VALUES
  ('a0000000-0000-0000-0000-000000000003', 'Kita Waldwichtel', 'kita', 'Waldstraße 5', '10119', 'Berlin', 'Berlin', '030-3456789', 'waldwichtel@sonnenschein-ev.de', 'a0000000-0000-0000-0000-000000000001');

-- Grundschule
INSERT INTO einrichtungen (id, name, typ, adresse_strasse, adresse_plz, adresse_ort, adresse_bundesland, telefon, email, traeger_id)
VALUES
  ('a0000000-0000-0000-0000-000000000004', 'Grundschule am Park', 'grundschule', 'Parkallee 20', '10115', 'Berlin', 'Berlin', '030-4567890', 'gs-park@sonnenschein-ev.de', 'a0000000-0000-0000-0000-000000000001');

-- Gruppen für Kita Regenbogen
INSERT INTO gruppen_klassen (id, einrichtung_id, name, typ, max_kinder, altersspanne_von, altersspanne_bis, farbe) VALUES
  ('b0000000-0000-0000-0000-000000000001', 'a0000000-0000-0000-0000-000000000002', 'Sonnenblumen', 'gruppe', 15, 3, 6, '#FFD54F'),
  ('b0000000-0000-0000-0000-000000000002', 'a0000000-0000-0000-0000-000000000002', 'Marienkäfer', 'gruppe', 12, 1, 3, '#EF5350'),
  ('b0000000-0000-0000-0000-000000000003', 'a0000000-0000-0000-0000-000000000002', 'Schmetterlinge', 'gruppe', 15, 3, 6, '#AB47BC');

-- Gruppen für Kita Waldwichtel
INSERT INTO gruppen_klassen (id, einrichtung_id, name, typ, max_kinder, altersspanne_von, altersspanne_bis, farbe) VALUES
  ('b0000000-0000-0000-0000-000000000004', 'a0000000-0000-0000-0000-000000000003', 'Eichhörnchen', 'gruppe', 15, 3, 6, '#8D6E63'),
  ('b0000000-0000-0000-0000-000000000005', 'a0000000-0000-0000-0000-000000000003', 'Füchse', 'gruppe', 12, 1, 3, '#FF7043'),
  ('b0000000-0000-0000-0000-000000000006', 'a0000000-0000-0000-0000-000000000003', 'Igel', 'gruppe', 15, 3, 6, '#66BB6A');

-- Klassen für Grundschule
INSERT INTO gruppen_klassen (id, einrichtung_id, name, typ, max_kinder, farbe, schuljahr) VALUES
  ('b0000000-0000-0000-0000-000000000007', 'a0000000-0000-0000-0000-000000000004', '1a', 'klasse', 25, '#42A5F5', '2025/2026'),
  ('b0000000-0000-0000-0000-000000000008', 'a0000000-0000-0000-0000-000000000004', '2a', 'klasse', 25, '#66BB6A', '2025/2026'),
  ('b0000000-0000-0000-0000-000000000009', 'a0000000-0000-0000-0000-000000000004', '3a', 'klasse', 25, '#FFA726', '2025/2026');

-- 15 Kinder für Kita Regenbogen (5 pro Gruppe)
INSERT INTO kinder (id, vorname, nachname, geburtsdatum, geschlecht, einrichtung_id, gruppe_id, status) VALUES
  ('c0000000-0000-0000-0000-000000000001', 'Emma', 'Müller', '2021-03-15', 'weiblich', 'a0000000-0000-0000-0000-000000000002', 'b0000000-0000-0000-0000-000000000001', 'aktiv'),
  ('c0000000-0000-0000-0000-000000000002', 'Ben', 'Schmidt', '2021-07-22', 'maennlich', 'a0000000-0000-0000-0000-000000000002', 'b0000000-0000-0000-0000-000000000001', 'aktiv'),
  ('c0000000-0000-0000-0000-000000000003', 'Mila', 'Weber', '2020-11-03', 'weiblich', 'a0000000-0000-0000-0000-000000000002', 'b0000000-0000-0000-0000-000000000001', 'aktiv'),
  ('c0000000-0000-0000-0000-000000000004', 'Noah', 'Fischer', '2021-01-28', 'maennlich', 'a0000000-0000-0000-0000-000000000002', 'b0000000-0000-0000-0000-000000000001', 'aktiv'),
  ('c0000000-0000-0000-0000-000000000005', 'Lina', 'Wagner', '2020-09-12', 'weiblich', 'a0000000-0000-0000-0000-000000000002', 'b0000000-0000-0000-0000-000000000001', 'aktiv'),
  ('c0000000-0000-0000-0000-000000000006', 'Leon', 'Becker', '2023-02-14', 'maennlich', 'a0000000-0000-0000-0000-000000000002', 'b0000000-0000-0000-0000-000000000002', 'aktiv'),
  ('c0000000-0000-0000-0000-000000000007', 'Sofia', 'Hoffmann', '2023-05-20', 'weiblich', 'a0000000-0000-0000-0000-000000000002', 'b0000000-0000-0000-0000-000000000002', 'aktiv'),
  ('c0000000-0000-0000-0000-000000000008', 'Elias', 'Richter', '2022-08-07', 'maennlich', 'a0000000-0000-0000-0000-000000000002', 'b0000000-0000-0000-0000-000000000002', 'aktiv'),
  ('c0000000-0000-0000-0000-000000000009', 'Mia', 'Koch', '2022-12-25', 'weiblich', 'a0000000-0000-0000-0000-000000000002', 'b0000000-0000-0000-0000-000000000002', 'eingewoehnung'),
  ('c0000000-0000-0000-0000-000000000010', 'Finn', 'Bauer', '2023-04-11', 'maennlich', 'a0000000-0000-0000-0000-000000000002', 'b0000000-0000-0000-0000-000000000002', 'aktiv'),
  ('c0000000-0000-0000-0000-000000000011', 'Hannah', 'Schröder', '2020-06-30', 'weiblich', 'a0000000-0000-0000-0000-000000000002', 'b0000000-0000-0000-0000-000000000003', 'aktiv'),
  ('c0000000-0000-0000-0000-000000000012', 'Lukas', 'Braun', '2021-02-18', 'maennlich', 'a0000000-0000-0000-0000-000000000002', 'b0000000-0000-0000-0000-000000000003', 'aktiv'),
  ('c0000000-0000-0000-0000-000000000013', 'Emilia', 'Zimmermann', '2020-10-05', 'weiblich', 'a0000000-0000-0000-0000-000000000002', 'b0000000-0000-0000-0000-000000000003', 'aktiv'),
  ('c0000000-0000-0000-0000-000000000014', 'Paul', 'Krüger', '2021-04-22', 'maennlich', 'a0000000-0000-0000-0000-000000000002', 'b0000000-0000-0000-0000-000000000003', 'aktiv'),
  ('c0000000-0000-0000-0000-000000000015', 'Marie', 'Hartmann', '2020-08-17', 'weiblich', 'a0000000-0000-0000-0000-000000000002', 'b0000000-0000-0000-0000-000000000003', 'aktiv');

-- 10 Kinder für Kita Waldwichtel
INSERT INTO kinder (id, vorname, nachname, geburtsdatum, geschlecht, einrichtung_id, gruppe_id, status) VALUES
  ('c0000000-0000-0000-0000-000000000016', 'Liam', 'Neumann', '2021-01-10', 'maennlich', 'a0000000-0000-0000-0000-000000000003', 'b0000000-0000-0000-0000-000000000004', 'aktiv'),
  ('c0000000-0000-0000-0000-000000000017', 'Lea', 'Schwarz', '2020-12-03', 'weiblich', 'a0000000-0000-0000-0000-000000000003', 'b0000000-0000-0000-0000-000000000004', 'aktiv'),
  ('c0000000-0000-0000-0000-000000000018', 'Felix', 'Weiß', '2021-06-15', 'maennlich', 'a0000000-0000-0000-0000-000000000003', 'b0000000-0000-0000-0000-000000000004', 'aktiv'),
  ('c0000000-0000-0000-0000-000000000019', 'Clara', 'Meyer', '2023-03-08', 'weiblich', 'a0000000-0000-0000-0000-000000000003', 'b0000000-0000-0000-0000-000000000005', 'aktiv'),
  ('c0000000-0000-0000-0000-000000000020', 'Max', 'Lang', '2022-09-20', 'maennlich', 'a0000000-0000-0000-0000-000000000003', 'b0000000-0000-0000-0000-000000000005', 'aktiv'),
  ('c0000000-0000-0000-0000-000000000021', 'Anna', 'Werner', '2023-07-12', 'weiblich', 'a0000000-0000-0000-0000-000000000003', 'b0000000-0000-0000-0000-000000000005', 'eingewoehnung'),
  ('c0000000-0000-0000-0000-000000000022', 'Tim', 'Schulz', '2020-05-25', 'maennlich', 'a0000000-0000-0000-0000-000000000003', 'b0000000-0000-0000-0000-000000000006', 'aktiv'),
  ('c0000000-0000-0000-0000-000000000023', 'Lara', 'Hofmann', '2021-11-14', 'weiblich', 'a0000000-0000-0000-0000-000000000003', 'b0000000-0000-0000-0000-000000000006', 'aktiv'),
  ('c0000000-0000-0000-0000-000000000024', 'Jonas', 'Frank', '2020-04-02', 'maennlich', 'a0000000-0000-0000-0000-000000000003', 'b0000000-0000-0000-0000-000000000006', 'aktiv'),
  ('c0000000-0000-0000-0000-000000000025', 'Sophia', 'Keller', '2021-08-30', 'weiblich', 'a0000000-0000-0000-0000-000000000003', 'b0000000-0000-0000-0000-000000000006', 'aktiv');

-- 5 Kinder für Grundschule
INSERT INTO kinder (id, vorname, nachname, geburtsdatum, geschlecht, einrichtung_id, gruppe_id, status) VALUES
  ('c0000000-0000-0000-0000-000000000026', 'Jakob', 'Berger', '2019-02-14', 'maennlich', 'a0000000-0000-0000-0000-000000000004', 'b0000000-0000-0000-0000-000000000007', 'aktiv'),
  ('c0000000-0000-0000-0000-000000000027', 'Amelie', 'König', '2018-11-08', 'weiblich', 'a0000000-0000-0000-0000-000000000004', 'b0000000-0000-0000-0000-000000000008', 'aktiv'),
  ('c0000000-0000-0000-0000-000000000028', 'David', 'Möller', '2019-05-22', 'maennlich', 'a0000000-0000-0000-0000-000000000004', 'b0000000-0000-0000-0000-000000000007', 'aktiv'),
  ('c0000000-0000-0000-0000-000000000029', 'Emily', 'Huber', '2018-08-16', 'weiblich', 'a0000000-0000-0000-0000-000000000004', 'b0000000-0000-0000-0000-000000000008', 'aktiv'),
  ('c0000000-0000-0000-0000-000000000030', 'Moritz', 'Schmid', '2017-12-01', 'maennlich', 'a0000000-0000-0000-0000-000000000004', 'b0000000-0000-0000-0000-000000000009', 'aktiv');

-- Allergien (5 Kinder mit Allergien)
INSERT INTO allergien (kind_id, allergen, schweregrad, hinweise) VALUES
  ('c0000000-0000-0000-0000-000000000001', 'milch', 'mittel', 'Laktosefreie Alternativen bereitstellen'),
  ('c0000000-0000-0000-0000-000000000003', 'gluten', 'schwer', 'Strikt glutenfrei, Kontamination vermeiden'),
  ('c0000000-0000-0000-0000-000000000003', 'eier', 'leicht', 'Nur bei rohen Eiern'),
  ('c0000000-0000-0000-0000-000000000007', 'erdnuesse', 'lebensbedrohlich', 'EpiPen im Notfallkoffer! Sofort Notarzt rufen!'),
  ('c0000000-0000-0000-0000-000000000012', 'schalenfruechte', 'schwer', 'Keine Nüsse in der Nähe'),
  ('c0000000-0000-0000-0000-000000000018', 'soja', 'leicht', 'Sojafreie Milch verwenden'),
  ('c0000000-0000-0000-0000-000000000026', 'fisch', 'mittel', 'Kein Fisch, auch keine Fischstäbchen');

-- Kontaktpersonen (für einige Kinder)
INSERT INTO kontaktpersonen (kind_id, name, beziehung, telefon, email, ist_abholberechtigt, ist_notfallkontakt, prioritaet) VALUES
  ('c0000000-0000-0000-0000-000000000001', 'Maria Müller', 'Mutter', '0170-1111111', 'maria.mueller@email.de', true, true, 1),
  ('c0000000-0000-0000-0000-000000000001', 'Thomas Müller', 'Vater', '0170-2222222', 'thomas.mueller@email.de', true, true, 2),
  ('c0000000-0000-0000-0000-000000000001', 'Inge Müller', 'Großmutter', '0170-3333333', NULL, true, false, 3),
  ('c0000000-0000-0000-0000-000000000002', 'Julia Schmidt', 'Mutter', '0170-4444444', 'julia.schmidt@email.de', true, true, 1),
  ('c0000000-0000-0000-0000-000000000007', 'Andrea Hoffmann', 'Mutter', '0170-5555555', 'andrea.hoffmann@email.de', true, true, 1),
  ('c0000000-0000-0000-0000-000000000007', 'Markus Hoffmann', 'Vater', '0170-6666666', NULL, true, true, 2);

-- Essensplan für Kita Regenbogen (aktuelle Woche Mo-Fr)
INSERT INTO essensplaene (einrichtung_id, datum, mahlzeit_typ, gericht_name, beschreibung, allergene, vegetarisch) VALUES
  ('a0000000-0000-0000-0000-000000000002', CURRENT_DATE, 'mittagessen', 'Spaghetti Bolognese', 'Mit Rinderhackfleisch und Tomatensauce', '{"gluten"}', false),
  ('a0000000-0000-0000-0000-000000000002', CURRENT_DATE + 1, 'mittagessen', 'Gemüseauflauf', 'Kartoffel-Zucchini-Auflauf mit Käse überbacken', '{"milch","gluten"}', true),
  ('a0000000-0000-0000-0000-000000000002', CURRENT_DATE + 2, 'mittagessen', 'Fischstäbchen mit Kartoffelpüree', 'Pangasius-Stäbchen mit Erbsen', '{"fisch","gluten","milch"}', false),
  ('a0000000-0000-0000-0000-000000000002', CURRENT_DATE + 3, 'mittagessen', 'Pfannkuchen', 'Pfannkuchen mit Apfelmus oder Nutella', '{"gluten","eier","milch"}', true),
  ('a0000000-0000-0000-0000-000000000002', CURRENT_DATE + 4, 'mittagessen', 'Hähnchen mit Reis', 'Hähnchenbrust mit Gemüsereis', '{}', false);

-- 7 Tage Anwesenheit für Kita Regenbogen (ein paar Kinder)
INSERT INTO anwesenheit (kind_id, datum, ankunft_zeit, abgeholt_zeit, status, einrichtung_id) VALUES
  ('c0000000-0000-0000-0000-000000000001', CURRENT_DATE, '07:45', '16:00', 'anwesend', 'a0000000-0000-0000-0000-000000000002'),
  ('c0000000-0000-0000-0000-000000000002', CURRENT_DATE, '08:00', NULL, 'anwesend', 'a0000000-0000-0000-0000-000000000002'),
  ('c0000000-0000-0000-0000-000000000003', CURRENT_DATE, NULL, NULL, 'krank', 'a0000000-0000-0000-0000-000000000002'),
  ('c0000000-0000-0000-0000-000000000004', CURRENT_DATE, '08:30', NULL, 'anwesend', 'a0000000-0000-0000-0000-000000000002'),
  ('c0000000-0000-0000-0000-000000000005', CURRENT_DATE, '07:30', NULL, 'anwesend', 'a0000000-0000-0000-0000-000000000002'),
  ('c0000000-0000-0000-0000-000000000006', CURRENT_DATE, '08:15', NULL, 'anwesend', 'a0000000-0000-0000-0000-000000000002'),
  ('c0000000-0000-0000-0000-000000000007', CURRENT_DATE, NULL, NULL, 'entschuldigt', 'a0000000-0000-0000-0000-000000000002'),
  ('c0000000-0000-0000-0000-000000000011', CURRENT_DATE, '07:50', NULL, 'anwesend', 'a0000000-0000-0000-0000-000000000002'),
  ('c0000000-0000-0000-0000-000000000012', CURRENT_DATE, '08:10', NULL, 'anwesend', 'a0000000-0000-0000-0000-000000000002');

-- Nachrichten (keine Absender-IDs da Profile noch nicht existieren, daher übersprungen)
-- Nachrichten werden nach User-Erstellung via App eingefügt

-- Eingewöhnung-Daten (Mia Koch = stabilisierung, Anna Werner = grundphase)
INSERT INTO eingewoehnung (id, kind_id, startdatum, phase, notizen, erstellt_am) VALUES
  ('e0000000-0000-0000-0000-000000000001', 'c0000000-0000-0000-0000-000000000009', CURRENT_DATE - 14, 'stabilisierung', 'Mia zeigt gute Fortschritte. Erste Trennungen klappen gut.', NOW()),
  ('e0000000-0000-0000-0000-000000000002', 'c0000000-0000-0000-0000-000000000021', CURRENT_DATE - 5, 'grundphase', 'Anna ist noch sehr schüchtern. Braucht viel Nähe zur Bezugsperson.', NOW());

-- Tagesnotizen für Mia Koch (stabilisierung)
INSERT INTO eingewoehnung_tagesnotizen (eingewoehnung_id, datum, dauer_minuten, trennungsverhalten, essen, schlaf, stimmung, notizen_intern, notizen_eltern, erstellt_am) VALUES
  ('e0000000-0000-0000-0000-000000000001', CURRENT_DATE - 2, 180, 3, 'Hat gut gegessen, Mittagessen komplett aufgegessen.', 'Kurzer Mittagsschlaf (30 Min)', 'gut', 'Mia hat sich schnell beruhigt nach Abschied. Spielt gerne mit Bauklötzen.', 'Mia hat einen tollen Tag gehabt! Sie hat viel gespielt und gut gegessen.', NOW()),
  ('e0000000-0000-0000-0000-000000000001', CURRENT_DATE - 1, 240, 4, 'Frühstück und Mittagessen gut gegessen.', 'Guter Mittagsschlaf (45 Min)', 'sehr_gut', 'Erste längere Trennung (1h) ohne Weinen. Großer Fortschritt!', 'Mia macht tolle Fortschritte! Heute war sie 4 Stunden bei uns und war sehr fröhlich.', NOW()),
  ('e0000000-0000-0000-0000-000000000001', CURRENT_DATE, 120, 2, 'Wenig gegessen, nur Obst.', NULL, 'neutral', 'Heute etwas unruhig. Mama vermisst.', 'Mia war heute etwas ruhiger, aber das ist normal. Morgen wird es bestimmt wieder besser!', NOW());
