import 'package:flutter_test_work/models/driver_model.dart';
import 'package:flutter_test_work/resources/api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<List<DriverModel>> fetchDriversList() {
    return _provider.fetchDriversList();
  }
}

class NetworkError extends Error {}
