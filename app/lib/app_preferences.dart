import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Local-only presentation preferences. No account or health data is stored.
class AppPreferencesController extends ChangeNotifier {
  AppPreferencesController._({
    required String nickname,
    required int avatarIndex,
    required bool highContrast,
    required bool reduceMotion,
    required double textScale,
    SharedPreferencesAsync? storage,
  }) : this._values(
         nickname,
         avatarIndex,
         highContrast,
         reduceMotion,
         textScale,
         storage,
       );

  AppPreferencesController._values(
    this._nickname,
    this._avatarIndex,
    this._highContrast,
    this._reduceMotion,
    this._textScale,
    this._storage,
  );

  factory AppPreferencesController.memory() => AppPreferencesController._(
    nickname: '',
    avatarIndex: 0,
    highContrast: false,
    reduceMotion: false,
    textScale: 1,
  );

  static const _nicknameKey = 'profile.nickname';
  static const _avatarKey = 'profile.avatar';
  static const _contrastKey = 'accessibility.highContrast';
  static const _motionKey = 'accessibility.reduceMotion';
  static const _textScaleKey = 'accessibility.textScale';

  static Future<AppPreferencesController> load() async {
    final storage = SharedPreferencesAsync();
    return AppPreferencesController._(
      nickname: await storage.getString(_nicknameKey) ?? '',
      avatarIndex: await storage.getInt(_avatarKey) ?? 0,
      highContrast: await storage.getBool(_contrastKey) ?? false,
      reduceMotion: await storage.getBool(_motionKey) ?? false,
      textScale: await storage.getDouble(_textScaleKey) ?? 1,
      storage: storage,
    );
  }

  final SharedPreferencesAsync? _storage;
  String _nickname;
  int _avatarIndex;
  bool _highContrast;
  bool _reduceMotion;
  double _textScale;

  String get nickname => _nickname;
  String get displayName => _nickname.trim().isEmpty ? 'Mi espacio' : _nickname;
  int get avatarIndex => _avatarIndex;
  bool get highContrast => _highContrast;
  bool get reduceMotion => _reduceMotion;
  double get textScale => _textScale;

  Future<void> setNickname(String value) async {
    final normalized = value.trim();
    if (_nickname == normalized) return;
    _nickname = normalized;
    notifyListeners();
    if (normalized.isEmpty) {
      await _storage?.remove(_nicknameKey);
    } else {
      await _storage?.setString(_nicknameKey, normalized);
    }
  }

  Future<void> setAvatarIndex(int value) async {
    final normalized = value.clamp(0, 3).toInt();
    if (_avatarIndex == normalized) return;
    _avatarIndex = normalized;
    notifyListeners();
    await _storage?.setInt(_avatarKey, normalized);
  }

  Future<void> setHighContrast(bool value) async {
    if (_highContrast == value) return;
    _highContrast = value;
    notifyListeners();
    await _storage?.setBool(_contrastKey, value);
  }

  Future<void> setReduceMotion(bool value) async {
    if (_reduceMotion == value) return;
    _reduceMotion = value;
    notifyListeners();
    await _storage?.setBool(_motionKey, value);
  }

  Future<void> setTextScale(double value) async {
    final normalized = (value * 10).round().clamp(10, 16) / 10;
    if (_textScale == normalized) return;
    _textScale = normalized;
    notifyListeners();
    await _storage?.setDouble(_textScaleKey, normalized);
  }

  Future<void> clearProfile() async {
    _nickname = '';
    _avatarIndex = 0;
    notifyListeners();
    await _storage?.remove(_nicknameKey);
    await _storage?.remove(_avatarKey);
  }
}
