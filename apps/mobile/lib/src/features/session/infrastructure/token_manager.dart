class TokenManager {
  String? _accessToken;
  DateTime? _expiresAt;

  /// Retrieves the active token. Returns null if missing or expired.
  String? get activeToken {
    if (_accessToken == null || _expiresAt == null) return null;
    if (DateTime.now().toUtc().isAfter(_expiresAt!)) return null;
    return _accessToken;
  }

  /// Sets the token into memory.
  void setToken(String token, DateTime expiryUtc) {
    _accessToken = token;
    _expiresAt = expiryUtc;
  }

  /// Flushes the token completely from memory (e.g. on logout or suspension)
  void flush() {
    _accessToken = null;
    _expiresAt = null;
  }
}
