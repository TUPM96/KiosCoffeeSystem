import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'constants/preferences.dart';

class SharedPreferenceHelper {
  // shared pref instance
  final SharedPreferences _sharedPreference;

  // constructor
  SharedPreferenceHelper(this._sharedPreference);

  // General Methods: ----------------------------------------------------------
  Future<String?> get authToken async {
    return _sharedPreference.getString(Preferences.auth_token);
  }

  Future<bool> saveAuthToken(String authToken) async {
    return _sharedPreference.setString(Preferences.auth_token, authToken);
  }

  Future<bool> removeAuthToken() async {
    return _sharedPreference.remove(Preferences.auth_token);
  }

  // Login:---------------------------------------------------------------------
  Future<bool> get isLoggedIn async {
    return _sharedPreference.getBool(Preferences.is_logged_in) ?? false;
  }

  Future<bool> saveIsLoggedIn(bool value) async {
    return _sharedPreference.setBool(Preferences.is_logged_in, value);
  }

  Future<bool> saveProfile(String value) async {
    return _sharedPreference.setString(Preferences.profile, value);
  }

  Future<String> getProfile() async {
    try {
      final str = _sharedPreference.getString(Preferences.profile);
      return str!;
    } catch (e) {
      return '';
    }
  }

  Future<bool> saveEmail(String email) async {
    return _sharedPreference.setString(Preferences.email, email);
  }

  Future<String> getEmail() async {
    try {
      final str = _sharedPreference.getString(Preferences.email);
      return str!;
    } catch (e) {
      return '';
    }
  }

  Future<String> getPassword() async {
    try {
      final str = _sharedPreference.getString(Preferences.password);
      return str!;
    } catch (e) {
      return '';
    }
  }

  Future<bool> removeEmail() async {
    return _sharedPreference.remove(Preferences.email);
  }

  Future<bool> savePassword(String password) async {
    return _sharedPreference.setString(Preferences.password, password);
  }

  Future<bool> removePassword() async {
    return _sharedPreference.remove(Preferences.password);
  }

  // Theme:------------------------------------------------------
  bool get isDarkMode {
    return _sharedPreference.getBool(Preferences.is_dark_mode) ?? false;
  }

  Future<void> changeBrightnessToDark(bool value) {
    return _sharedPreference.setBool(Preferences.is_dark_mode, value);
  }

  // Language:---------------------------------------------------
  String? get currentLanguage {
    return _sharedPreference.getString(Preferences.current_language);
  }

  Future<void> changeLanguage(String language) {
    return _sharedPreference.setString(Preferences.current_language, language);
  }
}
