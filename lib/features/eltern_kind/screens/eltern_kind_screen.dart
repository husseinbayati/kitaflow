import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../presentation/providers/eltern_home_provider.dart';
import '../../../presentation/providers/eltern_kind_provider.dart';
import '../widgets/kind_profil_header.dart';
import '../widgets/anwesenheit_kalender.dart';
import '../widgets/allergien_liste.dart';
import '../widgets/kontaktpersonen_liste.dart';
import '../../../core/extensions/l10n_extension.dart';

class ElternKindScreen extends StatefulWidget {
  final String? kindId;

  const ElternKindScreen({super.key, this.kindId});

  @override
  State<ElternKindScreen> createState() => _ElternKindScreenState();
}

class _ElternKindScreenState extends State<ElternKindScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  void _loadData() {
    // If kindId is provided, load that child's details
    // Otherwise, load the first child from elternHome
    final kindId = widget.kindId ??
        context.read<ElternHomeProvider>().meineKinder.firstOrNull?.id;
    if (kindId != null) {
      context.read<ElternKindProvider>().loadKindDetails(kindId);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<ElternKindProvider>(
          builder: (context, provider, _) {
            return Text(
                provider.selectedKind?.vollstaendigerName ?? context.l.eltern_kindTitle);
          },
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: context.l.eltern_kindTabProfile),
            Tab(text: context.l.eltern_kindTabAttendance),
            Tab(text: context.l.eltern_kindTabAllergies),
            Tab(text: context.l.eltern_kindTabContacts),
          ],
        ),
      ),
      body: Consumer<ElternKindProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.hasError) {
            return Center(child: Text(provider.errorMessage ?? context.l.common_error));
          }
          if (provider.selectedKind == null) {
            return Center(child: Text(context.l.eltern_kindNoChildSelected));
          }

          return TabBarView(
            controller: _tabController,
            children: [
              // Tab 1: Profil
              SingleChildScrollView(
                padding: AppPadding.screen,
                child: KindProfilHeader(kind: provider.selectedKind!),
              ),
              // Tab 2: Anwesenheit
              const SingleChildScrollView(
                padding: AppPadding.screen,
                child: AnwesenheitKalender(),
              ),
              // Tab 3: Allergien (read-only)
              SingleChildScrollView(
                padding: AppPadding.screen,
                child: AllergienListe(allergien: provider.allergien),
              ),
              // Tab 4: Kontakte
              SingleChildScrollView(
                padding: AppPadding.screen,
                child: KontaktpersonenListe(
                  kontaktpersonen: provider.kontaktpersonen,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
