import 'dart:convert' show utf8, base64;

import 'package:encrypt/encrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension Encrypt on String {
  String crypt() {
    final key = Key.fromBase64("L95tpBlMvHAiO3EOQyRYYlN7Z6m9VwTnOLyU61kJmqI=");
    final iv = IV.fromBase64("KNZ7uVL/PrGhrEouGUCnrA==");
    return Encrypter(AES(key)).encrypt(this, iv: iv).base64;
  }

  String deCrypt() {
    final key = Key.fromBase64("L95tpBlMvHAiO3EOQyRYYlN7Z6m9VwTnOLyU61kJmqI=");
    final iv = IV.fromBase64("KNZ7uVL/PrGhrEouGUCnrA==");
    return Encrypter(AES(key)).decrypt(Encrypted.from64(this), iv: iv);
  }

  String toBase64() {
    var base = base64.encode(utf8.encode(this));
    return base.substring(0, base.length - 2);
  }
}

class SecureStorage {
  SecureStorage._privateConstructor();

  static final SecureStorage _instance = SecureStorage._privateConstructor();

  static SecureStorage get instance => _instance;

  Future<bool> writeSecureData(
      {required String key, required String? value}) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.reload();
    if (value?.isNotEmpty == true) {
      return sharedPreferences.setString(key.toBase64(), value!.crypt());
    } else {
      return sharedPreferences.setString(key.toBase64(), "");
    }
  }

  Future<String> readSecureData({required String key}) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.reload();
    var result = sharedPreferences.getString(key.toBase64());
    if (result != null && result.isNotEmpty) {
      return result.deCrypt();
    } else {
      return "";
    }
  }

  Future<bool> deleteSecureData({required String key}) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.reload();
    return sharedPreferences.remove(key.toBase64());
  }

  Future<bool> deleteAll() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.clear();
  }
}
