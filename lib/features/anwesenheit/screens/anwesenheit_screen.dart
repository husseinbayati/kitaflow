import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/kf_empty_state.dart';
import '../../../core/widgets/kf_loading.dart';
import '../../../data/models/anwesenheit_heute.dart';
import '../../../presentation/providers/anwesenheit_provider.dart';
import '../../../presentation/providers/auth_provider.dart';
import '../../../presentation/providers/kind_provider.dart';
import '../widgets/anwesenheit_kind_card.dart';
import '../widgets/anwesenheit_statistik_bar.dart';
import '../widgets/status_auswahl_dialog.dart';

/// Hauptscreen für die tägliche Anwesenheitsverwaltung.
///
/// Zeigt Statistik-Leiste, Gruppen-Filter, "Alle anwesend"-Button
/// und eine scrollbare Liste aller Kinder mit Tap/LongPress-Aktionen.
class AnwesenheitScreen extends StatefulWidget {
  const AnwesenheitScreen({super.key});

  @override
  State<AnwesenheitScreen> createState() => _AnwesenheitScreenState();
}

class _AnwesenheitScreenState extends State<AnwesenheitScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  String? get _einrichtungId {
    return context.read<AuthProvider>().user?.einrichtungId;
  }

  void _loadData() {
    final einrichtungId = _einrichtungId;
    if (einrichtungId != null) {
      context.read<AnwesenheitProvider>().loadHeute(einrichtungId);

      // Gruppen laden, falls noch nicht vorhanden
      final kindProvider = context.read<KindProvider>();
      if (kindProvider.gruppen.isEmpty) {
        kindProvider.loadKinder(einrichtungId);
      }
    }
  }

  /// Tap: Check-In (nicht erfasst) → Check-Out (anwesend) → Snackbar (abgeholt).
  void _onKindTap(AnwesenheitHeute eintrag) {
    final einrichtungId = _einrichtungId;
    if (einrichtungId == null) return;

    final provider = context.read<AnwesenheitProvider>();

    if (!eintrag.istErfasst) {
      // Noch nicht erfasst → Check-In
      provider.checkIn(eintrag.kindId, einrichtungId);
    } else if (eintrag.istAnwesend) {
      // Anwesend und noch nicht abgeholt → Check-Out
      provider.checkOut(eintrag.id!);
    } else {
      // Bereits abgeholt oder anderer Status
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l.anwesenheit_alreadyPickedUp),
        ),
      );
    }
  }

  /// LongPress: Status-Auswahl-Dialog öffnen.
  void _onKindLongPress(AnwesenheitHeute eintrag) async {
    final einrichtungId = _einrichtungId;
    if (einrichtungId == null) return;

    final result = await StatusAuswahlDialog.show(
      context,
      currentStatus: eintrag.status,
    );

    if (result == null || !mounted) return;

    final provider = context.read<AnwesenheitProvider>();

    if (eintrag.istErfasst && eintrag.id != null) {
      // Bestehenden Eintrag aktualisieren
      provider.updateStatus(eintrag.id!, result.status, notiz: result.notiz);
    } else {
      // Neuer Abwesenheits-Eintrag
      provider.markAbwesend(eintrag.kindId, einrichtungId, result.status, notiz: result.notiz);
    }
  }

  /// Alle nicht-erfassten Kinder als anwesend markieren.
  Future<void> _alleAnwesend() async {
    final einrichtungId = _einrichtungId;
    if (einrichtungId == null) return;

    final provider = context.read<AnwesenheitProvider>();
    final nichtErfasst = provider.heuteEintraege
        .where((e) => !e.istErfasst)
        .toList();

    if (nichtErfasst.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l.anwesenheit_allRecorded)),
        );
      }
      return;
    }

    await Future.wait(
      nichtErfasst.map((e) => provider.checkIn(e.kindId, einrichtungId)),
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l.anwesenheit_markedPresent(nichtErfasst.length)),
        ),
      );
    }
  }

  /// Formatiert das Datum im deutschen Format (z.B. "Mi, 26.03.2026").
  String _formatDatum(DateTime datum) {
    return DateFormat('EE, dd.MM.yyyy', 'de_DE').format(datum);
  }

  /// Öffnet den DatePicker und lädt Anwesenheit für das gewählte Datum.
  Future<void> _datumAuswaehlen() async {
    final provider = context.read<AnwesenheitProvider>();
    final einrichtungId = _einrichtungId;
    if (einrichtungId == null) return;

    final gewaehlt = await showDatePicker(
      context: context,
      initialDate: provider.selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
      locale: const Locale('de', 'DE'),
    );

    if (gewaehlt != null && mounted) {
      provider.loadByDate(einrichtungId, gewaehlt);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l.anwesenheit_title),
        actions: [
          Consumer<AnwesenheitProvider>(
            builder: (context, provider, _) {
              return TextButton(
                onPressed: _datumAuswaehlen,
                child: Text(
                  _formatDatum(provider.selectedDate),
                  style: const TextStyle(
                    fontSize: DesignTokens.fontSm,
                    color: AppColors.textOnPrimary,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<AnwesenheitProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const KfShimmerList();
          }

          if (provider.hasError) {
            return Center(
              child: Text(
                provider.errorMessage ?? context.l.kinder_errorOccurred,
                style: const TextStyle(
                  fontSize: DesignTokens.fontMd,
                  color: AppColors.error,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }

          final eintraege = provider.filteredEintraege;

          return Column(
            children: [
              // Statistik-Leiste
              AnwesenheitStatistikBar(
                anwesend: provider.anwesendCount,
                abwesend: provider.abwesendCount,
                krank: provider.krankCount,
                gesamt: provider.gesamtCount,
              ),

              // Gruppen-Filter-Chips
              Consumer<KindProvider>(
                builder: (context, kindProvider, _) {
                  final gruppen = kindProvider.gruppen;

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: DesignTokens.spacing16,
                      vertical: DesignTokens.spacing8,
                    ),
                    child: Row(
                      children: [
                        // "Alle" Chip
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                            end: DesignTokens.spacing8,
                          ),
                          child: FilterChip(
                            label: Text(context.l.anwesenheit_all),
                            selected: provider.filterGruppeId == null,
                            onSelected: (_) {
                              provider.setFilterGruppe(null);
                            },
                            selectedColor: AppColors.primaryLight,
                            checkmarkColor: AppColors.primaryDark,
                          ),
                        ),
                        // Gruppen-Chips
                        ...gruppen.map(
                          (gruppe) => Padding(
                            padding: const EdgeInsetsDirectional.only(
                              end: DesignTokens.spacing8,
                            ),
                            child: FilterChip(
                              label: Text(gruppe.name),
                              selected:
                                  provider.filterGruppeId == gruppe.id,
                              onSelected: (selected) {
                                provider.setFilterGruppe(
                                  selected ? gruppe.id : null,
                                );
                              },
                              selectedColor: AppColors.primaryLight,
                              checkmarkColor: AppColors.primaryDark,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              // "Alle anwesend" Button
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: DesignTokens.spacing16,
                  vertical: DesignTokens.spacing4,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    icon: Icon(Icons.done_all, color: AppColors.success),
                    label: Text(context.l.anwesenheit_markAllPresent),
                    onPressed: _alleAnwesend,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.success,
                      side: BorderSide(color: AppColors.success),
                    ),
                  ),
                ),
              ),

              // Kinderliste
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    final einrichtungId = _einrichtungId;
                    if (einrichtungId != null) {
                      await provider.loadHeute(einrichtungId);
                    }
                  },
                  child: eintraege.isEmpty
                      ? ListView(
                          // ListView nötig damit RefreshIndicator funktioniert
                          children: [
                            KfEmptyState(
                              title: context.l.kinder_notFound,
                              icon: Icons.child_care,
                              subtitle: context.l.kinder_notFoundDescription,
                            ),
                          ],
                        )
                      : ListView.separated(
                          itemCount: eintraege.length,
                          separatorBuilder: (_, __) => const Divider(
                            height: 1,
                            color: AppColors.divider,
                          ),
                          itemBuilder: (context, index) {
                            final eintrag = eintraege[index];
                            return AnwesenheitKindCard(
                              eintrag: eintrag,
                              onTap: () => _onKindTap(eintrag),
                              onLongPress: () => _onKindLongPress(eintrag),
                            );
                          },
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
