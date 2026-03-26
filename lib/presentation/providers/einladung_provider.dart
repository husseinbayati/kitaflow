import 'package:flutter/foundation.dart';
import '../../data/models/einladung.dart';
import '../../data/repositories/einladung_repository.dart';
import 'base_provider.dart';

class EinladungProvider extends BaseProvider {
  final EinladungRepository _einladungRepository;
  EinladungProvider(this._einladungRepository);

  Einladung? _validatedInvitation;
  bool _isRedeemed = false;

  Einladung? get validatedInvitation => _validatedInvitation;
  bool get isRedeemed => _isRedeemed;

  Future<bool> validateCode(String code) async {
    try {
      setLoading();
      _validatedInvitation = await _einladungRepository.validateCode(code);
      if (_validatedInvitation != null) {
        setSuccess();
        return true;
      } else {
        setError('Ungültiger oder abgelaufener Einladungscode.');
        return false;
      }
    } catch (e) {
      debugPrint('[EinladungProvider] validateCode Fehler: $e');
      setError('Einladungscode konnte nicht geprüft werden.');
      return false;
    }
  }

  Future<bool> redeemCode(String code, String userId) async {
    try {
      setLoading();
      await _einladungRepository.redeemCode(code, userId);
      _isRedeemed = true;
      setSuccess();
      return true;
    } catch (e) {
      debugPrint('[EinladungProvider] redeemCode Fehler: $e');
      setError('Einladungscode konnte nicht eingelöst werden.');
      return false;
    }
  }

  void clearInvitation() {
    _validatedInvitation = null;
    _isRedeemed = false;
    setIdle();
  }
}
