import 'dart:convert';
import 'dart:core';

import 'package:flutter_test_work/models/driver_model.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  static const _url = 'https://jsonplaceholder.typicode.com/users';
  List<DriverModel>? _drivers;

  Future<List<DriverModel>> fetchDriversList() async {
    var response = await http.get(Uri.parse(_url));

    _drivers = [];
    var decodeData = jsonDecode(response.body);
    for (var json in decodeData) {
      _drivers?.add(DriverModel.fromJson(json));
    }

    return _drivers as List<DriverModel>;
  }
}
