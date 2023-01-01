import 'dart:developer';

import 'package:http/http.dart' as http;

class HttpService {
  static const baseUrl = 'https://api.dictionaryapi.dev/api/v2/entries/en';

  // Get data

  Future<http.Response> searchWord(String life) async {
    log(life);
    final res = await http
        .get(Uri.parse('$baseUrl/$life'))
        .timeout(const Duration(seconds: 10));
    return res;
  }
}
