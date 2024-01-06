import 'dart:convert';
import 'dart:io';

class NetworkService {
  static String URL_HOLIDAYS = 'https://api.jiejiariapi.com/v1/holidays/';
  static Future<List<String>?> getHolidays(int year)async {
    HttpClient httpClient = HttpClient();
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(URL_HOLIDAYS + year.toString()));
    HttpClientResponse response = await request.close();
    String responseBody = await response.transform(utf8.decoder).join();
    httpClient.close();
    List<String> holidays = [];
    if(responseBody.isEmpty)return null;
    Map<String, String> json = jsonDecode(responseBody);
    List<String> keys = json.keys.toList();
    return keys;
  }
}