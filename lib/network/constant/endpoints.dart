import '../../common/utils/shared_pref_utils.dart';

class Endpoints {
  Endpoints._();


  static Map<String, dynamic> getCommonParam() {
    Map<String, dynamic> params = {
      KEY_DEVICE_ID: getDeviceId(),
    };
    return params;
  }

  // base url uat
   //static const String baseUrl = ""; //UAT
//base url live
    static const String baseUrl = "https://hkdbrothers.com/felicidade/api/talker";//Live

  static const int receiveTimeout = 15; //15000;
  // connectTimeout
  static const int connectionTimeout = 60; //60000;
  static const String user="api_user";
  static const String pwd="api_user";


  static const String languageCode = 'en';
  static const String loginMobile = '/mobile-login';

}
