import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService extends GetxService {
  static SharedPreferences? preferences;
  init() async {
    preferences ??= await SharedPreferences.getInstance();
  }

  static void clearData(key) {
    preferences?.remove(key);
  }

  static void clearAllData() {
    preferences?.clear();
  }

  static void setString(key, value) {
    preferences?.setString(key, value);
  }

  static void setBool(key, value) {
    preferences?.setBool(key, value);
  }

  static void setInt(key, value) {
    preferences?.setInt(key, value);
  }

//get value from shared preferences
  static String? getString(key) {
    String? authToken;
    authToken = preferences?.getString(key);
    return authToken;
  }

  static bool? getBool(key) {
    bool? authToken;
    authToken = preferences?.getBool(key);
    return authToken;
  }

  static int? getInt(key) {
    int? authToken;
    authToken = preferences?.getInt(key);
    return authToken;
  }
}
