import 'package:flutter/material.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../data/models/kontaktperson.dart';
import '../../../core/extensions/l10n_extension.dart';

class KontaktpersonenListe extends StatelessWidget {
  final List<Kontaktperson> kontaktpersonen;

  const KontaktpersonenListe({super.key, required this.kontaktpersonen});

  @override
  Widget build(BuildContext context) {
    if (kontaktpersonen.isEmpty) {
      return Column(
        children: [
          AppGaps.v32,
          Center(child: Text(context.l.eltern_kindNoContacts)),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppGaps.v16,
        Text(
          context.l.eltern_kindContactsTitle,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        AppGaps.v12,
        ...kontaktpersonen.map((kp) => _buildKontaktCard(context, kp)),
      ],
    );
  }

  Widget _buildKontaktCard(BuildContext context, Kontaktperson kp) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: DesignTokens.spacing8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        side: BorderSide(color: Theme.of(context).dividerColor),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            kp.name.isNotEmpty ? kp.name[0].toUpperCase() : '?',
          ),
        ),
        title: Text(kp.name),
        subtitle: Text(kp.beziehung),
        trailing: kp.telefon != null
            ? IconButton(
                icon: const Icon(Icons.phone),
                onPressed: () {
                  // TODO: Phone call intent
                },
              )
            : null,
      ),
    );
  }
}
