import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../../app/global.dart' as global;

enum _Key {
  themeMode,
  currentLang,

  rememberMe,
  refreshToken,
}

class LocalStorageService {
  Future<LocalStorageService> init() async {
    global.sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }

  setThemeMode(bool data) {
    try {
      global.sharedPreferences!.setBool(_Key.themeMode.toString(), data);
    } catch (err) {
      errorLog("setThemeMode", err.toString());
    }
  }

  setCurrentLanguage(String data) {
    try {
      global.sharedPreferences!.setString(_Key.currentLang.toString(), data);
    } catch (err) {
      errorLog("setCurrentLanguage", err.toString());
    }
  }

  String? get refreshToken {
    final token = global.sharedPreferences!.getString(_Key.refreshToken.toString());
    if (token == null) {
      return null;
    }
    return token;
  }

  setRefreshToken(String? value) {
    if (value != null) {
      global.sharedPreferences!.setString(_Key.refreshToken.toString(), value);
    } else {
      global.sharedPreferences?.remove(_Key.refreshToken.toString());
    }
  }

  clearPreferences() {
    final userCredentialsJson = global.sharedPreferences!.getString(_Key.rememberMe.toString());
    global.sharedPreferences!.clear();
    if (userCredentialsJson != null) {
      global.sharedPreferences!.setString(_Key.rememberMe.toString(), userCredentialsJson);
    }
  }

  String? get getCurrentLanguage {
    try {
      String? currentLang = global.sharedPreferences!.getString(_Key.themeMode.toString());
      if (currentLang == null) {
        return null;
      }

      return currentLang;
    } catch (err) {
      errorLog("getThemeMode", err.toString());
    }
    return null;
  }

  bool? get geThemeMode {
    try {
      bool? currentTheme = global.sharedPreferences!.getBool(_Key.themeMode.toString());
      if (currentTheme == null) {
        return null;
      }

      return currentTheme;
    } catch (err) {
      errorLog("getThemeMode", err.toString());
    }
    return null;
  }

  errorLog(String fun, String err) {
    log("Local Storage $fun  error :- $err");
  }
}
