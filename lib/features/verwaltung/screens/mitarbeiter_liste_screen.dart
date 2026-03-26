import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../core/routing/route_constants.dart';
import '../../../core/constants/enums.dart';
import '../../../presentation/providers/auth_provider.dart';
import '../../../presentation/providers/mitarbeiter_provider.dart';
import '../../../presentation/providers/gruppe_provider.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/constants/enum_labels.dart';

class MitarbeiterListeScreen extends StatefulWidget {
  const MitarbeiterListeScreen({super.key});
  @override
  State<MitarbeiterListeScreen> createState() => _MitarbeiterListeScreenState();
}

class _MitarbeiterListeScreenState extends State<MitarbeiterListeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadData());
  }

  Future<void> _loadData() async {
    final einrichtungId = context.read<AuthProvider>().user?.einrichtungId;
    if (einrichtungId == null) return;
    await context.read<MitarbeiterProvider>().loadMitarbeiter(einrichtungId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l.verwaltung_staffListTitle)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go(AppRoutes.verwaltungMitarbeiterNeu),
        child: const Icon(Icons.person_add),
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: Consumer<MitarbeiterProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (provider.hasError) {
              return Center(
                child: Text(provider.errorMessage ?? context.l.common_error),
              );
            }
            if (provider.mitarbeiter.isEmpty) {
              return Center(
                child: Text(context.l.verwaltung_staffEmpty),
              );
            }

            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: AppPadding.screen,
              itemCount: provider.mitarbeiter.length,
              itemBuilder: (context, index) {
                final me = provider.mitarbeiter[index];
                final profile =
                    me['profiles'] as Map<String, dynamic>? ?? {};
                final vorname = profile['vorname'] as String? ?? '';
                final nachname = profile['nachname'] as String? ?? '';
                final rolle = profile['rolle'] as String? ?? '';
                final avatarUrl = profile['avatar_url'] as String?;
                final gruppeId = me['gruppe_id'] as String?;
                final initialen =
                    '${vorname.isNotEmpty ? vorname[0] : ''}${nachname.isNotEmpty ? nachname[0] : ''}'
                        .toUpperCase();

                // Find group name
                final gruppen = context.read<GruppeProvider>().gruppen;
                final gruppeName = gruppeId != null
                    ? gruppen
                        .where((g) => g.id == gruppeId)
                        .firstOrNull
                        ?.name
                    : null;

                // Role display
                final rolleEnum = UserRole.values
                    .where((r) => r.name == rolle)
                    .firstOrNull;
                final rolleDisplay = rolleEnum?.label(context) ?? rolle;

                return Card(
                  elevation: 0,
                  margin:
                      const EdgeInsets.only(bottom: DesignTokens.spacing8),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(DesignTokens.radiusMd),
                    side:
                        BorderSide(color: Theme.of(context).dividerColor),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: avatarUrl != null
                          ? NetworkImage(avatarUrl)
                          : null,
                      child:
                          avatarUrl == null ? Text(initialen) : null,
                    ),
                    title: Text('$vorname $nachname'),
                    subtitle: Text(
                      gruppeName != null
                          ? '$rolleDisplay · $gruppeName'
                          : rolleDisplay,
                    ),
                    trailing: PopupMenuButton<String>(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'rolle',
                          child: Text(context.l.verwaltung_staffChangeRole),
                        ),
                        PopupMenuItem(
                          value: 'gruppe',
                          child: Text(context.l.verwaltung_staffAssignGroup),
                        ),
                        PopupMenuItem(
                          value: 'entfernen',
                          child: Text(context.l.verwaltung_staffRemove),
                        ),
                      ],
                      onSelected: (action) =>
                          _handleAction(action, me),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _handleAction(String action, Map<String, dynamic> me) {
    final meId = me['id'] as String;
    final profile = me['profiles'] as Map<String, dynamic>? ?? {};
    final mitarbeiterId =
        me['mitarbeiter_id'] as String? ?? profile['id'] as String? ?? '';

    switch (action) {
      case 'rolle':
        _showRolleDialog(
            mitarbeiterId, profile['rolle'] as String? ?? '');
      case 'gruppe':
        _showGruppeDialog(meId, me['gruppe_id'] as String?);
      case 'entfernen':
        _showEntfernenDialog(
            meId, '${profile['vorname']} ${profile['nachname']}');
    }
  }

  void _showRolleDialog(String mitarbeiterId, String currentRolle) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l.verwaltung_staffChangeRole),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['erzieher', 'lehrer', 'leitung'].map((rolle) {
            final rolleEnum =
                UserRole.values.firstWhere((r) => r.name == rolle);
            return RadioListTile<String>(
              value: rolle,
              groupValue: currentRolle,
              title: Text(rolleEnum.label(context)),
              onChanged: (v) {
                Navigator.pop(context);
                if (v != null) {
                  this
                      .context
                      .read<MitarbeiterProvider>()
                      .updateRolle(mitarbeiterId, v);
                }
              },
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(this.context.l.common_cancel),
          ),
        ],
      ),
    );
  }

  void _showGruppeDialog(String meId, String? currentGruppeId) {
    final gruppen = context.read<GruppeProvider>().gruppen;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(this.context.l.verwaltung_staffAssignGroup),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String?>(
              value: null,
              groupValue: currentGruppeId,
              title: Text(this.context.l.verwaltung_staffNoGroup),
              onChanged: (v) {
                Navigator.pop(context);
                this
                    .context
                    .read<MitarbeiterProvider>()
                    .assignGruppe(meId, null);
              },
            ),
            ...gruppen.map((g) => RadioListTile<String?>(
                  value: g.id,
                  groupValue: currentGruppeId,
                  title: Text(g.name),
                  onChanged: (v) {
                    Navigator.pop(context);
                    this
                        .context
                        .read<MitarbeiterProvider>()
                        .assignGruppe(meId, v);
                  },
                )),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(this.context.l.common_cancel),
          ),
        ],
      ),
    );
  }

  void _showEntfernenDialog(String meId, String name) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(this.context.l.verwaltung_staffRemoveTitle),
        content: Text(this.context.l.verwaltung_staffRemoveConfirm(name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(this.context.l.common_cancel),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              this
                  .context
                  .read<MitarbeiterProvider>()
                  .removeMitarbeiter(meId);
            },
            child: Text(this.context.l.common_remove),
          ),
        ],
      ),
    );
  }
}
