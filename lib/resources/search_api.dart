import 'dart:async';
import 'package:aplikasi_arisan/page/model/search_arisan_ditawarkan.dart';
import 'package:aplikasi_arisan/page/model/search_arisan_berjalan.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' show Client;

final String _url = 'https://api.moneykingdom.org/api';
final storage = FlutterSecureStorage();

class SearchApiProvider {
  Client client = Client();

  Future<SearchArisanDitawarkanModel> fetchSearchArisanDitawarkanList() async {
    String value = await storage.read(key: 'jwt');
    String search = await storage.read(key: 'arisan_ditawarkan');
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
      Response response = await _dio.get('/search/ad/' + search);
      print(response.data);
      return SearchArisanDitawarkanModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return SearchArisanDitawarkanModel.withError(
          "Data not found / Connection issue");
    }
  }

  Future<SearchArisanBerjalanModel> fetchSearchArisanBerjalanList() async {
    String value = await storage.read(key: 'jwt');
    String search = await storage.read(key: 'arisan_berjalan');
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
      Response response = await _dio.get('/search/ab/' + search);
      print(response.data);
      return SearchArisanBerjalanModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return SearchArisanBerjalanModel.withError(
          "Data not found / Connection issue");
    }
  }
}
