import 'dart:async';
import 'dart:convert';
import 'package:aplikasi_arisan/page/model/detail_lelang_model.dart';
import 'package:aplikasi_arisan/page/model/lelang_disetujui.dart';
import 'package:aplikasi_arisan/page/model/lelang_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' show Client;

final String _url = 'https://api.moneykingdom.org/api';
final storage = FlutterSecureStorage();

class LelangApiProvider {
  Client client = Client();

  Future<LelangModel> fetchLelangList() async {
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
      Response response = await _dio.get('/lelang');
      return LelangModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return LelangModel.withError("Data not found / Connection issue");
    }
  }

  Future<LelangDisetujuiModel> fetchLelangDisetujuiList() async {
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
      Response response = await _dio.get('/lelang/disetujui');
      return LelangDisetujuiModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return LelangDisetujuiModel.withError(
          "Data not found / Connection issue");
    }
  }

  Future<DetailLelangModel> fetchLelangDetailList() async {
    String id = await storage.read(key: 'id_lelang');
    print(id);
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
      Response response = await _dio.get('/lelang/pengajuan/' + id);
      print(response.data);
      return DetailLelangModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return DetailLelangModel.withError("Data not found / Connection issue");
    }
  }

  Future<Map<String, dynamic>> verivikasiLelang(
      String id, String status, String pesan) async {
    String value = await storage.read(key: 'jwt');
    var a = json.encode({
      "status_pengajuan": status,
      "pesan": pesan,
    });
    var response = await client.put(
      Uri.encodeFull("$_url/lelang/pengajuan/" + id),
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

  Future<Map<String, dynamic>> setUsernameLelangTerjual(
      String id, String username) async {
    String value = await storage.read(key: 'jwt');
    var a = json.encode({
      "username": username,
    });
    var response = await client.put(
      Uri.encodeFull("$_url/lelang/username/" + id),
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
}
