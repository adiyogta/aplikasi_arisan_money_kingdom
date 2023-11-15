import 'dart:async';
import 'package:aplikasi_arisan/page/model/arisan_selesai.dart';
import 'package:aplikasi_arisan/page/model/arisan_selesai_detail.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' show Client;

final String _url = 'https://api.moneykingdom.org/api';
final storage = FlutterSecureStorage();

class ArisanSelesaiApiProvider {
  Client client = Client();

  Future<ArisanSelesaiModel> fetchArisanSelesaiList() async {
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
      Response response = await _dio.get('/arisan/selesai');
      print(response.data);
      return ArisanSelesaiModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ArisanSelesaiModel.withError("Data not found / Connection issue");
    }
  }

  Future<ArisanSelesaiDetailModel> fetchArisanSelesaiDetailList() async {
    String id = await storage.read(key: 'id_ArisanSelesai');
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
      Response response = await _dio.get('/arisan/selesai/' + id);
      print(response.data);
      return ArisanSelesaiDetailModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ArisanSelesaiDetailModel.withError(
          "Data not found / Connection issue");
    }
  }
}
