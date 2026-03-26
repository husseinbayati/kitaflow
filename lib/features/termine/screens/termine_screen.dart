import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../core/constants/enums.dart';
import '../../../presentation/providers/auth_provider.dart';
import '../../../presentation/providers/termin_provider.dart';
import '../widgets/termin_card.dart';
import '../../../core/extensions/l10n_extension.dart';

/// Screen für Termine/Kalender.
/// Zeigt Termine in einer Liste mit optionalem Monatsfilter.
class TermineScreen extends StatefulWidget {
  const TermineScreen({super.key});

  @override
  State<TermineScreen> createState() => _TermineScreenState();
}

class _TermineScreenState extends State<TermineScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadData());
  }

  Future<void> _loadData() async {
    final auth = context.read<AuthProvider>();
    final userId = auth.user?.id;
    if (userId == null) return;

    // For parents, load via eltern method
    if (auth.currentRole == UserRole.eltern) {
      await context.read<TerminProvider>().loadTermineForEltern(userId);
    } else {
      final einrichtungId = auth.user?.einrichtungId;
      if (einrichtungId != null) {
        await context.read<TerminProvider>().loadTermine(einrichtungId);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l.termine_title),
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: Consumer<TerminProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (provider.hasError) {
              return Center(child: Text(provider.errorMessage ?? context.l.common_error));
            }
            if (provider.termine.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.calendar_month, size: DesignTokens.iconXl),
                    AppGaps.v12,
                    Text(context.l.termine_noAppointments),
                  ],
                ),
              );
            }

            // Group by date
            final termineByDate = provider.termineByDate;
            final sortedDates = termineByDate.keys.toList()..sort();

            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: AppPadding.screen,
              itemCount: sortedDates.length,
              itemBuilder: (context, index) {
                final date = sortedDates[index];
                final termine = termineByDate[date]!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date header
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: DesignTokens.spacing8),
                      child: Text(
                        _formatDateHeader(date),
                        style:
                            Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                      ),
                    ),
                    ...termine.map((termin) => Padding(
                          padding: const EdgeInsets.only(
                              bottom: DesignTokens.spacing8),
                          child: TerminCard(
                            termin: termin,
                            rueckmeldung:
                                provider.getRueckmeldungForTermin(termin.id),
                            onRsvp: (status) {
                              // RSVP handled inline in widget
                            },
                          ),
                        )),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  String _formatDateHeader(DateTime date) {
    final wochentage = [
      context.l.termine_weekdayMon,
      context.l.termine_weekdayTue,
      context.l.termine_weekdayWed,
      context.l.termine_weekdayThu,
      context.l.termine_weekdayFri,
      context.l.termine_weekdaySat,
      context.l.termine_weekdaySun,
    ];
    final wt = wochentage[date.weekday - 1];
    return '$wt, ${date.day}.${date.month}.${date.year}';
  }
}
