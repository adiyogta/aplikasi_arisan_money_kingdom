import 'dart:async';
import 'package:aplikasi_arisan/page/model/arisan_ditawarkan_model.dart';
import 'package:aplikasi_arisan/page/model/detail_arisan_ditawarkan_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

final String _url = 'https://api.moneykingdom.org/api';
final storage = FlutterSecureStorage();

class ArisanDitawarkanApiProvider {
  Client client = Client();

  Future<ArisanDitawarkanList> fetchArisanDitawarkanList() async {
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
      Response response = await _dio.get('/arisan/ditawarkan');
      return ArisanDitawarkanList.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ArisanDitawarkanList.withError(
          "Data not found / Connection issue");
    }
  }

  Future<DetailArisanDitawarkan> fetchArisanDitawarkanDetailList() async {
    String id = await storage.read(key: 'id_arisanDitawarkan');
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
      Response response = await _dio.get('/arisan/ditawarkan/' + id);
      print(response.data);
      return DetailArisanDitawarkan.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return DetailArisanDitawarkan.withError(
          "Data not found / Connection issue");
    }
  }

  Future<Map<String, dynamic>> attemptBuatArisanDitawarkan(
      String nama, int paketArisan) async {
    String value = await storage.read(key: 'jwt');

    var res = await client.post(Uri.encodeFull("$_url/arisan"),
        body: json.encode({
          "nama": nama,
          "paket_id": paketArisan,
        }),
        headers: {
          "Authorization": "Bearer $value",
          'Content-Type': 'application/json; charset=UTF-8',
        });
    Map<String, dynamic> result = json.decode(res.body);
    result['status_code'] = res.statusCode;

    return result;
  }

  Future<Map<String, dynamic>> updateADD(
      String id, String status, String pesan) async {
    String value = await storage.read(key: 'jwt');

    var response = await client.put(
      Uri.encodeFull("$_url/status/validasi"),
      headers: {
        "Authorization": "Bearer $value",
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        "id": id,
        "status": status,
        "pesan": pesan,
      }),
    );
    print(response.body);
    // parsing JSOn or throwing an exception
    Map<String, dynamic> result = json.decode(response.body);
    result['status_code'] = response.statusCode;

    return result;
  }

  Future<Map<String, dynamic>> mulaiAD(
    String id,
    String tgl,
    String status,
  ) async {
    String value = await storage.read(key: 'jwt');
    // String id = await storage.read(key: 'id_arisanDitawarkan');

    print(id);
    var a = json.encode({
      "start_arisan": tgl,
      "status": status,
    });
    var response = await client.put(
      Uri.encodeFull("$_url/arisan/$id"),
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
