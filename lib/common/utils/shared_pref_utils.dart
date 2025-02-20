// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:felicidade/common/utils/sp_util.dart';

import '../../main.dart';
import '../../network/model/login_model.dart';
import 'package:crypto/crypto.dart';


const String KEY_SETTINGS = "settings";
const String KEY_MESSAGES = "messages";
const String KEY_USER = "login_user";
const String KEY_IS_FIRST_TIME = "is_first_time";
const String SETTING_USER = "setting_user";
const String KEY_JWT_TOKEN = "token";
const String KEY_FCM_TOKEN = "fcmToken";
const String KEY_USER_LOCATION_DISABLE = "locationdisable";
// String? data = await storage?.read(key: );
const String ACCESS_TOKEN = "access_token";
const String VEHICLE_Id = "vehicle_id";
const String KEY_DEVICE_MODEL = "device_model";
const String KEY_DEVICE_ID = "device_id";

Future<void> setUser(User? user) async {
  return await storage?.write(key: KEY_USER, value: jsonEncode(user));
}


void onLogout() async {
  setUser(null);
  setUserAskLocationPermmission(true);
  storage?.delete(key: KEY_USER);
  storage?.delete(key: SETTING_USER);
}

/// User
void setUserAskLocationPermmission(bool value) {
  SpUtil.putBool(KEY_USER_LOCATION_DISABLE, value);
}

getUserAskLocationPermmission() {
  return SpUtil.getBool(KEY_USER_LOCATION_DISABLE, defValue: true);
}

/// FCM
void setFCMToken(String fcmToken) {
  SpUtil.putString(KEY_FCM_TOKEN, fcmToken);
}

getFCMToken() {
  return SpUtil.getString(KEY_FCM_TOKEN, defValue: "");
}

void setIsFirsTime(bool value) {
  SpUtil.putBool(KEY_IS_FIRST_TIME, value);
}

 getIsFirsTime() {
  return SpUtil.getBool(KEY_IS_FIRST_TIME, defValue: true);
}



Future<User?> getUser() async {
  var temp = await storage?.containsKey(key: KEY_USER);
  if (temp == true) {
    String? data = await storage?.read(key: KEY_USER) ?? "";
    if (data == "" || (data == "null")) {
      return null;
    } else {
      return User.fromJson(jsonDecode(data));
    }
  } else {
    return null;
  }
}





/// JWT Token

Future<String?> getToken() async {
  String user =await SpUtil.getString(ACCESS_TOKEN);
  if (user != "") {
    return user;
  } else {
    return "";
  }
}

Future<void> setToken(String token) async {
  await SpUtil.putString(ACCESS_TOKEN, token);
}

Future<void> setDeviceModel(String token) async {
  await SpUtil.putString(KEY_DEVICE_MODEL, token);
}

Future<void> setDeviceId(String id) async {
  await SpUtil.putString(KEY_DEVICE_ID, id);
}

String getDeviceId() {
  return SpUtil.getString(KEY_DEVICE_ID, defValue: KEY_DEVICE_ID);
}

Future<String> getUniqueUserId() async {
  String? deviceID;
  final deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    final iosDeviceInfo = await deviceInfo.iosInfo;
    deviceID = iosDeviceInfo.identifierForVendor; // unique ID on iOS
  } else if (Platform.isAndroid) {
    final androidDeviceInfo = await deviceInfo.androidInfo;
    deviceID = androidDeviceInfo.id; // unique ID on Android
  }

  if (deviceID != null && deviceID.length < 4) {
    if (Platform.isAndroid) {
      deviceID += '_android';
    } else if (Platform.isIOS) {
      deviceID += '_ios___';
    }
  }
  if (Platform.isAndroid) {
    deviceID ??= 'flutter_user_id_android';
  } else if (Platform.isIOS) {
    deviceID ??= 'flutter_user_id_ios';
  }

  final userID = md5
      .convert(utf8.encode(deviceID!))
      .toString()
      .replaceAll(RegExp(r'[^0-9]'), '');
  return userID.substring(userID.length - 6);
}

String getDeviceModel() {
  return SpUtil.getString(KEY_DEVICE_MODEL, defValue: "");
}






/// User
