import '../../common/utils/shared_pref_utils.dart';

class Endpoints {
  Endpoints._();


  static Map<String, dynamic> getCommonParam() {
    Map<String, dynamic> params = {
      // KEY_DEVICE_ID: getDeviceId(),
    };
    return params;
  }

  // base url uat
   //static const String baseUrl = ""; //UAT
//base url live
    static const String baseUrl = "https://hkdbrothers.com/felicidade/api";//Live

  static const int receiveTimeout = 15; //15000;
  // connectTimeout
  static const int connectionTimeout = 60; //60000;
  static const String user="api_user";
  static const String pwd="api_user";


  static const String languageCode = 'en';
  static const String signIn = '/signin';
  static const String resendOtp = '/resend-otp';
  static const String verifyOtp = '/verify-otp';
  static const String createNewJournal = '/talker/create_new_journal';
  static const String getJournalEntries = '/talker/get_journal_entries';
  static const String saveFeelings = "/talker/save_feeling";

  static const String getDiaryDetail = "/talker/get_diary_detail";
  static const String initialDetails = "/talker/initial-details";
  static const String  nearByTalker=  "/talker/nearby_talker";




}
