import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../core/constants/enums.dart';
import '../../../core/widgets/kf_input.dart';
import '../../../presentation/providers/auth_provider.dart';
import '../../../presentation/providers/gruppe_provider.dart';
import '../../../core/extensions/l10n_extension.dart';
import '../../../core/constants/enum_labels.dart';

class MitarbeiterFormScreen extends StatefulWidget {
  const MitarbeiterFormScreen({super.key});
  @override
  State<MitarbeiterFormScreen> createState() => _MitarbeiterFormScreenState();
}

class _MitarbeiterFormScreenState extends State<MitarbeiterFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  String _selectedRolle = 'erzieher';
  String? _selectedGruppeId;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final einrichtungId =
        context.read<AuthProvider>().user?.einrichtungId ?? '';

    // For MVP: create mitarbeiter_einrichtung entry
    // In a full implementation, would first look up profile by email
    // For MVP: create mitarbeiter_einrichtung entry
    // In a full implementation, would first look up profile by email
    // and create MitarbeiterEinrichtung with the resolved profile ID
    final _ = (einrichtungId, _selectedRolle, _selectedGruppeId);

    // Note: For a complete implementation, the repository would need to:
    // 1. Look up profile by email
    // 2. Create mitarbeiter_einrichtung with that profile's ID
    // For now, show a message that email-based lookup is coming
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            context.l.verwaltung_staffFormInvitePending,
          ),
        ),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l.verwaltung_staffFormTitle)),
      body: SingleChildScrollView(
        padding: AppPadding.screen,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              KfTextField(
                label: context.l.verwaltung_staffFormEmail,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icons.email,
                validator: (v) {
                  if (v == null || v.isEmpty) return context.l.verwaltung_staffFormEmailRequired;
                  if (!v.contains('@')) return context.l.verwaltung_staffFormEmailInvalid;
                  return null;
                },
              ),
              AppGaps.v16,
              DropdownButtonFormField<String>(
                value: _selectedRolle,
                decoration: InputDecoration(labelText: context.l.verwaltung_staffFormRole),
                items: [UserRole.erzieher, UserRole.lehrer, UserRole.leitung]
                    .map((role) {
                  return DropdownMenuItem(
                    value: role.name,
                    child: Text(role.label(context)),
                  );
                }).toList(),
                onChanged: (v) => setState(() => _selectedRolle = v!),
              ),
              AppGaps.v16,
              Consumer<GruppeProvider>(
                builder: (context, gruppeProvider, _) {
                  return DropdownButtonFormField<String?>(
                    value: _selectedGruppeId,
                    decoration: InputDecoration(
                      labelText: context.l.verwaltung_staffFormGroup,
                    ),
                    items: [
                      DropdownMenuItem<String?>(
                        value: null,
                        child: Text(context.l.verwaltung_staffFormNoGroup),
                      ),
                      ...gruppeProvider.gruppen.map((g) {
                        return DropdownMenuItem<String?>(
                          value: g.id,
                          child: Text(g.name),
                        );
                      }),
                    ],
                    onChanged: (v) =>
                        setState(() => _selectedGruppeId = v),
                  );
                },
              ),
              AppGaps.v24,
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _save,
                  child: Text(context.l.verwaltung_staffFormAdd),
                ),
              ),
              AppGaps.v32,
            ],
          ),
        ),
      ),
    );
  }
}
