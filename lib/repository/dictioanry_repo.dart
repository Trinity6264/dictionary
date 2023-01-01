import 'dart:convert';
import 'dart:developer';

import 'package:dictionary/logic/dic_cubit/dictionary_cubit.dart';
import 'package:dictionary/model/dictionary_model.dart';
import 'package:dictionary/model/not_found.dart';
import 'package:dictionary/service/http_service.dart';

class DictionaryRepo {
  Future getData(String val) async {
    final res = await HttpService().searchWord(val);
    if (res.statusCode == 200) {
      final result = wordFoundFromMap(res.body);
      return result;
    } else if (res.statusCode == 404) {
      log('Na today');
      log(res.body);
      final result = WordNotFound.fromJson(res.body);
      return result;
    }
  }
}
