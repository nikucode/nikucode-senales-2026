import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Local-only presentation preferences. No account or health data is stored.
class AppPreferencesController extends ChangeNotifier {
  AppPreferencesController._({
    required String nickname,
    required int avatarIndex,
    required bool highContrast,
    required bool reduceMotion,
    SharedPreferencesAsync? storage,
  }) : this._values(nickname, avatarIndex, highContrast, reduceMotion, storage);

  AppPreferencesController._values(
    this._nickname,
    this._avatarIndex,
    this._highContrast,
    this._reduceMotion,
    this._storage,
  );

  factory AppPreferencesController.memory() => AppPreferencesController._(
    nickname: '',
    avatarIndex: 0,
    highContrast: false,
    reduceMotion: false,
  );

  static const _nicknameKey = 'profile.nickname';
  static const _avatarKey = 'profile.avatar';
  static const _contrastKey = 'accessibility.highContrast';
  static const _motionKey = 'accessibility.reduceMotion';

  static Future<AppPreferencesController> load() async {
    final storage = SharedPreferencesAsync();
    return AppPreferencesController._(
      nickname: await storage.getString(_nicknameKey) ?? '',
      avatarIndex: await storage.getInt(_avatarKey) ?? 0,
      highContrast: await storage.getBool(_contrastKey) ?? false,
      reduceMotion: await storage.getBool(_motionKey) ?? false,
      storage: storage,
    );
  }

  final SharedPreferencesAsync? _storage;
  String _nickname;
  int _avatarIndex;
  bool _highContrast;
  bool _reduceMotion;

  String get nickname => _nickname;
  String get displayName => _nickname.trim().isEmpty ? 'Mi espacio' : _nickname;
  int get avatarIndex => _avatarIndex;
  bool get highContrast => _highContrast;
  bool get reduceMotion => _reduceMotion;

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

  Future<void> clearProfile() async {
    _nickname = '';
    _avatarIndex = 0;
    notifyListeners();
    await _storage?.remove(_nicknameKey);
    await _storage?.remove(_avatarKey);
  }
}
