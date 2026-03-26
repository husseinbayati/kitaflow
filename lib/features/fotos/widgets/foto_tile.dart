import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/design_tokens.dart';
import '../../../data/models/foto.dart';
import '../../../presentation/providers/foto_provider.dart';

/// Einzelnes Foto-Tile in der Galerie-Ansicht.
class FotoTile extends StatefulWidget {
  final Foto foto;
  final VoidCallback? onTap;

  const FotoTile({super.key, required this.foto, this.onTap});

  @override
  State<FotoTile> createState() => _FotoTileState();
}

class _FotoTileState extends State<FotoTile> {
  String? _imageUrl;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadUrl();
  }

  Future<void> _loadUrl() async {
    try {
      final url = await context.read<FotoProvider>().getSignedUrl(widget.foto.storagePfad);
      if (mounted) {
        setState(() {
          _imageUrl = url;
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
        child: _loading
            ? Container(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
              )
            : _imageUrl != null
                ? Image.network(
                    _imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      child: const Icon(Icons.broken_image),
                    ),
                  )
                : Container(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    child: const Icon(Icons.photo),
                  ),
      ),
    );
  }
}
