import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:kap_support_app/src/constants/constants.dart';

import '../model/usermodel.dart';

class ApiService {
  Future<List<Welcome>?> getUsers() async {
    try {
      var url = Uri.parse(Constants.baseUrl);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Welcome> _model = userModelFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}