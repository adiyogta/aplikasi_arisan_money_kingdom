import 'dart:async';
import 'package:aplikasi_arisan/page/model/admin_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

final String _url = 'https://api.moneykingdom.org/api';
final storage = FlutterSecureStorage();

class AdminApiProvider {
  Client client = Client();

  Future<ListAdminModel> fetchAdminList() async {
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
      Response response = await _dio.get('/admin');
      return ListAdminModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ListAdminModel.withError("Data not found / Connection issue");
    }
  }

  Future<Map<String, dynamic>> attemptTambahAdmin(
    String nama,
    String username,
    String password,
  ) async {
    String value = await storage.read(key: 'jwt');

    var res = await client.post(Uri.encodeFull("$_url/admin/register"),
        body: json.encode({
          "nama": nama,
          "username": username,
          "password": password,
        }),
        headers: {
          "Authorization": "Bearer $value",
          'Content-Type': 'application/json; charset=UTF-8',
        });
    Map<String, dynamic> result = json.decode(res.body);
    result['status_code'] = res.statusCode;
    print(res.body);
    return result;
  }

  Future<Map<String, dynamic>> updateAdmin(
    String id,
    String password,
  ) async {
    String value = await storage.read(key: 'jwt');
    var a = json.encode({
      "password": password,
    });
    var response = await client.put(
      Uri.encodeFull("$_url/admin/" + id),
      headers: {
        "Authorization": "Bearer $value",
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: a,
    );
    print(response.body);
    print(a);
    // parsing JSOn or throwing an exception
    Map<String, dynamic> result = json.decode(response.body);
    result['status_code'] = response.statusCode;

    return result;
  }

  Future<Map<String, dynamic>> hapusAdmin(
    String id,
  ) async {
    String value = await storage.read(key: 'jwt');

    var response = await client.delete(
      Uri.encodeFull("$_url/admin/" + id),
      headers: {
        "Authorization": "Bearer $value",
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.body);

    // parsing JSOn or throwing an exception
    Map<String, dynamic> result = json.decode(response.body);
    result['status_code'] = response.statusCode;

    return result;
  }
}
