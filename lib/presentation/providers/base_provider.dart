import 'package:flutter/foundation.dart';

/// Basis-State für alle Provider.
enum ViewState { idle, loading, success, error }

/// BaseProvider mit ViewState-Management.
/// Alle Feature-Provider erben von dieser Klasse.
class BaseProvider extends ChangeNotifier {
  ViewState _viewState = ViewState.idle;
  String? _errorMessage;
  bool _disposed = false;

  ViewState get viewState => _viewState;
  String? get errorMessage => _errorMessage;

  bool get isIdle => _viewState == ViewState.idle;
  bool get isLoading => _viewState == ViewState.loading;
  bool get isSuccess => _viewState == ViewState.success;
  bool get hasError => _viewState == ViewState.error;

  @protected
  void setLoading() {
    if (_viewState != ViewState.loading) {
      _viewState = ViewState.loading;
      _errorMessage = null;
      notifySafely();
    }
  }

  @protected
  void setSuccess() {
    if (_viewState != ViewState.success) {
      _viewState = ViewState.success;
      _errorMessage = null;
      notifySafely();
    }
  }

  @protected
  void setError(String message) {
    _viewState = ViewState.error;
    _errorMessage = message;
    notifySafely();
  }

  @protected
  void setIdle() {
    if (_viewState != ViewState.idle) {
      _viewState = ViewState.idle;
      _errorMessage = null;
      notifySafely();
    }
  }

  @protected
  void notifySafely() {
    if (!_disposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
