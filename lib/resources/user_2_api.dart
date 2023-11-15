import 'dart:async';
import 'package:aplikasi_arisan/page/model/admin_me_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' show Client;

final String _url = 'https://api.moneykingdom.org/api';
final storage = FlutterSecureStorage();

class UserApiProvider2 {
  Client client = Client();

  Future<AdminModel> fetchAdmin() async {
    String value = await storage.read(key: 'jwt');
    final Dio _dio = Dio(
      BaseOptions(
        baseUrl: _url,
        headers: {
          "Authorization": "Bearer $value",
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ),
    );
    try {
      Response response = await _dio.get('/admin/me');
      print(response.data);
      return AdminModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return AdminModel.withError("Data not found / Connection issue");
    }
  }
}
