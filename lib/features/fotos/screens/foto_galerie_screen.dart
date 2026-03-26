import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../presentation/providers/auth_provider.dart';
import '../../../presentation/providers/foto_provider.dart';
import '../widgets/foto_tile.dart';
import 'foto_viewer_screen.dart';
import '../../../core/extensions/l10n_extension.dart';

/// Foto-Galerie für Eltern.
/// Zeigt nur freigegebene Fotos (sichtbar_fuer_eltern = true).
class FotoGalerieScreen extends StatefulWidget {
  const FotoGalerieScreen({super.key});

  @override
  State<FotoGalerieScreen> createState() => _FotoGalerieScreenState();
}

class _FotoGalerieScreenState extends State<FotoGalerieScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadData());
  }

  Future<void> _loadData() async {
    final auth = context.read<AuthProvider>();
    final userId = auth.user?.id;
    if (userId == null) return;
    await context.read<FotoProvider>().loadFotosForEltern(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l.fotos_title)),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: Consumer<FotoProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (provider.hasError) {
              return Center(child: Text(provider.errorMessage ?? context.l.common_error));
            }
            if (provider.fotos.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.photo_library_outlined, size: DesignTokens.iconXl),
                    AppGaps.v12,
                    Text(context.l.fotos_noPhotos),
                  ],
                ),
              );
            }

            return GridView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: AppPadding.screen,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: DesignTokens.spacing4,
                mainAxisSpacing: DesignTokens.spacing4,
              ),
              itemCount: provider.fotos.length,
              itemBuilder: (context, index) {
                final foto = provider.fotos[index];
                return FotoTile(
                  foto: foto,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => FotoViewerScreen(foto: foto),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
