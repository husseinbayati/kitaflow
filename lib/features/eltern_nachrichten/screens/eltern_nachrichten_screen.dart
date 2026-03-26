import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/kf_empty_state.dart';
import '../../../core/widgets/kf_loading.dart';
import '../../../presentation/providers/auth_provider.dart';
import '../../../presentation/providers/nachricht_provider.dart';
import '../../nachrichten/widgets/nachricht_list_item.dart';
import '../../../core/extensions/l10n_extension.dart';

/// Nachrichten-Screen für Eltern.
/// Zeigt nur Nachrichten an, die an den Elternteil gesendet wurden.
class ElternNachrichtenScreen extends StatefulWidget {
  const ElternNachrichtenScreen({super.key});

  @override
  State<ElternNachrichtenScreen> createState() =>
      _ElternNachrichtenScreenState();
}

class _ElternNachrichtenScreenState extends State<ElternNachrichtenScreen> {
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

  Future<void> _loadData() async {
    final einrichtungId = _einrichtungId;
    if (einrichtungId == null) return;
    await context.read<NachrichtProvider>().loadNachrichten(einrichtungId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l.eltern_nachrichtenTitle),
      ),
      body: Consumer<NachrichtProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return KfLoading(message: context.l.eltern_nachrichtenLoading);
          }

          if (provider.hasError) {
            return Center(
              child: Text(
                provider.errorMessage ?? context.l.common_error,
                style: const TextStyle(
                  fontSize: DesignTokens.fontMd,
                  color: AppColors.error,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }

          final nachrichten = provider.empfangene;

          return RefreshIndicator(
            onRefresh: _loadData,
            child: nachrichten.isEmpty
                ? ListView(
                    children: [
                      KfEmptyState(
                        icon: Icons.mail_outline,
                        title: context.l.eltern_nachrichtenEmpty,
                        subtitle:
                            context.l.eltern_nachrichtenEmptyDescription,
                      ),
                    ],
                  )
                : ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: nachrichten.length,
                    separatorBuilder: (_, __) => const Divider(
                      height: 1,
                      color: AppColors.divider,
                    ),
                    itemBuilder: (context, index) {
                      final nachricht = nachrichten[index];
                      return NachrichtListItem(
                        nachricht: nachricht,
                        onTap: () => context
                            .push('/nachrichten/${nachricht.id}'),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}
