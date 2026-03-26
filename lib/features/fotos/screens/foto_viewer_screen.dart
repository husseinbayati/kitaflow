import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/foto.dart';
import '../../../presentation/providers/foto_provider.dart';
import '../../../core/extensions/l10n_extension.dart';

/// Fullscreen Foto-Viewer.
/// DSGVO: Kein Download, kein Teilen möglich.
class FotoViewerScreen extends StatefulWidget {
  final Foto foto;

  const FotoViewerScreen({super.key, required this.foto});

  @override
  State<FotoViewerScreen> createState() => _FotoViewerScreenState();
}

class _FotoViewerScreenState extends State<FotoViewerScreen> {
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
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          widget.foto.beschreibung ?? context.l.fotos_viewerTitle,
          style: const TextStyle(color: Colors.white),
        ),
        // DSGVO: No share/download actions!
      ),
      body: Center(
        child: _loading
            ? const CircularProgressIndicator(color: Colors.white)
            : _imageUrl != null
                ? InteractiveViewer(
                    child: Image.network(
                      _imageUrl!,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.broken_image,
                        color: Colors.white,
                        size: 64,
                      ),
                    ),
                  )
                : const Icon(Icons.photo, color: Colors.white54, size: 64),
      ),
    );
  }
}
