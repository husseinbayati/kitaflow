import 'package:flutter/foundation.dart';
import '../../data/models/foto.dart';
import '../../data/repositories/foto_repository.dart';
import 'base_provider.dart';

class FotoProvider extends BaseProvider {
  final FotoRepository _fotoRepository;
  FotoProvider(this._fotoRepository);

  List<Foto> _fotos = [];

  List<Foto> get fotos => _fotos;

  Future<void> loadFotos(String einrichtungId) async {
    try {
      setLoading();
      _fotos = await _fotoRepository.fetchFotosByEinrichtung(einrichtungId);
      setSuccess();
    } catch (e) {
      debugPrint('[FotoProvider] loadFotos Fehler: $e');
      setError('Fotos konnten nicht geladen werden.');
    }
  }

  Future<void> loadFotosForEltern(String elternId) async {
    try {
      setLoading();
      _fotos = await _fotoRepository.fetchFotosForEltern(elternId);
      setSuccess();
    } catch (e) {
      debugPrint('[FotoProvider] loadFotosForEltern Fehler: $e');
      setError('Fotos konnten nicht geladen werden.');
    }
  }

  Future<String> getSignedUrl(String storagePfad) async {
    return _fotoRepository.getSignedUrl(storagePfad);
  }
}
