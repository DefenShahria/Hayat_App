import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';

import 'network_response.dart';

class Networkcall {

  static Future<Networkresponse> postRequest(
      String url,
      Map<String, dynamic> body, {
        bool islogin = false,
        required Map<String, String> header,
      }) async {

    log('POST Request URL: $url');
    log('Request Body: $body');

    try {
      Response response = await post(
        Uri.parse(url),
        headers: header,
        body: jsonEncode(body),   // ✅ FIXED (must send JSON string)
      );

      log('Status Code: ${response.statusCode}');
      log('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Networkresponse(
            true, response.statusCode, jsonDecode(response.body));
      } else {
        return Networkresponse(false, response.statusCode, null);
      }
    } catch (e) {
      log('Error: $e');
    }
    return Networkresponse(false, -1, null);
  }


  static Future<Networkresponse> getRequest(
      String url, {
        Map<String, String>? header,
        Map<String, String>? body,
      }) async {

    log('GET Request URL: $url');

    try {
      // GET cannot have body → so we convert "body" into query parameters
      final Uri uri = (body != null)
          ? Uri.parse(url).replace(queryParameters: body)
          : Uri.parse(url);

      Response response = await get(
        uri,
        headers: header,
      );

      log('Status Code: ${response.statusCode}');
      log('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return Networkresponse(
            true, response.statusCode, jsonDecode(response.body));
      } else {
        return Networkresponse(false, response.statusCode, null);
      }
    } catch (e) {
      log('Error: $e');
    }

    return Networkresponse(false, -1, null);
  }
}
