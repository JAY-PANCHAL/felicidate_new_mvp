class Endpoints {
  Endpoints._();
  // base url uat
   //static const String baseUrl = ""; //UAT
//base url live
    static const String baseUrl = "";//Live

  // receiveTimeout
  static const int receiveTimeout = 250000;

  // connectTimeout
  static const int connectionTimeout = 250000;
  static const String user="api_user";
  static const String pwd="api_user";


  static const String languageCode = 'en';
  static const String login = '/user/login';
  static const String token = '/request/token';
  static const String getUser ="/get-user-details/";


}
