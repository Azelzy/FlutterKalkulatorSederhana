import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  // Keys
  static const String keyToken = 'token';
  static const String keyUsername = 'username';

  // ========== SAVE DATA ==========
  
  /// Simpan token
  static Future<bool> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(keyToken, token);
  }

  /// Simpan username
  static Future<bool> saveUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(keyUsername, username);
  }

  /// Simpan login data (token + username)
  static Future<bool> saveLoginData(String token, String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyToken, token);
    await prefs.setString(keyUsername, username);
    return true;
  }

  // ========== GET DATA ==========
  
  /// Ambil token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyToken);
  }

  /// Ambil username
  static Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyUsername);
  }

  /// Cek apakah user sudah login (ada token)
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(keyToken);
    return token != null && token.isNotEmpty;
  }

  // ========== DELETE DATA ==========
  
  /// Hapus token
  static Future<bool> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(keyToken);
  }

  /// Hapus username
  static Future<bool> removeUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(keyUsername);
  }

  /// Hapus semua data login
  static Future<bool> clearLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyToken);
    await prefs.remove(keyUsername);
    return true;
  }

  /// Hapus semua data di SharedPreferences
  static Future<bool> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }

  // ========== DEBUG ==========
  
  /// Print semua data di SharedPreferences
  static Future<void> printAll() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    
    print('\n========== SHARED PREFERENCES ==========');
    if (keys.isEmpty) {
      print('No data stored');
    } else {
      for (var key in keys) {
        final value = prefs.get(key);
        print('$key: $value');
      }
    }
    print('========================================\n');
  }
}