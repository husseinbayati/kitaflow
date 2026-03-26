import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../core/providers/locale_provider.dart';
import '../../../core/routing/route_constants.dart';
import '../../../data/models/push_einstellung.dart';
import '../../../presentation/providers/auth_provider.dart';
import '../../../presentation/providers/push_einstellung_provider.dart';
import '../../../core/extensions/l10n_extension.dart';

/// Push-Benachrichtigungen Einstellungen.
class PushEinstellungenScreen extends StatefulWidget {
  const PushEinstellungenScreen({super.key});

  @override
  State<PushEinstellungenScreen> createState() => _PushEinstellungenScreenState();
}

class _PushEinstellungenScreenState extends State<PushEinstellungenScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadData());
  }

  Future<void> _loadData() async {
    final userId = context.read<AuthProvider>().user?.id;
    if (userId == null) return;
    await context.read<PushEinstellungProvider>().loadEinstellungen(userId);
  }

  void _updateSetting(PushEinstellung current, {
    bool? nachrichten,
    bool? anwesenheit,
    bool? termine,
    bool? essensplan,
    bool? notfall,
    String? ruhezeitVon,
    String? ruhezeitBis,
  }) {
    final updated = current.copyWith(
      nachrichten: nachrichten,
      anwesenheit: anwesenheit,
      termine: termine,
      essensplan: essensplan,
      notfall: notfall,
      ruhezeitVon: ruhezeitVon,
      ruhezeitBis: ruhezeitBis,
    );
    context.read<PushEinstellungProvider>().updateEinstellung(updated);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l.push_title)),
      body: Consumer<PushEinstellungProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Use existing settings or create defaults
          final einstellungen = provider.einstellungen ?? PushEinstellung(
            id: '',
            userId: context.read<AuthProvider>().user?.id ?? '',
            nachrichten: true,
            anwesenheit: true,
            termine: true,
            essensplan: false,
            notfall: true,
            erstelltAm: DateTime.now(),
            aktualisiertAm: DateTime.now(),
          );

          return ListView(
            padding: AppPadding.screen,
            children: [
              // Section: Benachrichtigungen
              Text(
                context.l.push_sectionNotifications,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              AppGaps.v8,
              SwitchListTile(
                title: Text(context.l.push_messages),
                subtitle: Text(context.l.push_messagesDescription),
                value: einstellungen.nachrichten,
                onChanged: (v) => _updateSetting(einstellungen, nachrichten: v),
              ),
              SwitchListTile(
                title: Text(context.l.push_attendance),
                subtitle: Text(context.l.push_attendanceDescription),
                value: einstellungen.anwesenheit,
                onChanged: (v) => _updateSetting(einstellungen, anwesenheit: v),
              ),
              SwitchListTile(
                title: Text(context.l.push_appointments),
                subtitle: Text(context.l.push_appointmentsDescription),
                value: einstellungen.termine,
                onChanged: (v) => _updateSetting(einstellungen, termine: v),
              ),
              SwitchListTile(
                title: Text(context.l.push_mealPlan),
                subtitle: Text(context.l.push_mealPlanDescription),
                value: einstellungen.essensplan,
                onChanged: (v) => _updateSetting(einstellungen, essensplan: v),
              ),
              SwitchListTile(
                title: Text(context.l.push_emergency),
                subtitle: Text(context.l.push_emergencyDescription),
                value: einstellungen.notfall,
                onChanged: (v) => _updateSetting(einstellungen, notfall: v),
              ),

              AppGaps.v24,

              // Section: Ruhezeiten
              Text(
                context.l.push_sectionQuietHours,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              AppGaps.v4,
              Text(
                context.l.push_quietHoursDescription,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              AppGaps.v12,
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(context.l.push_quietHoursFrom),
                      subtitle: Text(einstellungen.ruhezeitVon ?? '22:00'),
                      onTap: () async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: _parseTime(einstellungen.ruhezeitVon ?? '22:00'),
                        );
                        if (time != null) {
                          _updateSetting(einstellungen,
                            ruhezeitVon: '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
                          );
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(context.l.push_quietHoursTo),
                      subtitle: Text(einstellungen.ruhezeitBis ?? '07:00'),
                      onTap: () async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: _parseTime(einstellungen.ruhezeitBis ?? '07:00'),
                        );
                        if (time != null) {
                          _updateSetting(einstellungen,
                            ruhezeitBis: '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),

              AppGaps.v24,

              // Section: Sprache
              Text(
                context.l.common_language,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              AppGaps.v8,
              Consumer<LocaleProvider>(
                builder: (_, localeProvider, __) {
                  const names = {
                    'de': 'Deutsch',
                    'ar': 'العربية',
                    'tr': 'Türkçe',
                    'uk': 'Українська',
                    'en': 'English',
                  };
                  return ListTile(
                    leading: const Icon(Icons.language),
                    title: Text(names[localeProvider.locale.languageCode] ?? localeProvider.locale.languageCode),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push(AppRoutes.sprache),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  TimeOfDay _parseTime(String time) {
    final parts = time.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }
}
