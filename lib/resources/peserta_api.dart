import 'dart:async';
import 'package:aplikasi_arisan/page/model/peserta_detail_model.dart';
import 'package:aplikasi_arisan/page/model/peserta_model.dart';
import 'package:aplikasi_arisan/page/model/search_peserta.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

final String _url = 'https://api.moneykingdom.org/api';
final storage = FlutterSecureStorage();

class PesertaApiProvider {
  Client client = Client();

  Future<PesertaModel> fetchPesertaList() async {
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
      Response response = await _dio.get('/peserta');
      return PesertaModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return PesertaModel.withError("Data not found / Connection issue");
    }
  }

  Future<SearchPesertaModel> fetchSearchPesertaList() async {
    String value = await storage.read(key: 'jwt');
    String search = await storage.read(key: 'peserta');
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
      Response response = await _dio.get('/search/peserta/' + search);
      print(response.data);
      return SearchPesertaModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return SearchPesertaModel.withError("Data not found / Connection issue");
    }
  }

  Future<DetailPesertaModel> fetchPesertaDetailList() async {
    String id = await storage.read(key: 'id_peserta');

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
      Response response = await _dio.get('/peserta/' + id);
      print(response.data);
      return DetailPesertaModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return DetailPesertaModel.withError("Data not found / Connection issue");
    }
  }

  Future<Map<String, dynamic>> hapusPeserta(
    String id,
  ) async {
    String value = await storage.read(key: 'jwt');

    var response = await client.delete(
      Uri.encodeFull("$_url/peserta/" + id),
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

  Future<Map<String, dynamic>> banPeserta(
    String id,
  ) async {
    String value = await storage.read(key: 'jwt');

    var response = await client.put(
      Uri.encodeFull("$_url/peserta/ban"),
      body: json.encode({
        "id": id,
      }),
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

  Future<Map<String, dynamic>> ubahRank(
    String id,
    String rank,
  ) async {
    String value = await storage.read(key: 'jwt');

    var response = await client.put(
      Uri.encodeFull("$_url/peserta/rank"),
      body: json.encode({
        "id": id,
        "rank": rank,
      }),
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
