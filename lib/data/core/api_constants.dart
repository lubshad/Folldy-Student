import 'package:flutter/foundation.dart';

class ApiConstants {
  ApiConstants._();
  static String get domainUrl => kDebugMode
      ? kIsWeb
          ? "http://localhost"
          // : "http://192.168.29.8"
          : "http://172.20.10.3"
      : "http://143.244.138.169";

  static String get baseUrl =>
      kDebugMode ? "$domainUrl:8000$slugUrl" : domainUrl + slugUrl;
  
  static String domainMediaUrl = kDebugMode ? "$domainUrl:8000" : domainUrl;
  static const String slugUrl = "/folldy_student/api/";
  static const String uploadAudio = "upload_audio";
}

getImageUrl(String url) {
  return ApiConstants.domainUrl + url;
}
