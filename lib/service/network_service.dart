import 'dart:convert';
import 'dart:io';

class NetworkService {
  static int regularConnectTimeout = 5000;
  static int regularContentTimeout = 7000;
  static int regularIdleTimeout = 10000;
  static String URL_HOLIDAYS = 'https://api.jiejiariapi.com/v1/holidays/';
  static HttpClient getRegularHttpClient() {
    HttpClient httpClient = HttpClient();
    httpClient.connectionTimeout = Duration(milliseconds: regularConnectTimeout);
    httpClient.idleTimeout = Duration(milliseconds: regularIdleTimeout);
    return httpClient;
  }
  static Future<Set<String>?> getHolidays(int year)async {
    HttpClient httpClient = getRegularHttpClient();
    String responseBody='';
    try{
      HttpClientRequest request = await httpClient.getUrl(Uri.parse('$URL_HOLIDAYS$year'));
      HttpClientResponse response = await request.close();
      responseBody = await response.transform(utf8.decoder).join();
    }on Exception catch(e){
      return null;
    } finally{
      httpClient.close();
    }
    if(responseBody.isEmpty)return null;
    Map<String, dynamic> json = jsonDecode(responseBody);
    Set<String> holidays = json.keys.toSet();
    return holidays;
  }
}